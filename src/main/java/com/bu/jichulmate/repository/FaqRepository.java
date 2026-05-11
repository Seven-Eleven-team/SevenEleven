package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Faq;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FaqRepository extends JpaRepository<Faq, Long> {

    List<Faq> findByIsActiveOrderBySortOrderAsc(String isActive);

    List<Faq> findByIsActiveAndCategoryOrderBySortOrderAsc(String isActive, String category);

    List<Faq> findAllByOrderBySortOrderAsc();
}