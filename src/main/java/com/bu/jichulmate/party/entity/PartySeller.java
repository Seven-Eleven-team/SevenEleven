package com.bu.jichulmate.party.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "PARTY_SELLERS")
public class PartySeller {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "party_sellers_seq")
    @SequenceGenerator(name = "party_sellers_seq", sequenceName = "PARTY_SELLERS_SEQ", allocationSize = 1)
    @Column(name = "SELLER_ID")
    private Long sellerId;

    @Column(name = "USER_ID", nullable = false)
    private Long userId;

    @Column(name = "NAME", nullable = false)
    private String name;

    @Column(name = "BIRTH_DATE", nullable = false)
    private LocalDate birthDate;

    @Column(name = "PHONE", nullable = false)
    private String phone;

    @Column(name = "ZIP_CODE", nullable = false)
    private String zipCode;

    @Column(name = "ADDRESS", nullable = false)
    private String address;

    @Column(name = "BANK_NAME", nullable = false)
    private String bankName;

    @Column(name = "ACCOUNT_NUMBER", nullable = false)
    private String accountNumber;

    @Column(name = "HAS_EXPERIENCE", nullable = false)
    private String hasExperience;

    @Column(name = "CREATED_AT", nullable = false, updatable = false)
    private LocalDate createdAt;

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDate.now();
        if (this.hasExperience == null) this.hasExperience = "N";
    }

    public void update(Long userId, String name, LocalDate birthDate, String phone,
                       String zipCode, String address, String bankName,
                       String accountNumber, String hasExperience) {
        this.userId = userId;
        this.name = name;
        this.birthDate = birthDate;
        this.phone = phone;
        this.zipCode = zipCode;
        this.address = address;
        this.bankName = bankName;
        this.accountNumber = accountNumber;
        this.hasExperience = hasExperience;
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