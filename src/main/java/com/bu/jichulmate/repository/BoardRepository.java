package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Board;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BoardRepository extends JpaRepository<Board, Long> {

    // isDeleted 조건 제거
    Page<Board> findByUserIdOrderByCreatedAtDesc(
            Long userId,
            Pageable pageable
    );

    // 전체 게시글 조회 (isDeleted 조건 제거)
    Page<Board> findAllByOrderByCreatedAtDesc(
            Pageable pageable
    );
}