package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.SavingGoal;
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.repository.GoalRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class SavingGoalService {

    // ★ 변수명도 goalRepository로 깔끔하게 통일했습니다.
    private final GoalRepository goalRepository;

    // 목표 등록 로직
    public SavingGoal createGoal(User user, String name, long price, String isFixed) {
        // 1. 고정 목표(Y)는 1개까지만 체크
        if ("Y".equals(isFixed)) {
            if (goalRepository.countByUserAndIsFixed(user, "Y") >= 1) {
                throw new IllegalStateException("고정 목표는 1개까지만 설정할 수 있습니다.");
            }
        }
        // 2. 일반 목표(N)는 4개까지만 체크
        else {
            if (goalRepository.countByUserAndIsFixed(user, "N") >= 4) {
                throw new IllegalStateException("일반 목표는 최대 4개까지 설정할 수 있습니다.");
            }
        }

        SavingGoal goal = SavingGoal.builder()
                .user(user)
                .goalName(name)
                .targetAmount(price)
                .isFixed(isFixed)
                .status("IN_PROGRESS")
                .savedAmount(0L) // 명확하게 Long 타입 명시
                .build();

        return goalRepository.save(goal);
    }

    // 목표 삭제 로직
    public void deleteGoal(Long goalId) {
        goalRepository.deleteById(goalId);
    }
}