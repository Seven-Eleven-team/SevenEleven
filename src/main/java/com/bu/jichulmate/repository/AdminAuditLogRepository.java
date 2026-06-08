package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.AdminAuditLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdminAuditLogRepository extends JpaRepository<AdminAuditLog, Long> {
    // 최신 활동 기록부터 보여주기 위해 등록일(createdAt) 기준 내림차순 정렬
    List<AdminAuditLog> findAllByOrderByCreatedAtDesc();
}