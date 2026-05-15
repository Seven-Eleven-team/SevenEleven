package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.PartySeller;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PartySellerRepository extends JpaRepository<PartySeller, Long> {
    Optional<PartySeller> findByUserId(Long userId);
    List<PartySeller> findAll();
}