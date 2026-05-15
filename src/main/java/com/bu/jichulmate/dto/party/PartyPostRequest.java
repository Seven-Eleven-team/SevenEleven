package com.bu.jichulmate.dto.party;

import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class PartyPostRequest {

    private Long sellerId; // 판매자 ID (PartySeller 테이블의 PK)

    // ★ 기존 ottCategory(String) 대신 마스터 테이블의 ID를 받습니다.
    private Long serviceId;

    private String shareId;
    private String sharePassword;
    private Integer monthlyPrice;
    private String description;
}