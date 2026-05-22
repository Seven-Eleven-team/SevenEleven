package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.Account;
import com.bu.jichulmate.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AccountRepository extends JpaRepository<Account, Long> {

    List<Account> findByUserOrderByIsPrimaryDescCreatedAtDesc(User user);
    Optional<Account> findByIdAndUser(Long id, User user);
    Optional<Account> findByUserAndIsPrimary(User user, String isPrimary);
    long countByUser(User user);

    boolean existsByAccountNumber(String accountNumber);

    @Modifying
    @Query("UPDATE Account a SET a.isPrimary = 'N' WHERE a.user = :user")
    void clearAllPrimary(@Param("user") User user);
}