package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Subscription;
import com.bu.jichulmate.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {

    // 특정 회원 + 상태 조회
    List<Subscription> findByUserAndStatus(
            User user,
            String status
    );

    // 특정 회원 + 상태 + 최신순 페이징
    Page<Subscription> findByUserAndStatusOrderByCreatedAtDesc(
            User user,
            String status,
            Pageable pageable
    );

    // 특정 회원 최신순 페이징
    Page<Subscription> findByUserOrderByCreatedAtDesc(
            User user,
            Pageable pageable
    );

    // 특정 회원의 전체 구독 조회
    List<Subscription> findByUserUserId(
            Long userId
    );
}