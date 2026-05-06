package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Account;
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.mypage.AccountRegisterRequest;
import com.bu.jichulmate.dto.mypage.AccountUpdateRequest;
import com.bu.jichulmate.exception.BusinessException;
import com.bu.jichulmate.exception.ErrorCode;
import com.bu.jichulmate.exception.NotFoundException;
import com.bu.jichulmate.repository.AccountRepository;
import com.bu.jichulmate.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AccountService {

    private static final int MAX_ACCOUNTS = 5;

    private final AccountRepository accountRepository;
    private final UserRepository userRepository;

    /** 계좌 목록 조회 (삭제된 계좌 제외) */
    public List<Account> getAccountsByUser(Long userId) {
        User user = findUser(userId);
        return accountRepository
                .findByUserAndDeletedFalseOrderByPrimaryDescCreatedAtDesc(user);
    }

    /**
     * MY-03: 계좌 등록
     * - 최대 5개 제한
     * - 계좌번호 중복 시 "이미 존재하거나, 유효하지 않는 계좌입니다." 에러
     */
    @Transactional
    public void registerAccount(Long userId, AccountRegisterRequest request) {
        User user = findUser(userId);

        long count = accountRepository.countByUserAndDeletedFalse(user);
        if (count >= MAX_ACCOUNTS) {
            throw new BusinessException(ErrorCode.ACCOUNT_LIMIT_EXCEEDED);
        }

        // MY-03: 계좌번호 중복 체크
        if (accountRepository.existsByAccountNumberAndDeletedFalse(
                request.getAccountNumber())) {
            throw new IllegalArgumentException(
                    "이미 존재하거나, 유효하지 않는 계좌입니다.");
        }

        // 첫 계좌이거나 대표 요청이면 기존 대표 해제
        boolean isPrimary = request.isPrimary() || (count == 0);
        if (isPrimary) {
            accountRepository.clearAllPrimary(user);
        }

        accountRepository.save(Account.builder()
                .user(user)
                .bankName(request.getBankName())
                .accountNumber(request.getAccountNumber())
                .accountHolder(request.getAccountHolder())
                .primary(isPrimary)
                .build());
    }

    /**
     * MY-04: 계좌 수정
     * - 계좌번호 중복 시 "이미 존재하거나, 유효하지 않는 계좌입니다." 에러
     */
    @Transactional
    public void updateAccount(Long userId, Long accountId, AccountUpdateRequest request) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        // MY-04: 계좌번호 중복 체크 (본인 계좌 제외)
        if (accountRepository.existsByAccountNumberExcludeId(
                request.getAccountNumber(), accountId)) {
            throw new IllegalArgumentException(
                    "이미 존재하거나, 유효하지 않는 계좌입니다.");
        }

        if (request.isPrimary()) {
            accountRepository.clearAllPrimary(user);
        }

        account.setBankName(request.getBankName());
        account.setAccountNumber(request.getAccountNumber());
        account.setAccountHolder(request.getAccountHolder());
        account.setPrimary(request.isPrimary());
        accountRepository.save(account);
    }

    /**
     * MY-06: 계좌 삭제 (soft delete)
     * - 계좌가 1개이면 삭제 불가 "최소 1개 계좌 필요"
     * - IS_DELETED = true 처리
     * - 대표계좌 삭제 시 다음 계좌 자동 대표 승계
     */
    @Transactional
    public void deleteAccount(Long userId, Long accountId) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        // MY-06: 최소 1개 계좌 체크
        long count = accountRepository.countByUserAndDeletedFalse(user);
        if (count <= 1) {
            throw new IllegalStateException("최소 1개 계좌가 필요합니다.");
        }

        // 대표계좌 삭제 시 다른 계좌 자동 대표 승계
        if (account.isPrimary()) {
            accountRepository
                    .findByUserAndDeletedFalseOrderByPrimaryDescCreatedAtDesc(user)
                    .stream()
                    .filter(a -> !a.getId().equals(accountId))
                    .findFirst()
                    .ifPresent(a -> {
                        a.setPrimary(true);
                        accountRepository.save(a);
                    });
        }

        // MY-06: soft delete (IS_DELETED = 'Y')
        account.setDeleted(true);
        account.setPrimary(false);
        accountRepository.save(account);
    }

    /** 대표계좌 변경 */
    @Transactional
    public void setPrimaryAccount(Long userId, Long accountId) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        accountRepository.clearAllPrimary(user);
        account.setPrimary(true);
        accountRepository.save(account);
    }

    // ── private ──────────────────────────────────────────────

    private User findUser(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.USER_NOT_FOUND));
    }

    private Account findAccountByIdAndUser(Long accountId, User user) {
        return accountRepository.findByIdAndUserAndDeletedFalse(accountId, user)
                .orElseThrow(() -> new NotFoundException(ErrorCode.ACCOUNT_NOT_FOUND));
    }
}