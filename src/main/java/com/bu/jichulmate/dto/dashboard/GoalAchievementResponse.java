package com.bu.jichulmate.dto.dashboard;

import lombok.Data;

@Data
public class GoalAchievementResponse {
    private String goalName;      // 목표 이름 (예: 맥북 프로 구매)
    private int achievementRate;  // 달성률 퍼센트 (예: 45)

}