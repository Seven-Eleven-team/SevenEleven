package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "EXPENSES")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Expense {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "exp_seq")
    @SequenceGenerator(name = "exp_seq", sequenceName = "SEQ_EXPENSES", allocationSize = 1)
    @Column(name = "EXPENSE_ID")
    private Long id;

    // TODO: User 엔티티 생성 후 주석 해제 (연관관계 LAZY 필수)
    // @ManyToOne(fetch = FetchType.LAZY)
    // @JoinColumn(name = "USER_ID", nullable = false)
    // private User user;
    @Column(name = "USER_ID", nullable = false) // User 엔티티 생성 전까지 임시 사용
    private Long userId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CATEGORY_ID", nullable = false)
    private Category category;

    @Column(name = "AMOUNT", nullable = false)
    private Long amount;

    @Column(name = "EXPENSE_DATE", nullable = false)
    private LocalDate expenseDate;

    @Column(name = "IS_FIXED", nullable = false, length = 1)
    private String isFixed = "N";

    @Column(name = "UPDATED_AT")
    private LocalDateTime updatedAt;

    @Builder
    public Expense(Long userId, Category category, Long amount, LocalDate expenseDate, String isFixed) {
        this.userId = userId;
        this.category = category;
        this.amount = amount;
        this.expenseDate = expenseDate;
        this.isFixed = isFixed != null ? isFixed : "N";
    }

    // 수정 메서드 (더티 체킹용)
    public void updateExpense(Category category, Long amount, LocalDate expenseDate, String isFixed) {
        this.category = category;
        this.amount = amount;
        this.expenseDate = expenseDate;
        this.isFixed = isFixed;
        this.updatedAt = LocalDateTime.now();
    }
}