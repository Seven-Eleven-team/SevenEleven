package com.bu.jichulmate.response;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PartyDetailResponse {

    private Long id;
    private Long sellerId;
    private String serviceName;
    private String shareId;
    private String sharePassword;
    private Integer monthlyPrice;
    private Integer saleMonths;
    private String description;
    private String status;
    private LocalDateTime createdAt;
}