package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.NotificationLog;
import com.bu.jichulmate.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface NotificationLogRepository extends JpaRepository<NotificationLog, Long> {
    Page<NotificationLog> findByUserOrderByCreatedAtDesc(User user, Pageable pageable);
    long countByUserAndReadFalse(User user);

    @Modifying
    @Query("UPDATE NotificationLog n SET n.read = true WHERE n.user = :user")
    void markAllAsRead(@Param("user") User user);
}
