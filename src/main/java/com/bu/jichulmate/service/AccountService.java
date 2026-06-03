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

        String isPrimary = determineIsPrimary(user, request.isPrimary());

        Account account = Account.builder()
                .user(user)
                .bankName(request.getBankName())
                .accountNumber(request.getAccountNumber())
                .isPrimary(isPrimary)
                .build();

        accountRepository.save(account);
    }

    @Transactional
    public void updateAccount(Long userId, Long accountId, AccountRegisterRequest request) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        // 계좌번호가 변경된 경우에만 중복 체크
        if (!account.getAccountNumber().equals(request.getAccountNumber()) &&
                accountRepository.existsByAccountNumber(request.getAccountNumber())) {
            throw new BusinessException(ErrorCode.ACCOUNT_DUPLICATE);
        }

        String newIsPrimary = determineIsPrimary(user, request.isPrimary());

        account.setBankName(request.getBankName());
        account.setAccountNumber(request.getAccountNumber());
        account.setIsPrimary(newIsPrimary);
        account.setUpdatedAt(LocalDateTime.now());

        accountRepository.save(account);
    }

    private String determineIsPrimary(User user, boolean requestedPrimary) {
        long accountCount = accountRepository.countByUser(user);

        if (requestedPrimary || accountCount == 0) {
            accountRepository.clearAllPrimary(user);
            return "Y";
        }
        return "N";
    }

    @Transactional
    public void deleteAccount(Long userId, Long accountId) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        boolean wasPrimary = "Y".equals(account.getIsPrimary());

        accountRepository.delete(account);

        // 대표 계좌를 삭제한 경우 새 대표 계좌 지정
        if (wasPrimary) {
            accountRepository.findByUserOrderByIsPrimaryDescCreatedAtDesc(user)
                    .stream().findFirst()
                    .ifPresent(next -> {
                        next.setIsPrimary("Y");
                        next.setUpdatedAt(LocalDateTime.now());
                        accountRepository.save(next);
                    });
        }
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