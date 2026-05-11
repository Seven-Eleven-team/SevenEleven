package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.Expense;
import com.bu.jichulmate.domain.SavingGoal;
import com.bu.jichulmate.repository.ExpenseRepository;
import com.bu.jichulmate.repository.GoalRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class DashboardController {

    private final ExpenseRepository expenseRepository;
    private final GoalRepository goalRepository;

    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        Long userId = 1L; // 현재 로그인 유저 ID (임시)

        // 1. 날짜 구하기 (이번 달 & 저번 달)
        YearMonth thisMonth = YearMonth.now();
        YearMonth lastMonth = thisMonth.minusMonths(1);

        LocalDate startOfThisMonth = thisMonth.atDay(1);
        LocalDate endOfThisMonth = thisMonth.atEndOfMonth();
        LocalDate startOfLastMonth = lastMonth.atDay(1);
        LocalDate endOfLastMonth = lastMonth.atEndOfMonth();

        // 2. DB에서 데이터 불러오기
        List<Expense> thisMonthExpenses = expenseRepository.findMonthlyExpenses(userId, startOfThisMonth, endOfThisMonth);
        List<Expense> lastMonthExpenses = expenseRepository.findMonthlyExpenses(userId, startOfLastMonth, endOfLastMonth);


        // 3. 원형 차트용 데이터 가공 (금액 내림차순 정렬 및 총합 계산)

        // [전체 지출] - 정렬 및 Map 생성
        Map<String, Long> allDataMap = thisMonthExpenses.stream()
                .collect(Collectors.groupingBy(e -> e.getCategory().getName(), Collectors.summingLong(Expense::getAmount)))
                .entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed()) // ★ 내림차순 정렬
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

        // [고정 지출] (isFixed == "Y") - 정렬 및 Map 생성
        Map<String, Long> fixedDataMap = thisMonthExpenses.stream()
                .filter(e -> "Y".equals(e.getIsFixed()))
                .collect(Collectors.groupingBy(e -> e.getCategory().getName(), Collectors.summingLong(Expense::getAmount)))
                .entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed()) // ★ 내림차순 정렬
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

        // [변동 지출] (isFixed == "N") - 정렬 및 Map 생성
        Map<String, Long> variableDataMap = thisMonthExpenses.stream()
                .filter(e -> "N".equals(e.getIsFixed()))
                .collect(Collectors.groupingBy(e -> e.getCategory().getName(), Collectors.summingLong(Expense::getAmount)))
                .entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed()) // ★ 내림차순 정렬
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

        // 각 타입별 총합계 계산
        long allTotal = allDataMap.values().stream().mapToLong(Long::longValue).sum();
        long fixedTotal = fixedDataMap.values().stream().mapToLong(Long::longValue).sum();
        long variableTotal = variableDataMap.values().stream().mapToLong(Long::longValue).sum();

        // Model에 데이터 전달 (원형 차트용)
        model.addAttribute("allLabels", allDataMap.keySet());
        model.addAttribute("allData", allDataMap.values());
        model.addAttribute("allTotal", allTotal); // 전체 지출 총합

        model.addAttribute("fixedLabels", fixedDataMap.keySet());
        model.addAttribute("fixedData", fixedDataMap.values());
        model.addAttribute("fixedTotal", fixedTotal); // 고정 지출 총합

        model.addAttribute("variableLabels", variableDataMap.keySet());
        model.addAttribute("variableData", variableDataMap.values());
        model.addAttribute("variableTotal", variableTotal); // 변동 지출 총합

        // 텍스트 표시용 (기존 유지)
        model.addAttribute("fixedExpenseTotal", fixedTotal);
        model.addAttribute("lastMonthMonthValue", lastMonth.getMonthValue());
        model.addAttribute("thisMonthMonthValue", thisMonth.getMonthValue());

        // ========================================================
        // 4. 막대그래프용 데이터 가공 (전월 비교)
        // ========================================================
        List<String> barCategoryNames = Arrays.asList("주거비", "식비", "교통비", "통신비", "보험료", "교육비", "의료비", "오락/문화", "의류/미용", "기타");

        List<Long> thisMonthBarData = barCategoryNames.stream()
                .map(catName -> thisMonthExpenses.stream()
                        .filter(e -> catName.equals(e.getCategory().getName()))
                        .mapToLong(Expense::getAmount).sum())
                .collect(Collectors.toList());

        List<Long> lastMonthBarData = barCategoryNames.stream()
                .map(catName -> lastMonthExpenses.stream()
                        .filter(e -> catName.equals(e.getCategory().getName()))
                        .mapToLong(Expense::getAmount).sum())
                .collect(Collectors.toList());


        SavingGoal myGoal = goalRepository.findTopByUserIdOrderByIdDesc(1L).orElse(null);
        model.addAttribute("goal", myGoal);

        model.addAttribute("barCategories", barCategoryNames);
        model.addAttribute("thisMonthBarData", thisMonthBarData);
        model.addAttribute("lastMonthBarData", lastMonthBarData);

        model.addAttribute("thisMonthExpenses", thisMonthExpenses);

        return "dashboard/dashboard";
    }
}