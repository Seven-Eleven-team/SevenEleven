package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.NotificationLog;
import com.bu.jichulmate.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NotificationLogRepository extends JpaRepository<NotificationLog, Long> {
    Page<NotificationLog> findByUserOrderByCreatedAtDesc(User user, Pageable pageable);

    // 안 읽은 알림 대신 '전송 실패(N)' 건수를 세는 방식으로 임시 변경
    long countByUserAndIsSuccess(User user, String isSuccess);
}