package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.NotificationLog;
import com.bu.jichulmate.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NotificationLogRepository extends JpaRepository<NotificationLog, Long> {

    Page<NotificationLog> findByUserOrderByCreatedAtDesc(User user, Pageable pageable);

    // 안 읽은 알림 대신 '전송 실패(N)' 건수를 세는 방식으로 임시 변경
    long countByUserAndIsSuccess(User user, String isSuccess);

    // 내 알림만, 성공한 것만, 최신순으로 가져오기!
    Page<NotificationLog> findByUser_UserIdAndIsSuccessOrderByCreatedAtDesc(Long userId, String isSuccess, Pageable pageable);
}