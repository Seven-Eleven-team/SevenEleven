package com.bu.jichulmate.dto.party;

import com.bu.jichulmate.domain.PartyPost;
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

    public PartyPostResponse(PartyPost post) {
        this.partyId = post.getId();
        this.sellerId = post.getSeller().getUserId();
        this.ottCategory = post.getService().getServiceCategory();
        this.shareId = post.getShareId();
        this.sharePassword = post.getSharePassword();
        this.monthlyPrice = post.getMonthlyPrice();
        this.description = post.getDescription();
        this.status = post.getStatus();
        this.createdAt = post.getCreatedAt();
    }
}