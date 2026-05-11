package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.PartyPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PartyRepository extends JpaRepository<PartyPost, Long> {
    List<PartyPost> findBySellerId(Long sellerId);
    List<PartyPost> findByStatus(String status);
}