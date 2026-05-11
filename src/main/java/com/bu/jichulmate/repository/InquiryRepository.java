package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Inquiry;
import com.bu.jichulmate.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InquiryRepository extends JpaRepository<Inquiry, Long> {
    Page<Inquiry> findByUserOrderByCreatedAtDesc(User user, Pageable pageable);
}
