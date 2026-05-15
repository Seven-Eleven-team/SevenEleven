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
        // ★ 수정: deleted 제거된 리포지토리 메서드 호출
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

        // ★ 수정: boolean을 "Y"/"N"으로 변환하여 저장
        String isPrimary = (request.isPrimary() || accountRepository.countByUser(user) == 0) ? "Y" : "N";
        if ("Y".equals(isPrimary)) {
            accountRepository.clearAllPrimary(user);
        }

        Account account = Account.builder()
                .user(user)
                .bankName(request.getBankName())
                .accountNumber(request.getAccountNumber())
                .isPrimary(isPrimary)
                .build();

        accountRepository.save(account);
    }

    @Transactional
    public void deleteAccount(Long userId, Long accountId) {
        User user = findUser(userId);
        Account account = findAccountByIdAndUser(accountId, user);

        // ★ 수정: 하드 딜리트로 변경 (설계서에 deleted 컬럼 없음)
        accountRepository.delete(account);

        if ("Y".equals(account.getIsPrimary())) {
            accountRepository.findByUserOrderByIsPrimaryDescCreatedAtDesc(user).stream()
                    .findFirst()
                    .ifPresent(a -> {
                        a.setIsPrimary("Y");
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
        accountRepository.save(account);
    }

    private User findUser(Long userId) {
        return userRepository.findById(userId).orElseThrow(() -> new NotFoundException(ErrorCode.USER_NOT_FOUND));
    }

    private Account findAccountByIdAndUser(Long accountId, User user) {
        return accountRepository.findByIdAndUser(accountId, user)
                .orElseThrow(() -> new NotFoundException(ErrorCode.ACCOUNT_NOT_FOUND));
    }
}
