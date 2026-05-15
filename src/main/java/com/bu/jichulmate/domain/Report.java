package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "REPORTS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Report {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_reports_gen")
    @SequenceGenerator(name = "seq_reports_gen", sequenceName = "SEQ_REPORTS", allocationSize = 1)
    @Column(name = "REPORT_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "REPORTER_ID", nullable = false)
    private User reporter;

    @Column(name = "TARGET_TYPE", nullable = false)
    private String targetType;

    @Column(name = "TARGET_ID", nullable = false)
    private Long targetId;

    @Column(name = "REASON", nullable = false)
    private String reason;

    @Builder.Default
    @Column(name = "STATUS", nullable = false)
    private String status = "WAITING";

    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
}