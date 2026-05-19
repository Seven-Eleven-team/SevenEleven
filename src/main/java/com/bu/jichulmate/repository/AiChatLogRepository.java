package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.AiChatLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AiChatLogRepository extends JpaRepository<AiChatLog, Long> {
    // 특정 유저의 전체 대화 내역을 과거순 -> 최신순으로 정렬해서 조회
    List<AiChatLog> findByUserIdOrderByChatDateAsc(Long userId);
}