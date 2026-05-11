package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.*;
import com.bu.jichulmate.dto.mypage.*;
import com.bu.jichulmate.exception.*;
import com.bu.jichulmate.repository.*;
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

    public List<Account> getAccountsByUser(Long userId) {
        User user = findUser(userId);
        return accountRepository.findByUserAndDeletedFalseOrderByPrimaryDescCreatedAtDesc(user);
    }

    @Transactional
    public void registerAccount(Long userId, AccountRegisterRequest request) {
        User user = findUser(userId);

        if (accountRepository.countByUserAndDeletedFalse(user) >= MAX_ACCOUNTS) {
            throw new BusinessException(ErrorCode.ACCOUNT_LIMIT_EXCEEDED);
        }
        if (accountRepository.existsByAccountNumberAndDeletedFalse(request.getAccountNumber())) {
            throw new BusinessException(ErrorCode.ACCOUNT_DUPLICATE);
        }

        // 첫 계좌이거나 primary 요청인 경우 처리
        boolean isPrimary = request.isPrimary() || (accountRepository.countByUserAndDeletedFalse(user) == 0);
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

    @Transactional
    public void updateAccount(Long userId, Long accountId, AccountUpdateRequest request) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        if (accountRepository.existsByAccountNumberExcludeId(request.getAccountNumber(), accountId)) {
            throw new BusinessException(ErrorCode.ACCOUNT_DUPLICATE);
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

    @Transactional
    public void deleteAccount(Long userId, Long accountId) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        if (accountRepository.countByUserAndDeletedFalse(user) <= 1) {
            throw new BusinessException(ErrorCode.ACCOUNT_MIN_REQUIRED);
        }

        if (account.isPrimary()) {
            // 다른 계좌 중 하나를 대표 계좌로 승격
            accountRepository.findByUserAndDeletedFalseOrderByPrimaryDescCreatedAtDesc(user).stream()
                    .filter(a -> !a.getId().equals(accountId))
                    .findFirst()
                    .ifPresent(a -> {
                        a.setPrimary(true);
                        accountRepository.save(a);
                    });
        }

        account.setDeleted(true);
        account.setPrimary(false);
        accountRepository.save(account);
    }

    @Transactional
    public void setPrimaryAccount(Long userId, Long accountId) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        accountRepository.clearAllPrimary(user);
        account.setPrimary(true);
        accountRepository.save(account);
    }

    private User findUser(Long userId) {
        return userRepository.findById(userId).orElseThrow(() -> new NotFoundException(ErrorCode.USER_NOT_FOUND));
    }

    private Account findAccountByIdAndUser(Long accountId, User user) {
        return accountRepository.findByIdAndUserAndDeletedFalse(accountId, user)
                .orElseThrow(() -> new NotFoundException(ErrorCode.ACCOUNT_NOT_FOUND));
    }
}
