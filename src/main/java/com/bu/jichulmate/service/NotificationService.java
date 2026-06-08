package com.bu.jichulmate.service;

import com.bu.jichulmate.dto.mypage.NotificationResponse;
import com.bu.jichulmate.repository.NotificationLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class NotificationService {

    private final NotificationLogRepository notificationLogRepository;

    // 파라미터에 Pageable 추가, 리턴 타입 Page로 변경
    public Page<NotificationResponse> getMyNotifications(Long userId, Pageable pageable) {
        return notificationLogRepository.findByUser_UserIdAndIsSuccessOrderByCreatedAtDesc(userId, "Y", pageable)
                .map(log -> NotificationResponse.builder()
                        .logId(log.getId())
                        .type(log.getType())
                        .content(log.getContent())
                        .createdAt(log.getCreatedAt())
                        .build()); // Page는 collect(Collectors.toList())가 필요 없습니다!
    }
}