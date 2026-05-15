package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Expense;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param; // 반드시 Spring Data의 Param을 써야 합니다!

import java.time.LocalDate;
import java.util.List;


public interface ExpenseRepository extends JpaRepository<Expense, Long> {


    // [대시보드용] XML 파일 없이 JPA Native Query로 오라클 쿼리 직접 실행!
    @Query(value = "SELECT c.NAME as categoryName, NVL(SUM(e.AMOUNT), 0) as totalAmount " +
            "FROM CATEGORIES c " +
            "LEFT JOIN EXPENSES e ON c.CATEGORY_ID = e.CATEGORY_ID " +
            "AND e.USER_ID = :userId " +
            "AND TO_CHAR(e.EXPENSE_DATE, 'YYYY-MM') = :yearMonth " +
            "GROUP BY c.CATEGORY_ID, c.NAME " +
            "ORDER BY c.CATEGORY_ID", nativeQuery = true)
    List<Object[]> getMonthlyCategoryStats(@Param("userId") Long userId, @Param("yearMonth") String yearMonth);

    // 월별 지출 목록 조회 (기존 작성 완료)
    @Query("SELECT e FROM Expense e JOIN FETCH e.category WHERE e.userId = :userId AND e.expenseDate BETWEEN :startDate AND :endDate ORDER BY e.expenseDate DESC")
    List<Expense> findMonthlyExpenses(@Param("userId") Long userId, @Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);

    // 카테고리별 월간 지출 합계 (기존 유지)
    @Query("SELECT e.category.name, SUM(e.amount) FROM Expense e WHERE e.userId = :userId AND e.expenseDate BETWEEN :startDate AND :endDate GROUP BY e.category.name")
    List<Object[]> findCategoryTotalAmount(@Param("userId") Long userId, @Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
}