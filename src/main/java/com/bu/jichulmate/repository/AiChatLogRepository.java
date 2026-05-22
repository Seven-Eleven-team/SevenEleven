package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.AiChatLog;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AiChatLogRepository extends JpaRepository<AiChatLog, Long> {

    /**
     * 특정 유저의 채팅 내역을 최신순(역순)으로 정렬하여 지정된 개수만큼 페이징 조회합니다.
     * AiMentorService에서 최근 10개의 메시지를 뽑아낼 때 사용됩니다.
     */
    List<AiChatLog> findByUser_UserIdOrderByChatDateDesc(Long userId, Pageable pageable);

    /**
     * 특정 유저의 전체 채팅 내역을 오래된 순(정순)으로 조회합니다.
     * 유저가 대화창(Drawer)을 처음 열었을 때 히스토리를 순서대로 그려주기 위해 사용됩니다.
     */
    List<AiChatLog> findByUser_UserIdOrderByChatDateAsc(Long userId);
}