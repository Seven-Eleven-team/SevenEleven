package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    // isActive 컬럼이 삭제되었으므로, 해당 조건으로 검색하던 메서드를 깔끔하게 지웠습니다.
    // 카테고리는 삭제(비활성화) 개념이 없어졌으므로 JpaRepository의 기본 findAll() 등을 쓰면 됩니다.
}