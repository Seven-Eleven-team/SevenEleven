package com.bu.jichulmate.repository;

import com.bu.jichulmate.faq.entity.Faq; // ★ Faq 엔티티 위치를 알려주는 핵심 한 줄!
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FaqRepository extends JpaRepository<Faq, Long> {

    List<Faq> findByIsActiveOrderBySortOrderAsc(String isActive);

    List<Faq> findByIsActiveAndCategoryOrderBySortOrderAsc(String isActive, String category);

    List<Faq> findAllByOrderBySortOrderAsc();
}