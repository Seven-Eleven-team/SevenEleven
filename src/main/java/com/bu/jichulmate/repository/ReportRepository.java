package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Report;
import com.bu.jichulmate.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReportRepository extends JpaRepository<Report, Long> {
    // Report 엔티티에 reporter 필드가 있어야 합니다.
    Page<Report> findByReporterOrderByCreatedAtDesc(User reporter, Pageable pageable);
}
