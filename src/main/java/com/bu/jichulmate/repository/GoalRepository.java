package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.SavingGoal;
import com.bu.jichulmate.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface GoalRepository extends JpaRepository<SavingGoal, Long> {

    Optional<SavingGoal> findTopByUserUserIdOrderByIdDesc(Long userId);
    List<SavingGoal> findByUserUserId(Long userId);
    List<SavingGoal> findTop3ByUserUserIdOrderByIdDesc(Long userId);

    long countByUserAndIsFixed(User user, String isFixed);

}