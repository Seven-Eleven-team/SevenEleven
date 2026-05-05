package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Inquiry;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface InquiryRepository extends JpaRepository<Inquiry, Long> {

    List<Inquiry> findByUserId(Long userId);
}