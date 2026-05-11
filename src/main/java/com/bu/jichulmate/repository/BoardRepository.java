package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Board;
import com.bu.jichulmate.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BoardRepository extends JpaRepository<Board, Long> {

    /**
     * 내 게시글 목록 조회
     * @param user 작성자
     * @param pageable 페이징 정보
     * @return 삭제되지 않은 작성자의 게시글 목록 (최신순)
     */
    Page<Board> findByUserAndDeletedFalseOrderByCreatedAtDesc(User user, Pageable pageable);

    /**
     * 전체 게시글 목록 조회
     * @param pageable 페이징 정보
     * @return 삭제되지 않은 전체 게시글 목록 (최신순)
     */
    Page<Board> findByDeletedFalseOrderByCreatedAtDesc(Pageable pageable);
}
