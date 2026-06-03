package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Faq;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FaqRepository extends JpaRepository<Faq, Long> {
    // 노출 순서(sortOrder) 오름차순으로 전체 FAQ 조회
    List<Faq> findAllByOrderBySortOrderAsc();
}