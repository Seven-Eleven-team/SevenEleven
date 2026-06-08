package com.bu.jichulmate.dto.admin;

import com.bu.jichulmate.domain.AdminAuditLog;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class AdminAuditLogResponse {
    private Long logId;
    private String adminNickname; // 관리자 닉네임 (누가 했는지)
    private String actionType;    // 행동 유형 (예: USER_BAN, PARTY_APPROVE)
    private String targetTable;   // 대상 테이블 (예: USERS, PARTY_POSTS)
    private Long targetId;        // 대상 번호 (어떤 회원을? 어떤 파티를?)
    private String ipAddress;     // 접속 IP
    private LocalDateTime createdAt; // 행동 일시

    // Entity -> DTO 변환
    public static AdminAuditLogResponse fromEntity(AdminAuditLog log) {
        return AdminAuditLogResponse.builder()
                .logId(log.getId())
                // User 객체에서 관리자의 닉네임을 쏙 빼옵니다. (없으면 '알 수 없음')
                .adminNickname(log.getAdmin() != null ? log.getAdmin().getNickname() : "알 수 없음")
                .actionType(log.getActionType())
                .targetTable(log.getTargetTable())
                .targetId(log.getTargetId())
                .ipAddress(log.getIpAddress())
                .createdAt(log.getCreatedAt())
                .build();
    }
}