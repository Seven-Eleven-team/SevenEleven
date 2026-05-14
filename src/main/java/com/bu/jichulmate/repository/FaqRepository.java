package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Faq;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FaqRepository extends JpaRepository<Faq, Long> {

    List<Faq> findByIsActiveOrderBySortOrderAsc(String isActive);

    List<Faq> findByIsActiveAndCategoryOrderBySortOrderAsc(String isActive, String category);

    List<Faq> findAllByOrderBySortOrderAsc();
}