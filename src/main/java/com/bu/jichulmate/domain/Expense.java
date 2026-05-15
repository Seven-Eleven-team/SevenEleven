package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "EXPENSES")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
public class Expense {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_expenses_gen")
    @SequenceGenerator(name = "seq_expenses_gen", sequenceName = "SEQ_EXPENSES", allocationSize = 1)
    @Column(name = "EXPENSE_ID")
    private Long id;


    // TODO: User 엔티티 생성 후 주석 해제 (연관관계 LAZY 필수)
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