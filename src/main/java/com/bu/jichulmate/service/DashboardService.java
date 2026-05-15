package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.SavingGoal;
import com.bu.jichulmate.dto.dashboard.CategoryRatioResponse;
import com.bu.jichulmate.dto.dashboard.DashboardResponse;
import com.bu.jichulmate.dto.dashboard.GoalAchievementResponse;
import com.bu.jichulmate.repository.ExpenseRepository;
import com.bu.jichulmate.repository.GoalRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class DashboardService {

    private final ExpenseRepository expenseRepository;
    private final GoalRepository goalRepository;

    public DashboardResponse getDashboardData(Long userId, int year, int month) {
        String thisMonthStr = String.format("%04d-%02d", year, month);
        int lastMonthYear = (month == 1) ? year - 1 : year;
        int lastMonthVal = (month == 1) ? 12 : month - 1;
        String lastMonthStr = String.format("%04d-%02d", lastMonthYear, lastMonthVal);

        List<Object[]> thisMonthRaw = expenseRepository.getMonthlyCategoryStats(userId, thisMonthStr);
        List<Object[]> lastMonthRaw = expenseRepository.getMonthlyCategoryStats(userId, lastMonthStr);

        List<CategoryRatioResponse> thisMonthList = convertToDtoList(thisMonthRaw);
        List<CategoryRatioResponse> lastMonthList = convertToDtoList(lastMonthRaw);

        long totalThisMonth = 0;
        List<String> barLabels = new ArrayList<>();
        List<Long> thisMonthData = new ArrayList<>();
        List<Long> lastMonthData = new ArrayList<>();
        List<CategoryRatioResponse> pieStats = new ArrayList<>();

        for (CategoryRatioResponse stat : thisMonthList) {
            totalThisMonth += stat.getTotalAmount();
        }

        for (int i = 0; i < thisMonthList.size(); i++) {
            CategoryRatioResponse tStat = thisMonthList.get(i);
            CategoryRatioResponse lStat = lastMonthList.get(i);

            barLabels.add(tStat.getCategoryName());
            thisMonthData.add(tStat.getTotalAmount());
            lastMonthData.add(lStat.getTotalAmount());

            if (tStat.getTotalAmount() > 0) {
                int percentage = (int) Math.round((tStat.getTotalAmount() * 100.0) / totalThisMonth);
                tStat.setPercentage(percentage);
                pieStats.add(tStat);
            }
        }

        DashboardResponse response = new DashboardResponse();
        response.setTotalMonthlyExpense(totalThisMonth);
        response.setCategoryStats(pieStats);
        response.setBarLabels(barLabels);
        response.setThisMonthData(thisMonthData);
        response.setLastMonthData(lastMonthData);

        List<SavingGoal> savedGoals = goalRepository.findByUserUserId(userId);
        List<GoalAchievementResponse> goalResponses = new ArrayList<>();

        for (SavingGoal goal : savedGoals) {
            GoalAchievementResponse dto = new GoalAchievementResponse();
            // ★ 에러 원인 해결: getGoalName, getTargetAmount 로 원상복구!
            dto.setGoalName(goal.getGoalName());

            long target = goal.getTargetAmount();
            long current = goal.getSavedAmount();

            int rate = 0;
            if (target > 0) {
                rate = (int) Math.round(((double) current / target) * 100);
                if (rate > 100) rate = 100;
            }
            dto.setAchievementRate(rate);
            goalResponses.add(dto);
        }

        response.setGoals(goalResponses);
        return response;
    }

    private List<CategoryRatioResponse> convertToDtoList(List<Object[]> rawList) {
        List<CategoryRatioResponse> dtoList = new ArrayList<>();
        for (Object[] row : rawList) {
            CategoryRatioResponse dto = new CategoryRatioResponse();
            dto.setCategoryName((String) row[0]);
            dto.setTotalAmount(((Number) row[1]).longValue());
            dtoList.add(dto);
        }
        return dtoList;
    }
}