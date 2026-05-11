package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PartyRepository extends JpaRepository<PartyPost, Long> {
    // PartyPost 엔티티에 hostUser 필드가 있어야 합니다.
    Page<PartyPost> findByHostUserOrderByCreatedAtDesc(User hostUser, Pageable pageable);
    Page<PartyPost> findByStatusAndDeletedFalseOrderByCreatedAtDesc(String status, Pageable pageable);
}
