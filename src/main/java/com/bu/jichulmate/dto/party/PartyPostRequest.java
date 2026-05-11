package com.bu.jichulmate.dto.party;

public class PartyPostRequest {
    private Long sellerId;
    private String ottCategory;
    private String shareId;
    private String sharePassword;
    private Integer monthlyPrice;
    private String description;
    private Long userId;
    private String name;
    private String birthDate;
    private String phone;
    private String zipCode;
    private String address;
    private String bankName;
    private String accountNumber;
    private String hasExperience;

    public Long getSellerId() { return sellerId; }
    public String getOttCategory() { return ottCategory; }
    public String getShareId() { return shareId; }
    public String getSharePassword() { return sharePassword; }
    public Integer getMonthlyPrice() { return monthlyPrice; }
    public String getDescription() { return description; }
    public Long getUserId() { return userId; }
    public String getName() { return name; }
    public String getBirthDate() { return birthDate; }
    public String getPhone() { return phone; }
    public String getZipCode() { return zipCode; }
    public String getAddress() { return address; }
    public String getBankName() { return bankName; }
    public String getAccountNumber() { return accountNumber; }
    public String getHasExperience() { return hasExperience; }
}