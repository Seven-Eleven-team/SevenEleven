package com.bu.jichulmate.dto.subscription;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SubscriptionCreateRequest {

    // 어떤 OTT 서비스 선택했는지
    private Long partyId;

    // 월 요금
    private Integer monthlyFee;

    // 구독 개월 수
    private Integer periodMonths;
}