package com.bu.jichulmate.party.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "PARTY_POSTS")
public class PartyPost {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "party_posts_seq")
    @SequenceGenerator(name = "party_posts_seq", sequenceName = "PARTY_POSTS_SEQ", allocationSize = 1)
    @Column(name = "PARTY_ID")
    private Long partyId;

    @Column(name = "SELLER_ID", nullable = false)
    private Long sellerId;

    @Column(name = "OTT_CATEGORY", nullable = false)
    private String ottCategory;

    @Column(name = "SHARE_ID", nullable = false)
    private String shareId;

    @Column(name = "SHARE_PASSWORD", nullable = false)
    private String sharePassword;

    @Column(name = "MONTHLY_PRICE", nullable = false)
    private Integer monthlyPrice;

    @Column(name = "DESCRIPTION", length = 4000)
    private String description;

    @Column(name = "STATUS", nullable = false)
    private String status;

    @Column(name = "CREATED_AT", nullable = false, updatable = false)
    private LocalDate createdAt;

    @Column(name = "UPDATED_AT")
    private LocalDate updatedAt;

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDate.now();
        if (this.status == null) this.status = "RECRUITING";
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDate.now();
    }

    public void create(Long sellerId, String ottCategory, String shareId,
                       String sharePassword, Integer monthlyPrice, String description) {
        this.sellerId = sellerId;
        this.ottCategory = ottCategory;
        this.shareId = shareId;
        this.sharePassword = sharePassword;
        this.monthlyPrice = monthlyPrice;
        this.description = description;
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