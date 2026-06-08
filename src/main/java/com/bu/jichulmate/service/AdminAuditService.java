package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.AdminAuditLog;
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.admin.AdminAuditLogResponse;
import com.bu.jichulmate.repository.AdminAuditLogRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminAuditService {

    private final AdminAuditLogRepository adminAuditLogRepository;

    // 1. 관리자 활동 로그 전체 조회 (최신순)
    @Transactional(readOnly = true)
    public List<AdminAuditLogResponse> getAuditLogs() {
        return adminAuditLogRepository.findAllByOrderByCreatedAtDesc().stream()
                .map(AdminAuditLogResponse::fromEntity)
                .collect(Collectors.toList());
    }

    // 2.  활동 로그 저장 메서드
    @Transactional
    public void recordLog(User admin, String actionType, String targetTable, Long targetId, String ipAddress) {
        AdminAuditLog log = AdminAuditLog.builder()
                .admin(admin)
                .actionType(actionType)
                .targetTable(targetTable)
                .targetId(targetId)
                .ipAddress(ipAddress)
                .createdAt(LocalDateTime.now()) // ★ 이 줄을 추가해서 직접 시간을 넣어줍니다!
                .build();

        adminAuditLogRepository.save(log);
    }
}