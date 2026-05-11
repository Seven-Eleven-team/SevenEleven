package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "SUBSCRIPTIONS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Subscription {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sub_seq")
    @SequenceGenerator(name = "sub_seq", sequenceName = "SUB_SEQ", allocationSize = 1)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user; // findByUser... 와 매칭

    @Column(nullable = false)
    private String serviceName;

    @Column(nullable = false)
    private String status = "ACTIVE"; // findByUserAndStatus... 와 매칭

    @Column(nullable = false)
    private long monthlyFee;

    @Column(name = "next_billing_date")
    private LocalDate nextBillingDate;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt; // OrderByCreatedAtDesc 와 매칭

    // 상세 정보 (Detail DTO용)
    private String serviceLogo;
    private String orderCode;
    private String chargeTimeline;
    private String chargeDateTime;
    private String accountStatus;
    private String paymentMethod;
    private String ottUserId;
    private LocalDate startDate;
    private String cancelUrl;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
}
