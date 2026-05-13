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
    List<Subscription> findByUserAndStatus(User user, String status);
    Page<Subscription> findByUserAndStatusOrderByCreatedAtDesc(User user, String status, Pageable pageable);
    Page<Subscription> findByUserOrderByCreatedAtDesc(User user, Pageable pageable);
}
