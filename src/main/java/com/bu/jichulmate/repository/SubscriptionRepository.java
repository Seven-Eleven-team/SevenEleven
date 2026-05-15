package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Subscription;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SubscriptionRepository
        extends JpaRepository<Subscription, Long> {

    // 특정 회원의 구독 목록 조회
    List<Subscription> findByUserUserId(Long userId);
}