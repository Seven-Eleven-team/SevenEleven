package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Category;
import com.bu.jichulmate.domain.Expense;
import com.bu.jichulmate.dto.expense.ExpenseCreateRequest;
import com.bu.jichulmate.repository.CategoryRepository;
import com.bu.jichulmate.repository.ExpenseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ExpenseService {

    private final ExpenseRepository expenseRepository;
    // ★ 넘어온 ID로 카테고리 엔티티를 찾기 위해 CategoryRepository를 추가합니다.
    private final CategoryRepository categoryRepository;

    @Transactional
    public void saveExpenses(Long userId, List<ExpenseCreateRequest> requests) {

        for (ExpenseCreateRequest req : requests) {

            // 1. DTO에 담겨온 카테고리 ID로 진짜 Category 객체를 DB에서 찾아옵니다.
            Category category = categoryRepository.findById(req.getCategoryId())
                    .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 카테고리입니다. ID: " + req.getCategoryId()));

            // 2. 은아 님이 만들어두신 안전한 @Builder 를 사용하여 객체를 조립합니다.
            Expense expense = Expense.builder()
                    .userId(userId)
                    .category(category)  // 찾은 카테고리 객체를 통째로 쏙!
                    .amount(req.getAmount())
                    .expenseDate(req.getExpenseDate())
                    .isFixed(req.getIsFixed())
                    .build();

            // 3. DB에 저장
            expenseRepository.save(expense);
        }
    }
}