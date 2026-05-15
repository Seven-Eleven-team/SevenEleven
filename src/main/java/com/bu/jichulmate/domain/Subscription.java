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
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_subscriptions_gen")
    @SequenceGenerator(name = "seq_subscriptions_gen", sequenceName = "SEQ_SUBSCRIPTIONS", allocationSize = 1)
    @Column(name = "SUB_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PARTY_ID", nullable = false)
    private PartyPost party;

    @Column(name = "MONTHLY_FEE", nullable = false)
    private long monthlyFee;

    @Column(name = "TOTAL_AMOUNT", nullable = false)
    private long totalAmount;

    @Column(name = "PERIOD_MONTHS", nullable = false)
    private int periodMonths;

    @Column(name = "START_DATE", nullable = false)
    private LocalDate startDate;

    @Column(name = "END_DATE", nullable = false)
    private LocalDate endDate;

    @Column(name = "NEXT_PAY_DATE")
    private LocalDate nextPayDate;

    @Builder.Default
    @Column(name = "STATUS", nullable = false)
    private String status = "ACTIVE";

    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
}