package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.SavingGoal;
import com.bu.jichulmate.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoalRepository extends JpaRepository<SavingGoal, Long> {

    // 마이페이지 메인 - 절약 목표 최대 3개
    List<SavingGoal> findTop3ByUserAndDeletedFalseOrderByCreatedAtDesc(User user);

    // 전체 목표 목록 (GoalController에서 사용)
    List<SavingGoal> findByUserAndDeletedFalseOrderByCreatedAtDesc(User user);
}