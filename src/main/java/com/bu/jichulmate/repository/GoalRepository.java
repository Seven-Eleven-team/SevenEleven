package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.SavingGoal;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface GoalRepository extends JpaRepository<SavingGoal, Long> {
    // 유저 ID로 등록된 목표 리스트를 전부 가져옵니다.
    List<SavingGoal> findByUserId(Long userId);

    Optional<SavingGoal> findTopByUserIdOrderByIdDesc(Long userId);

}