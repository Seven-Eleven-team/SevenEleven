package com.bu.jichulmate.dto.subscription;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SubscriptionCreateRequest {

    private Long partyId;

    private Long accountId;

    private Integer monthlyFee;

    private Integer periodMonths;
}