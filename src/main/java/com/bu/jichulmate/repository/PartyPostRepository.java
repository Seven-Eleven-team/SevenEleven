package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.PartyPost; // ★ 옛날 경로를 지우고, 진짜 엔티티 경로로 연결!
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PartyPostRepository extends JpaRepository<PartyPost, Long> {

    // ★ PartyPostService에서 찾고 있는 메서드입니다. 꼭 있어야 에러가 안 납니다!
    List<PartyPost> findBySellerUserId(Long userId); // ★ 변경!

}