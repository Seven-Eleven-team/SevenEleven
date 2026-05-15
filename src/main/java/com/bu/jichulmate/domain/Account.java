package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "BANK_ACCOUNTS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_bank_accounts_gen")
    @SequenceGenerator(name = "seq_bank_accounts_gen", sequenceName = "SEQ_BANK_ACCOUNTS", allocationSize = 1)
    @Column(name = "ACCOUNT_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    @Column(name = "BANK_NAME", nullable = false, length = 50)
    private String bankName;

    @Column(name = "ACCOUNT_NUMBER", nullable = false, length = 100)
    private String accountNumber;

    @Builder.Default
    @Column(name = "IS_PRIMARY", nullable = false, length = 1)
    private String isPrimary = "Y";

    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "UPDATED_AT")
    private LocalDateTime updatedAt;
}
