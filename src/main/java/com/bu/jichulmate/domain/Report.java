package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "REPORTS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Report {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "report_seq")
    @SequenceGenerator(name = "report_seq", sequenceName = "REPORT_SEQ", allocationSize = 1)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reporter_id", nullable = false)
    private User reporter; // findByReporter... 와 매칭 (중요!)

    @Column(nullable = false)
    private String targetType; // "SUBSCRIPTION" 등

    @Column(nullable = false)
    private Long targetId;

    @Column(columnDefinition = "CLOB", nullable = false)
    private String reportReason;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt; // OrderByCreatedAtDesc 와 매칭

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
}
