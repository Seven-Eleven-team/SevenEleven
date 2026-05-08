package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "AUTH_TOKENS")
public class PasswordResetToken {

    public static final String TYPE_PASSWORD_RESET = "PWD_RESET";

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "authTokenSeq")
    @SequenceGenerator(
            name = "authTokenSeq",
            sequenceName = "SEQ_AUTH_TOKENS",
            allocationSize = 1
    )
    @Column(name = "TOKEN_ID")
    private Long tokenId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    @Column(name = "TARGET_VALUE")
    private String targetValue;

    @Column(name = "TOKEN_VALUE", nullable = false, unique = true)
    private String tokenValue;

    @Column(name = "TOKEN_TYPE", nullable = false)
    private String tokenType;

    @Column(name = "EXPIRES_AT", nullable = false)
    private LocalDateTime expiresAt;

    @Column(name = "IS_USED", nullable = false)
    private String isUsed = "N";

    @Column(name = "CREATED_AT", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiresAt);
    }

    public boolean isUsed() {
        return "Y".equalsIgnoreCase(isUsed);
    }

    public void markUsed() {
        this.isUsed = "Y";
    }
}