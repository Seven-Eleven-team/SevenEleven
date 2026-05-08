package com.bu.jichulmate.faq.repository;

import com.bu.jichulmate.faq.entity.Faq;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FaqRepository extends JpaRepository<Faq, Long> {

    List<Faq> findByIsActiveOrderBySortOrderAsc(String isActive);

    List<Faq> findByIsActiveAndCategoryOrderBySortOrderAsc(String isActive, String category);



    List<Faq> findAllByOrderBySortOrderAsc();
}