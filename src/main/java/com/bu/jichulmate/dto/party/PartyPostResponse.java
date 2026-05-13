package com.bu.jichulmate.dto.party;

import com.bu.jichulmate.domain.PartyPost; // ★ 완벽한 엔티티 경로
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class PartyPostResponse {
    private Long partyId;
    private Long sellerId;
    private String ottCategory;
    private String shareId;
    private String sharePassword;
    private Integer monthlyPrice;
    private String description;
    private String status;
    private LocalDateTime createdAt;

    // ★ 올려주신 엔티티의 변수명(id, hostUser)에 완벽하게 맞췄습니다!
    public PartyPostResponse(PartyPost post) {
        this.partyId = post.getId();
        this.sellerId = post.getHostUser().getUserId();
        this.ottCategory = post.getOttCategory();
        this.shareId = post.getShareId();
        this.sharePassword = post.getSharePassword();
        this.monthlyPrice = post.getMonthlyPrice();
        this.description = post.getDescription();
        this.status = post.getStatus();
        this.createdAt = post.getCreatedAt();
    }
}