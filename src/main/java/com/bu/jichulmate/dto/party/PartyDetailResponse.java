package com.bu.jichulmate.dto.party;

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

    // ★ 500 에러의 원인 해결! (JSP에서 이 변수를 드디어 찾을 수 있게 됩니다)
    private String rejectReason;

    // ★ 기존 서비스(PartyService) 파일에서 생성자 파라미터 개수 차이로 에러가 나지 않도록 막아주는 방어용 생성자
    public PartyDetailResponse(Long id, Long sellerId, String serviceName, String shareId,
                               String sharePassword, Integer monthlyPrice, Integer saleMonths,
                               String description, String status, LocalDateTime createdAt) {
        this.id = id;
        this.sellerId = sellerId;
        this.serviceName = serviceName;
        this.shareId = shareId;
        this.sharePassword = sharePassword;
        this.monthlyPrice = monthlyPrice;
        this.saleMonths = saleMonths;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
    }
}