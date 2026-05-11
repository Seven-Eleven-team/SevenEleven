package com.bu.jichulmate.dto.party;

import com.bu.jichulmate.domain.PartyPost;
import java.time.LocalDate;

public class PartyDetailResponse {
    private Long partyId;
    private Long sellerId;
    private String ottCategory;
    private String shareId;
    private String sharePassword;
    private Integer monthlyPrice;
    private String description;
    private String status;
    private LocalDate createdAt;
    private LocalDate updatedAt;

    public PartyDetailResponse(PartyPost post) {
        this.partyId = post.getPartyId();
        this.sellerId = post.getSellerId();
        this.ottCategory = post.getOttCategory();
        this.shareId = post.getShareId();
        this.sharePassword = post.getSharePassword();
        this.monthlyPrice = post.getMonthlyPrice();
        this.description = post.getDescription();
        this.status = post.getStatus();
        this.createdAt = post.getCreatedAt();
        this.updatedAt = post.getUpdatedAt();
    }

    public Long getPartyId() { return partyId; }
    public Long getSellerId() { return sellerId; }
    public String getOttCategory() { return ottCategory; }
    public String getShareId() { return shareId; }
    public String getSharePassword() { return sharePassword; }
    public Integer getMonthlyPrice() { return monthlyPrice; }
    public String getDescription() { return description; }
    public String getStatus() { return status; }
    public LocalDate getCreatedAt() { return createdAt; }
    public LocalDate getUpdatedAt() { return updatedAt; }
}