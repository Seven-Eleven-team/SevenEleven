package com.bu.jichulmate.dto.party;

import com.bu.jichulmate.domain.PartyPost;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PartyPostResponse {
    private Long partyId;
    private Long sellerId;
    private String serviceName;
    private String shareId;
    private String sharePassword;
    private Integer monthlyPrice;
    private Integer totalSlots;
    private Integer occupiedSlots;
    private String description;
    private String status;
    private LocalDateTime createdAt;

    public PartyPostResponse(PartyPost post) {
        this.partyId = post.getId();
        // ★ 에러 원인 해결: PartySeller의 PK 필드명은 'id'이므로 getId()를 사용해야 합니다!
        this.sellerId = post.getSeller().getId();
        // ★ 서비스 마스터에서 이름 가져오기
        this.serviceName = post.getService().getServiceName();
        this.shareId = post.getShareId();
        this.sharePassword = post.getSharePassword();
        this.monthlyPrice = post.getMonthlyPrice();
        this.totalSlots = post.getTotalSlots();
        this.occupiedSlots = post.getOccupiedSlots();
        this.description = post.getDescription();
        this.status = post.getStatus();
        this.createdAt = post.getCreatedAt();
    }
}