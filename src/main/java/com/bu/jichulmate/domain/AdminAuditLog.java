package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Table(name = "ADMIN_AUDIT_LOGS")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class) // 앞서 작성하신 Inquiry.java처럼 생성일 자동 처리를 위해 추가!
public class AdminAuditLog {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_admin_audit_logs_gen")
    @SequenceGenerator(
            name = "seq_admin_audit_logs_gen",
            sequenceName = "SEQ_ADMIN_AUDIT_LOGS",
            allocationSize = 1
    )
    @Column(name = "LOG_ID")
    private Long id;

    // 관리자도 결국 USERS 테이블에 있는 유저이므로 User 엔티티와 연결합니다.
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ADMIN_ID", nullable = false)
    private User admin;

    @Column(name = "ACTION_TYPE", nullable = false, length = 50)
    private String actionType; // 예: "USER_BAN", "PARTY_APPROVE", "FAQ_CREATE"

    @Column(name = "TARGET_TABLE", nullable = false, length = 50)
    private String targetTable; // 예: "USERS", "PARTY_POSTS", "INQUIRIES"

    @Column(name = "TARGET_ID", nullable = false)
    private Long targetId; // 대상의 PK 번호 (어떤 유저를 정지시켰는지, 어떤 파티를 승인했는지)

    @Column(name = "IP_ADDRESS", nullable = false, length = 50)
    private String ipAddress; // 관리자가 접속한 IP 주소

    @CreatedDate
    @Column(name = "CREATED_AT", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    // AdminAuditLog.java 맨 아래에 추가
    @PrePersist
    protected void onCreate() {
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }
    }

}