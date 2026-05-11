package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.SavingGoal;
import com.bu.jichulmate.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoalRepository extends JpaRepository<SavingGoal, Long> {

    Optional<SavingGoal> findTopByUserIdOrderByIdDesc(Long userId);

}