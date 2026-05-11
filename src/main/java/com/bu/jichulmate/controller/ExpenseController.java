package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.Category;
import com.bu.jichulmate.domain.Expense;
import com.bu.jichulmate.repository.CategoryRepository;
import com.bu.jichulmate.repository.ExpenseRepository;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequiredArgsConstructor // 레포지토리 주입을 위해 추가!
public class ExpenseController {

    private final ExpenseRepository expenseRepository;
    private final CategoryRepository categoryRepository;

    // ==========================================
    // 1. 기존 화면을 띄워주는 기능
    // ==========================================
    @GetMapping("/expense/input")
    public String showExpenseForm() {
        return "expense/form"; // expense/form.jsp 화면을 띄움
    }

    // ==========================================
    // 2. 바텀 시트에서 넘어온 지출 데이터를 DB에 저장하는 기능
    // ==========================================
    @PostMapping("/api/v1/expenses")
    @ResponseBody // ★ 핵심! 화면(jsp)을 찾지 말고 데이터(글자)만 바로 응답하라는 뜻
    public ResponseEntity<String> saveExpense(@RequestBody ExpenseRequestDto dto) {

        Category category = categoryRepository.findById(dto.getCategoryId())
                .orElseThrow(() -> new IllegalArgumentException("해당 카테고리가 없습니다."));

        Expense expense = Expense.builder()
                .userId(dto.getUserId())
                .category(category)
                .amount(dto.getAmount())
                .expenseDate(dto.getExpenseDate())
                .isFixed(dto.getIsFixed())
                .build();

        expenseRepository.save(expense);

        return ResponseEntity.ok("지출 내역 저장 성공!");
    }



    // ==========================================
    // 프론트엔드에서 넘어오는 데이터를 담을 DTO 바구니
    // ==========================================
    @Data
    static class ExpenseRequestDto {
        private Long userId;
        private Long categoryId;
        private Long amount;
        private LocalDate expenseDate;
        private String isFixed;
    }

    @Data
    static class GoalRequestDto {
        private Long userId;
        private String itemName;
        private Long itemPrice;
    }

    // ==========================================
    // ★ 새로 추가: 지출 내역 수정 API
    // ==========================================
    @PutMapping("/api/v1/expenses/{id}")
    @ResponseBody
    public ResponseEntity<String> updateExpense(@PathVariable Long id, @RequestBody ExpenseRequestDto dto) {
        Expense expense = expenseRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("해당 지출 내역이 없습니다."));
        Category category = categoryRepository.findById(dto.getCategoryId())
                .orElseThrow(() -> new IllegalArgumentException("카테고리가 없습니다."));

        // 엔티티 업데이트 (도메인 객체에 update 로직이 있어야 합니다. 없으면 setter 사용)
        expense.updateExpense(category, dto.getAmount(), dto.getExpenseDate(), dto.getIsFixed());
        expenseRepository.save(expense);

        return ResponseEntity.ok("지출 내역 수정 완료!");
    }

    // ==========================================
    // ★ 새로 추가: 지출 내역 삭제 API
    // ==========================================
    @DeleteMapping("/api/v1/expenses/{id}")
    @ResponseBody
    public ResponseEntity<String> deleteExpense(@PathVariable Long id) {
        expenseRepository.deleteById(id);
        return ResponseEntity.ok("지출 내역 삭제 완료!");
    }

}