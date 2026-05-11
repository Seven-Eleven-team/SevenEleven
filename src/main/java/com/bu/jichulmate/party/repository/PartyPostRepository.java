package com.bu.jichulmate.party.repository;

import com.bu.jichulmate.party.entity.PartyPost;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PartyPostRepository extends JpaRepository<PartyPost, Long> {
    List<PartyPost> findBySellerId(Long sellerId);
    List<PartyPost> findByStatus(String status);
}