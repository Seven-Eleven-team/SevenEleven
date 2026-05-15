package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Board;
import com.bu.jichulmate.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BoardRepository extends JpaRepository<Board, Long> {
    Page<Board> findByUserAndIsDeletedOrderByCreatedAtDesc(User user, String isDeleted, Pageable pageable);
    Page<Board> findByIsDeletedOrderByCreatedAtDesc(String isDeleted, Pageable pageable);
}