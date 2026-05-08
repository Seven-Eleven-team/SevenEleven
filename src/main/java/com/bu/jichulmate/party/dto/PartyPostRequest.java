package com.bu.jichulmate.party.dto;

public class PartyPostRequest {
    private Long sellerId;
    private String ottCategory;
    private String shareId;
    private String sharePassword;
    private Integer monthlyPrice;
    private String description;

    public Long getSellerId() { return sellerId; }
    public String getOttCategory() { return ottCategory; }
    public String getShareId() { return shareId; }
    public String getSharePassword() { return sharePassword; }
    public Integer getMonthlyPrice() { return monthlyPrice; }
    public String getDescription() { return description; }
}