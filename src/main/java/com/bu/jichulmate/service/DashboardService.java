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
        // 1. 날짜 세팅 (기존 동일)
        String thisMonthStr = String.format("%04d-%02d", year, month);
        int lastMonthYear = (month == 1) ? year - 1 : year;
        int lastMonthVal = (month == 1) ? 12 : month - 1;
        String lastMonthStr = String.format("%04d-%02d", lastMonthYear, lastMonthVal);

        // 2. DB에서 데이터 가져오기 (List<Object[]> 형태로 받아옴)
        List<Object[]> thisMonthRaw = expenseRepository.getMonthlyCategoryStats(userId, thisMonthStr);
        List<Object[]> lastMonthRaw = expenseRepository.getMonthlyCategoryStats(userId, lastMonthStr);

        // 3. Object[] 를 CategoryRatioResponse DTO로 예쁘게 변환
        List<CategoryRatioResponse> thisMonthList = convertToDtoList(thisMonthRaw);
        List<CategoryRatioResponse> lastMonthList = convertToDtoList(lastMonthRaw);

        // 4. 통계 계산 로직 (기존과 완전히 동일)
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

        // 5. 최종 리턴
        DashboardResponse response = new DashboardResponse();
        response.setTotalMonthlyExpense(totalThisMonth);
        response.setCategoryStats(pieStats);
        response.setBarLabels(barLabels);
        response.setThisMonthData(thisMonthData);
        response.setLastMonthData(lastMonthData);

        List<SavingGoal> savedGoals = goalRepository.findByUserId(userId);
        List<GoalAchievementResponse> goalResponses = new ArrayList<>();

        for (SavingGoal goal : savedGoals) {
            GoalAchievementResponse dto = new GoalAchievementResponse();
            dto.setGoalName(goal.getItemName()); // 엔티티의 목표 이름 필드명에 맞게 수정하세요

            // 달성률 계산: (현재 모은 돈 / 목표 금액) * 100
            // 주의: targetAmount가 0이면 에러가 나므로 방어 코드 작성
            long target = goal.getItemPrice();     // 목표 금액 (예: 1억)
            long current = goal.getSavedAmount();  // 현재 모은 금액 (예: 0원)

            int rate = 0;
            if (target > 0) {
                rate = (int) Math.round(((double) current / target) * 100);
                if (rate > 100) rate = 100;
            }
            dto.setAchievementRate(rate);
            goalResponses.add(dto);
        }

        // 조립된 목표 리스트를 응답 객체에 넣습니다.
        response.setGoals(goalResponses);

        return response;
    }

    // Object[] 배열을 DTO 리스트로 바꿔주는 작은 헬퍼 메서드
    private List<CategoryRatioResponse> convertToDtoList(List<Object[]> rawList) {
        List<CategoryRatioResponse> dtoList = new ArrayList<>();
        for (Object[] row : rawList) {
            CategoryRatioResponse dto = new CategoryRatioResponse();
            dto.setCategoryName((String) row[0]);
            // DB의 SUM 결과가 Number 타입으로 오므로 long으로 변환
            dto.setTotalAmount(((Number) row[1]).longValue());
            dtoList.add(dto);
        }
        return dtoList;
    }
}