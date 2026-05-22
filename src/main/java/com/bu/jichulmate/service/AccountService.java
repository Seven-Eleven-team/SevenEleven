package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Account;
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.mypage.AccountRegisterRequest;
import com.bu.jichulmate.exception.BusinessException;
import com.bu.jichulmate.exception.ErrorCode;
import com.bu.jichulmate.exception.NotFoundException;
import com.bu.jichulmate.repository.AccountRepository;
import com.bu.jichulmate.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
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
        return accountRepository.findByUserOrderByIsPrimaryDescCreatedAtDesc(user);
    }

    @Transactional
    public void registerAccount(Long userId, AccountRegisterRequest request) {
        User user = findUser(userId);

        if (accountRepository.countByUser(user) >= MAX_ACCOUNTS) {
            throw new BusinessException(ErrorCode.ACCOUNT_LIMIT_EXCEEDED);
        }

        if (accountRepository.existsByAccountNumber(request.getAccountNumber())) {
            throw new BusinessException(ErrorCode.ACCOUNT_DUPLICATE);
        }

        // 대표 계좌 처리
        String isPrimary = "N";
        if (request.isPrimary() || accountRepository.countByUser(user) == 0) {
            isPrimary = "Y";
            accountRepository.clearAllPrimary(user);
        }

        // @CreationTimestamp가 엔티티에 있지만 명시적으로도 설정 (이중 안전장치)
        Account account = Account.builder()
                .user(user)
                .bankName(request.getBankName())
                .accountNumber(request.getAccountNumber())
                .isPrimary(isPrimary)
                .createdAt(LocalDateTime.now())   // ← 명시적 설정
                .updatedAt(LocalDateTime.now())   // ← 명시적 설정
                .build();

        accountRepository.save(account);
    }

    @Transactional
    public void deleteAccount(Long userId, Long accountId) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        accountRepository.delete(account);

        // 삭제한 계좌가 대표계좌였다면 새 대표계좌 지정
        if ("Y".equals(account.getIsPrimary())) {
            accountRepository.findByUserOrderByIsPrimaryDescCreatedAtDesc(user)
                    .stream().findFirst()
                    .ifPresent(a -> {
                        a.setIsPrimary("Y");
                        a.setUpdatedAt(LocalDateTime.now());
                        accountRepository.save(a);
                    });
        }
    }

    @Transactional
    public void setPrimaryAccount(Long userId, Long accountId) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        accountRepository.clearAllPrimary(user);
        account.setIsPrimary("Y");
        account.setUpdatedAt(LocalDateTime.now());
        accountRepository.save(account);
    }

    private User findUser(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.USER_NOT_FOUND));
    }

    private Account findAccountByIdAndUser(Long accountId, User user) {
        return accountRepository.findByIdAndUser(accountId, user)
                .orElseThrow(() -> new NotFoundException(ErrorCode.ACCOUNT_NOT_FOUND));
    }
}