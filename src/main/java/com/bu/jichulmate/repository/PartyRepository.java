package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PartyRepository extends JpaRepository<PartyPost, Long> {

    // 1. MyPageService 에서 쓰는 정상적인 메서드
    Page<PartyPost> findByHostUserOrderByCreatedAtDesc(User hostUser, Pageable pageable);

    // 2. 상태별 검색 (기존에 있던 것)
    Page<PartyPost> findByStatusAndDeletedFalseOrderByCreatedAtDesc(String status, Pageable pageable);

    // 3. PartyPostService 에서 쓰는 정상적인 메서드
    List<PartyPost> findByHostUserUserId(Long userId);

    // ★ 에러의 주범이었던 findBySellerId... 줄은 완전히 삭제했습니다!
}