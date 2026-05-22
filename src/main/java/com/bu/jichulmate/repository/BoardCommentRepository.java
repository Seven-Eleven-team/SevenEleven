package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.BoardComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface BoardCommentRepository extends JpaRepository<BoardComment, Long> {

    @Query("""
        SELECT c
        FROM BoardComment c
        LEFT JOIN FETCH c.user
        WHERE c.boardId = :boardId
          AND c.isDeleted = 'N'
        ORDER BY c.commentId ASC
    """)
    List<BoardComment> findActiveCommentsByBoardId(@Param("boardId") Long boardId);

    @Query("""
        SELECT c
        FROM BoardComment c
        WHERE c.commentId = :commentId
          AND c.boardId = :boardId
          AND c.isDeleted = 'N'
    """)
    Optional<BoardComment> findActiveComment(
            @Param("commentId") Long commentId,
            @Param("boardId") Long boardId
    );
}