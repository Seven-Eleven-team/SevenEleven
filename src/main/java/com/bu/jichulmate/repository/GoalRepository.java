package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.SavingGoal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface GoalRepository extends JpaRepository<SavingGoal, Long> {

    // ★ 에러 해결: ByUserId -> ByUserUserId 로 변경! (User 객체 안의 userId를 찾으라는 뜻)
    Optional<SavingGoal> findTopByUserUserIdOrderByIdDesc(Long userId);

    List<SavingGoal> findByUserUserId(Long userId);

    List<SavingGoal> findTop3ByUserUserIdOrderByIdDesc(Long userId);
}