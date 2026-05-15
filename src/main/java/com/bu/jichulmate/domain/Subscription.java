package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@Entity
@Table(name = "SUBSCRIPTIONS")
public class Subscription {

    @Id
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "subscription_seq"
    )
    @SequenceGenerator(
            name = "subscription_seq",
            sequenceName = "SEQ_SUBSCRIPTIONS",
            allocationSize = 1
    )
    @Column(name = "SUB_ID")
    private Long id;

    // 회원 연관관계
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    // OTT 서비스 ID
    @Column(name = "PARTY_ID", nullable = false)
    private Long partyId;

    // 월 요금
    @Column(name = "MONTHLY_FEE", nullable = false)
    private Integer monthlyFee;

    // 총 결제 금액
    @Column(name = "TOTAL_AMOUNT", nullable = false)
    private Integer totalAmount;

    // 구독 개월 수
    @Column(name = "PERIOD_MONTHS", nullable = false)
    private Integer periodMonths;

    // 구독 시작일
    @Column(name = "START_DATE", nullable = false)
    private LocalDate startDate;

    // 구독 종료일
    @Column(name = "END_DATE", nullable = false)
    private LocalDate endDate;

    // 다음 결제일
    @Column(name = "NEXT_PAY_DATE")
    private LocalDate nextPayDate;

    // 구독 상태
    @Column(name = "STATUS", nullable = false)
    private String status;

    // 생성일
    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;

    // 최초 생성 시 자동 처리
    @PrePersist
    protected void onCreate() {

        // 생성 시간 자동 저장
        this.createdAt = LocalDateTime.now();

        // 상태 기본값
        if (this.status == null) {
            this.status = "ACTIVE";
        }
    }
}