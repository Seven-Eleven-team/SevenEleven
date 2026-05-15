package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "NOTIFICATION_LOGS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class NotificationLog {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_notification_logs_gen")
    @SequenceGenerator(name = "seq_notification_logs_gen", sequenceName = "SEQ_NOTIFICATION_LOGS", allocationSize = 1)
    @Column(name = "LOG_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    @Column(name = "TYPE", nullable = false, length = 30)
    private String type;

    @Column(name = "CONTENT", nullable = false, length = 4000)
    private String content;

    @Column(name = "IS_SUCCESS", nullable = false, length = 1)
    private String isSuccess;

    @Column(name = "FAIL_REASON", length = 4000)
    private String failReason;

    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;
}