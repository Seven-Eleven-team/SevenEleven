package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Subscription;
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.subscription.SubscriptionCreateRequest;
import com.bu.jichulmate.dto.subscription.SubscriptionResponse;
import com.bu.jichulmate.repository.SubscriptionRepository;
import com.bu.jichulmate.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SubscriptionService {

    private final SubscriptionRepository subscriptionRepository;
    private final UserRepository userRepository;

    // 구독 등록
    public void createSubscription(
            Long userId,
            SubscriptionCreateRequest request
    ) {

        // 회원 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() ->
                        new RuntimeException("회원 없음"));

        // 시작일
        LocalDate startDate = LocalDate.now();

        // 종료일 계산
        LocalDate endDate =
                startDate.plusMonths(
                        request.getPeriodMonths()
                );

        // 총 결제 금액 계산
        Integer totalAmount =
                request.getMonthlyFee()
                        * request.getPeriodMonths();

        // 구독 객체 생성
        Subscription subscription = new Subscription();

        // 회원 저장
        subscription.setUser(user);

        // OTT 서비스 ID 저장
        subscription.setPartyId(
                request.getPartyId()
        );

        // 월 요금
        subscription.setMonthlyFee(
                request.getMonthlyFee()
        );

        // 총 결제 금액
        subscription.setTotalAmount(
                totalAmount
        );

        // 구독 개월 수
        subscription.setPeriodMonths(
                request.getPeriodMonths()
        );

        // 시작일
        subscription.setStartDate(
                startDate
        );

        // 종료일
        subscription.setEndDate(
                endDate
        );

        // 다음 결제일
        subscription.setNextPayDate(
                endDate
        );

        // 상태
        subscription.setStatus(
                "ACTIVE"
        );

        // 저장
        subscriptionRepository.save(subscription);
    }

    // 내 구독 목록 조회
    public List<SubscriptionResponse> getMySubscriptions(
            Long userId
    ) {

        return subscriptionRepository
                .findByUserUserId(userId)
                .stream()
                .map(subscription -> {

                    SubscriptionResponse res =
                            new SubscriptionResponse();

                    // 구독 ID
                    res.setId(
                            subscription.getId()
                    );

                    // OTT 서비스 ID
                    res.setPartyId(
                            subscription.getPartyId()
                    );

                    // 월 요금
                    res.setMonthlyFee(
                            subscription.getMonthlyFee()
                    );

                    // 총 결제 금액
                    res.setTotalAmount(
                            subscription.getTotalAmount()
                    );

                    // 구독 개월 수
                    res.setPeriodMonths(
                            subscription.getPeriodMonths()
                    );

                    // 시작일
                    res.setStartDate(
                            subscription.getStartDate()
                    );

                    // 종료일
                    res.setEndDate(
                            subscription.getEndDate()
                    );

                    // 다음 결제일
                    res.setNextPayDate(
                            subscription.getNextPayDate()
                    );

                    // 상태
                    res.setStatus(
                            subscription.getStatus()
                    );

                    return res;
                })
                .toList();
    }
}