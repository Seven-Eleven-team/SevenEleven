package com.bu.jichulmate.dto.party;

import java.time.LocalDate;

public class SellerRequest {
    private Long userId;
    private String name;
    private LocalDate birthDate;
    private String phone;
    private String zipCode;
    private String address;
    private String bankName;
    private String accountNumber;
    private String hasExperience;

    public Long getUserId() { return userId; }
    public String getName() { return name; }
    public LocalDate getBirthDate() { return birthDate; }
    public String getPhone() { return phone; }
    public String getZipCode() { return zipCode; }
    public String getAddress() { return address; }
    public String getBankName() { return bankName; }
    public String getAccountNumber() { return accountNumber; }
    public String getHasExperience() { return hasExperience; }
}