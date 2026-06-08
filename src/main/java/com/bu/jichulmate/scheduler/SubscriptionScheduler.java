package com.bu.jichulmate.scheduler;

import com.bu.jichulmate.domain.NotificationLog; // DB 14번 테이블 엔티티
import com.bu.jichulmate.domain.Subscription;
import com.bu.jichulmate.repository.NotificationLogRepository; // 알림 기록용
import com.bu.jichulmate.repository.SubscriptionRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class SubscriptionScheduler {

    private final SubscriptionRepository subscriptionRepository;
    private final NotificationLogRepository notificationLogRepository;
    private final JavaMailSender javaMailSender; // 이미 세팅해두신 스프링 메일 발송기!

    // 매일 오전 9시 0분 0초에 자동 실행되는 마법의 주문! (크론 표현식)
    @Scheduled(cron = "0 0 9 * * *") // 0 0 9 * * *
    @Transactional
    public void sendExpirationNotifications() {
        log.info("[스케줄러 작동] 구독 만료 3일 전 알림 발송 프로세스 시작...");

        // 1. 타겟 날짜 계산 (오늘 + 3일)
        LocalDate targetDate = LocalDate.now().plusDays(3);

        // 2. DB에서 3일 뒤 만료되는 활성(ACTIVE) 구독자 목록 싹쓸이
        List<Subscription> targetSubscriptions = subscriptionRepository.findByEndDateAndStatus(targetDate, "ACTIVE");

        if (targetSubscriptions.isEmpty()) {
            log.info("[스케줄러 완료] 오늘 기준 3일 뒤 만료되는 구독 건이 없습니다.");
            return;
        }

        // 3. 한 명씩 꺼내서 메일 보내고 DB에 기록하기
        for (Subscription sub : targetSubscriptions) {
            String userEmail = sub.getUser().getLoginId(); // USERS 테이블의 이메일 아이디
            String serviceName = sub.getParty().getService().getServiceName(); // SubscriptionMaster의 서비스명

            String content = serviceName + " 자동 결제까지 3일 남았습니다.";

            try {
                // [Action A] 실제 이메일 발송!
                sendEmail(userEmail, serviceName, content);

                // [Action B] 마이페이지에 보여주기 위해 DB (NOTIFICATION_LOGS) 에 기록 저장!
                NotificationLog logRecord = NotificationLog.builder()
                        .user(sub.getUser())
                        .type("EMAIL") // 알림 종류
                        .content(content)
                        .isSuccess("Y")
                        .build();
                notificationLogRepository.save(logRecord);

                log.info("성공: {} 님에게 {} 만료 알림 메일 발송 완료", sub.getUser().getNickname(), serviceName);

            } catch (Exception e) {
                // 만약 메일 발송에 실패하더라도 다른 사람들은 받아야 하므로, 에러를 기록만 하고 넘어갑니다.
                log.error("실패: {} 님에게 메일 발송 중 오류 발생", userEmail, e);

                NotificationLog failRecord = NotificationLog.builder()
                        .user(sub.getUser())
                        .type("EMAIL")
                        .content(content)
                        .isSuccess("N")
                        .failReason(e.getMessage()) // 에러 내용 저장
                        .build();
                notificationLogRepository.save(failRecord);
            }
        }
    }

    // 실제 메일을 전송하는 헬퍼 메서드
    private void sendEmail(String toAddress, String serviceName, String content) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toAddress);
        message.setSubject("[지출메이트] " + serviceName + " 구독 만료 안내"); // 메일 제목
        message.setText("안녕하세요, 지출메이트입니다.\n\n" + content + "\n계속 이용하시려면 결제 정보를 확인해 주세요!"); // 메일 본문

        javaMailSender.send(message);
    }
}