package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Inquiry;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InquiryRepository extends JpaRepository<Inquiry, Long> {

    // 1. SupportService 용 (리스트 반환)
    List<Inquiry> findByUserId(Long userId);

    // 2. MyPageService 용 (페이징 + 최신순 정렬)
    Page<Inquiry> findByUserIdOrderByCreatedAtDesc(Long userId, Pageable pageable);
}