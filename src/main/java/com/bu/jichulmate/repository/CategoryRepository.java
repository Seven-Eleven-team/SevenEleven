package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    List<Category> findByIsActive(String isActive); // 활성화된 카테고리만 조회

}