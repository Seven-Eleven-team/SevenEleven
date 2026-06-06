package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.Expense;
import com.bu.jichulmate.domain.SavingGoal;
import com.bu.jichulmate.repository.ExpenseRepository;
import com.bu.jichulmate.repository.GoalRepository;
import jakarta.servlet.http.HttpSession;
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
    public String showDashboard(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("loginUserId");

        if (userId == null) {
            return "redirect:/auth/login";
        }

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

        // ========================================================
        // ★ 모달에 띄워줄 '지출+저축' 과거 전체 내역 합치기
        // ========================================================
        List<Expense> pastRecords = expenseRepository.findPastAllRecords(userId, startOfThisMonth);

        List<Expense> screenExpenses = new ArrayList<>(thisMonthExpenses);
        screenExpenses.addAll(pastRecords); // 이번 달 + 과거 데이터 싹 다 합치기

        model.addAttribute("thisMonthExpenses", thisMonthExpenses); // (기존 차트용 유지)
        model.addAttribute("screenExpenses", screenExpenses);       // (★ 모달 리스트용)

        // 3. 원형 차트용 데이터 가공 (금액 내림차순 정렬 및 총합 계산)
        Map<String, Long> allDataMap = thisMonthExpenses.stream()
                .filter(e -> !"저축".equals(e.getCategory().getName()))
                .collect(Collectors.groupingBy(e -> e.getCategory().getName(), Collectors.summingLong(Expense::getAmount)))
                .entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed())
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

        Map<String, Long> fixedDataMap = thisMonthExpenses.stream()
                .filter(e -> "Y".equals(e.getIsFixed()) && !"저축".equals(e.getCategory().getName()))
                .collect(Collectors.groupingBy(e -> e.getCategory().getName(), Collectors.summingLong(Expense::getAmount)))
                .entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed())
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

        Map<String, Long> variableDataMap = thisMonthExpenses.stream()
                .filter(e -> "N".equals(e.getIsFixed()) && !"저축".equals(e.getCategory().getName()))
                .collect(Collectors.groupingBy(e -> e.getCategory().getName(), Collectors.summingLong(Expense::getAmount)))
                .entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed())
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

        long allTotal = allDataMap.values().stream().mapToLong(Long::longValue).sum();
        long fixedTotal = fixedDataMap.values().stream().mapToLong(Long::longValue).sum();
        long variableTotal = variableDataMap.values().stream().mapToLong(Long::longValue).sum();

        // 요약 카드용 계산
        long lastMonthTotal = lastMonthExpenses.stream()
                .filter(e -> !"저축".equals(e.getCategory().getName()))
                .mapToLong(Expense::getAmount).sum();

        long savingsTotal = thisMonthExpenses.stream()
                .filter(e -> "저축".equals(e.getCategory().getName()))
                .mapToLong(Expense::getAmount).sum();

        Long averageExpense = expenseRepository.getMonthlyAverageExpense(userId);

        model.addAttribute("lastMonthTotal", lastMonthTotal);
        model.addAttribute("savingsTotal", savingsTotal);
        model.addAttribute("averageExpense", averageExpense);

        model.addAttribute("allLabels", allDataMap.keySet());
        model.addAttribute("allData", allDataMap.values());
        model.addAttribute("allTotal", allTotal);

        model.addAttribute("fixedLabels", fixedDataMap.keySet());
        model.addAttribute("fixedData", fixedDataMap.values());
        model.addAttribute("fixedTotal", fixedTotal);

        model.addAttribute("variableLabels", variableDataMap.keySet());
        model.addAttribute("variableData", variableDataMap.values());
        model.addAttribute("variableTotal", variableTotal);

        // 4. 막대그래프용 데이터 가공 (전월 비교)
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

        SavingGoal myGoal = goalRepository.findTopByUserUserIdOrderByIdDesc(userId).orElse(null);
        model.addAttribute("goal", myGoal);

        List<SavingGoal> goalList = goalRepository.findByUserUserId(userId);
        model.addAttribute("goalList", goalList);

        model.addAttribute("barCategories", barCategoryNames);
        model.addAttribute("thisMonthBarData", thisMonthBarData);
        model.addAttribute("lastMonthBarData", lastMonthBarData);

        // ========================================================
        // 5. 최근 5개월 요약 데이터 가공
        // ========================================================
        LocalDate startOf6MonthsAgo = thisMonth.minusMonths(5).atDay(1);
        List<Object[]> trendDataRaw = expenseRepository.get5MonthsTrend(userId, startOf6MonthsAgo, endOfThisMonth);

        YearMonth firstRecordMonth = thisMonth;
        boolean hasRecord = false;
        if (!trendDataRaw.isEmpty()) {
            firstRecordMonth = YearMonth.parse((String) trendDataRaw.get(0)[0]);
            hasRecord = true;
        }

        YearMonth viewStartMonth = firstRecordMonth;
        YearMonth maxViewStart = thisMonth.minusMonths(4);
        if (viewStartMonth.isBefore(maxViewStart)) {
            viewStartMonth = maxViewStart;
        }

        int trendMonthCount = hasRecord ? (int) java.time.temporal.ChronoUnit.MONTHS.between(viewStartMonth, thisMonth) + 1 : 1;

        Map<String, Long> trendMap = new LinkedHashMap<>();
        for (int i = trendMonthCount - 1; i >= 0; i--) {
            trendMap.put(thisMonth.minusMonths(i).toString(), 0L);
        }

        YearMonth prevOfStart = viewStartMonth.minusMonths(1);
        long firstMonthPrevAmt = 0L;
        boolean isAbsolutelyFirst = true;

        for (Object[] row : trendDataRaw) {
            String monthStr = (String) row[0];
            YearMonth ym = YearMonth.parse(monthStr);
            long amt = ((Number) row[1]).longValue();

            if (trendMap.containsKey(monthStr)) {
                trendMap.put(monthStr, amt);
            } else if (ym.equals(prevOfStart)) {
                firstMonthPrevAmt = amt;
            }

            if (ym.isBefore(viewStartMonth)) {
                isAbsolutelyFirst = false;
            }
        }

        List<String> trendLabels = new ArrayList<>();
        List<Long> trendData = new ArrayList<>();
        for (Map.Entry<String, Long> entry : trendMap.entrySet()) {
            String monthLabel = Integer.parseInt(entry.getKey().substring(5)) + "월";
            trendLabels.add(monthLabel);
            trendData.add(entry.getValue());
        }

        model.addAttribute("trendLabels", trendLabels);
        model.addAttribute("trendData", trendData);
        model.addAttribute("trendMonthCount", trendMonthCount);
        model.addAttribute("firstMonthPrevAmt", firstMonthPrevAmt);
        model.addAttribute("isAbsolutelyFirst", isAbsolutelyFirst);

        // ========================================================
        // 6. 목표 달성 진행률 차트 및 현재 진행 상태 데이터 가공
        // ========================================================
        List<Object[]> savingDataRaw = expenseRepository.getMonthlySavingsGroupedByGoal(userId);
        Map<Long, Map<String, Long>> savingsMap = new HashMap<>();

        for (Object[] row : savingDataRaw) {
            Long goalId = ((Number) row[0]).longValue();
            String monthStr = (String) row[1];
            Long amt = ((Number) row[2]).longValue();
            savingsMap.computeIfAbsent(goalId, k -> new HashMap<>()).put(monthStr, amt);
        }

        Map<Long, List<String>> goalChartMonthsMap = new HashMap<>();
        Map<Long, List<Long>> goalProgressData = new HashMap<>();
        Map<Long, Long> goalCurrentTotals = new HashMap<>();

        for (SavingGoal goal : goalList) {
            Long gId = goal.getId();
            Map<String, Long> thisGoalSavings = savingsMap.getOrDefault(gId, new HashMap<>());

            // 해당 목표에 저축을 처음 시작한 '가장 옛날 달' 찾기
            YearMonth earliestForThisGoal = thisMonth;
            for (String m : thisGoalSavings.keySet()) {
                YearMonth ym = YearMonth.parse(m);
                if (ym.isBefore(earliestForThisGoal)) {
                    earliestForThisGoal = ym;
                }
            }

            List<String> formattedMonths = new ArrayList<>();
            List<Long> cumulativeList = new ArrayList<>();
            long cumulativeSum = 0;

            // 첫 저축 달부터 이번 달까지 해당 목표만의 X축 배열 생성
            YearMonth currentIter = earliestForThisGoal;
            while (!currentIter.isAfter(thisMonth)) {
                String mKey = currentIter.toString();
                formattedMonths.add(Integer.parseInt(mKey.substring(5)) + "월");
                cumulativeSum += thisGoalSavings.getOrDefault(mKey, 0L);
                cumulativeList.add(cumulativeSum);
                currentIter = currentIter.plusMonths(1);
            }

            goalChartMonthsMap.put(gId, formattedMonths);
            goalProgressData.put(gId, cumulativeList);

            // 최종 누적액 계산
            long finalTotal = cumulativeSum;
            String lastViewMonth = thisMonth.toString();
            for (Map.Entry<String, Long> entry : thisGoalSavings.entrySet()) {
                if (entry.getKey().compareTo(lastViewMonth) > 0) {
                    finalTotal += entry.getValue();
                }
            }
            goalCurrentTotals.put(gId, finalTotal);
        }

        model.addAttribute("goalChartMonthsMap", goalChartMonthsMap);
        model.addAttribute("goalProgressData", goalProgressData);
        model.addAttribute("goalCurrentTotals", goalCurrentTotals);

        return "dashboard/dashboard";
    }
}