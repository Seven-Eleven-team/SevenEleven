package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.PartyPost;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PartyRepository extends JpaRepository<PartyPost, Long> {
    // 1. 상태별 검색 (deleted 조건 제거)
    Page<PartyPost> findByStatusOrderByCreatedAtDesc(String status, Pageable pageable);

    // 2. MyPageService & PartyPostService 용 (seller 안에 있는 userId로 검색)
    List<PartyPost> findBySellerUserId(Long userId);
    Page<PartyPost> findBySellerUserIdOrderByCreatedAtDesc(Long userId, Pageable pageable);
}