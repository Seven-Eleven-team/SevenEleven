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

    // 삭제되지 않은 계좌만 조회 (대표 우선)
    List<Account> findByUserAndDeletedFalseOrderByPrimaryDescCreatedAtDesc(User user);

    // 본인 소유 + 삭제 안된 계좌 단건 조회
    Optional<Account> findByIdAndUserAndDeletedFalse(Long id, User user);

    // 대표 계좌 조회
    Optional<Account> findByUserAndPrimaryTrueAndDeletedFalse(User user);

    // 삭제 안된 계좌 수
    long countByUserAndDeletedFalse(User user);

    // MY-03, MY-04: 계좌번호 중복 체크 (본인 제외, 삭제 안된 것만)
    @Query("SELECT COUNT(a) > 0 FROM Account a " +
            "WHERE a.accountNumber = :accountNumber " +
            "AND a.deleted = false " +
            "AND a.id <> :excludeId")
    boolean existsByAccountNumberExcludeId(
            @Param("accountNumber") String accountNumber,
            @Param("excludeId") Long excludeId);

    // 계좌번호 중복 체크 (신규 등록용)
    boolean existsByAccountNumberAndDeletedFalse(String accountNumber);

    // 대표 전체 해제
    @Modifying
    @Query("UPDATE Account a SET a.primary = false WHERE a.user = :user AND a.deleted = false")
    void clearAllPrimary(@Param("user") User user);

    // 특정 계좌 제외 대표 해제
    @Modifying
    @Query("UPDATE Account a SET a.primary = false " +
            "WHERE a.user = :user AND a.id <> :excludeId AND a.deleted = false")
    void clearPrimaryExcept(@Param("user") User user, @Param("excludeId") Long excludeId);
}