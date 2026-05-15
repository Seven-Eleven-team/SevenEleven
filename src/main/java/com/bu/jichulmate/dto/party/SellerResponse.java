package com.bu.jichulmate.dto.party;

import com.bu.jichulmate.domain.PartySeller;
import java.time.LocalDate;

public class SellerResponse {
    private Long sellerId;
    private Long userId;
    private String name;
    private LocalDate birthDate;
    private String phone;
    private String zipCode;
    private String address;
    private String bankName;
    private String accountNumber;
    private String hasExperience;
    private LocalDate createdAt;

    public SellerResponse(PartySeller seller) {
        this.sellerId = seller.getId();
        this.userId = seller.getUserId();
        this.name = seller.getName();
        this.birthDate = seller.getBirthDate();
        this.phone = seller.getPhone();
        this.zipCode = seller.getZipCode();
        this.address = seller.getAddress();
        this.bankName = seller.getBankName();
        this.accountNumber = seller.getAccountNumber();
        this.hasExperience = seller.getHasExperience();
        this.createdAt = seller.getCreatedAt();
    }

    public Long getSellerId() { return sellerId; }
    public Long getUserId() { return userId; }
    public String getName() { return name; }
    public LocalDate getBirthDate() { return birthDate; }
    public String getPhone() { return phone; }
    public String getZipCode() { return zipCode; }
    public String getAddress() { return address; }
    public String getBankName() { return bankName; }
    public String getAccountNumber() { return accountNumber; }
    public String getHasExperience() { return hasExperience; }
    public LocalDate getCreatedAt() { return createdAt; }
}