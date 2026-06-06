package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.AdminAuditLog;
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.admin.AdminAuditLogResponse;
import com.bu.jichulmate.repository.AdminAuditLogRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    // 2. [참고용] 활동 로그 저장 메서드
    // 나중에 AdminPartyService 등에서 파티를 승인한 직후 이 메서드를 호출해서 기록을 남기면 됩니다!
    @Transactional
    public void recordLog(User admin, String actionType, String targetTable, Long targetId, String ipAddress) {
        AdminAuditLog log = AdminAuditLog.builder()
                .admin(admin)
                .actionType(actionType)
                .targetTable(targetTable)
                .targetId(targetId)
                .ipAddress(ipAddress)
                .build();

        adminAuditLogRepository.save(log);
    }
}