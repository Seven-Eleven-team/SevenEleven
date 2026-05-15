package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.SubscriptionMaster;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SubscriptionMasterRepository extends JpaRepository<SubscriptionMaster, Long> {
}