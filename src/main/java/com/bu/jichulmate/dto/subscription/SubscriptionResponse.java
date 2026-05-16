package com.bu.jichulmate.dto.subscription;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class SubscriptionResponse {

    // 구독 ID
    private Long id;

    // OTT 서비스 ID
    private Long partyId;

    // OTT 서비스 이름
    private String serviceName;

    // 월 요금
    private Integer monthlyFee;

    // 총 결제 금액
    private Integer totalAmount;

    // 구독 개월 수
    private Integer periodMonths;

    // 시작일
    private LocalDate startDate;

    // 종료일
    private LocalDate endDate;

    // 다음 결제일
    private LocalDate nextPayDate;

    // 상태
    private String status;
}