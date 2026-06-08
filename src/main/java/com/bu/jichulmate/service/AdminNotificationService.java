package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.NotificationLog;
import com.bu.jichulmate.dto.admin.NotificationLogResponse;
import com.bu.jichulmate.repository.NotificationLogRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminNotificationService {

    private final NotificationLogRepository notificationLogRepository;

    // 1. 전체 알림 발송 내역 조회
    @Transactional(readOnly = true)
    public List<NotificationLogResponse> getAllNotificationLogs() {
        return notificationLogRepository.findAll().stream()
                .map(NotificationLogResponse::fromEntity)
                .collect(Collectors.toList());
    }
}