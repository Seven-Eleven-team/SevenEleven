package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.PartyPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PartyPostRepository extends JpaRepository<PartyPost, Long> {

    List<PartyPost> findBySellerUserId(Long userId);
}