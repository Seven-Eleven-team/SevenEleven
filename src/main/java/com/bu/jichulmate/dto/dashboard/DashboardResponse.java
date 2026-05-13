package com.bu.jichulmate.dto.dashboard;

import lombok.Data;
import java.util.List;

@Data
public class DashboardResponse {
    private long totalMonthlyExpense;
    private List<CategoryRatioResponse> categoryStats;
    private List<String> barLabels;
    private List<Long> lastMonthData;
    private List<Long> thisMonthData;


    private List<GoalAchievementResponse> goals;
}