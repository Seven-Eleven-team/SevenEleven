package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.*;
import com.bu.jichulmate.dto.mypage.*;
import com.bu.jichulmate.dto.user.UserUpdateRequest;
import com.bu.jichulmate.exception.*;
import com.bu.jichulmate.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MyPageService {

    private final UserRepository userRepository;
    private final SubscriptionRepository subscriptionRepository;
    private final GoalRepository goalRepository;
    private final AccountRepository accountRepository;
    private final BoardRepository boardRepository;
    private final InquiryRepository inquiryRepository;
    private final ReportRepository reportRepository;
    private final NotificationLogRepository notificationLogRepository;
    private final PartyRepository partyRepository;
    private final PartySellerRepository partySellerRepository;
    private final PasswordEncoder passwordEncoder;

    public MyPageSummaryResponse getMyPageSummary(Long userId) {
        User user = getUser(userId);

        List<Subscription> activeSubscriptions =
                subscriptionRepository.findByUserAndStatus(user, "ACTIVE");

        SavingGoal currentGoal =
                goalRepository.findTopByUserUserIdOrderByIdDesc(userId).orElse(null);

        Account primaryAccount =
                accountRepository.findByUserAndIsPrimary(user, "Y").orElse(null);

        boolean isSeller =
                partySellerRepository.findByUserId(userId).isPresent();

        long unreadNotiCount =
                notificationLogRepository.countByUserAndIsSuccess(user, "N");

        List<MyPageSummaryResponse.GoalSummary> goalList = new ArrayList<>();

        if (currentGoal != null) {
            int rate = currentGoal.getTargetAmount() > 0
                    ? (int) ((double) currentGoal.getSavedAmount() / currentGoal.getTargetAmount() * 100)
                    : 0;

            goalList.add(MyPageSummaryResponse.GoalSummary.builder()
                    .goalId(currentGoal.getId())
                    .goalName(currentGoal.getGoalName())
                    .targetAmount(currentGoal.getTargetAmount())
                    .savedAmount(currentGoal.getSavedAmount())
                    .achievementRate(rate)
                    .build());
        }

        return MyPageSummaryResponse.builder()
                .userId(user.getUserId())
                .loginId(user.getLoginId())
                .email(user.getLoginId())           // ← 수정 완료 (getEmail → getLoginId)
                .nickname(user.getNickname())
                .gender(user.getGender())
                .birthDate(user.getBirthDate())
                .role(user.getRole())
                .sellerRegistered(isSeller)
                .emailNotify(isNotificationEnabled(user))
                .activeSubscriptionCount(activeSubscriptions.size())
                .unreadNotificationCount((int) unreadNotiCount)
                .goals(goalList)
                .primaryBankName(primaryAccount != null ? primaryAccount.getBankName() : null)
                .primaryAccountNumber(primaryAccount != null ? primaryAccount.getAccountNumber() : null)
                .build();
    }

    public User getUser(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.USER_NOT_FOUND));
    }

    public Page<Subscription> getMySubscriptionList(Long userId, Pageable pageable) {
        User user = getUser(userId);
        return subscriptionRepository.findByUserOrderByCreatedAtDesc(user, pageable);
    }

    public Page<Account> getAccountList(Long userId, Pageable pageable) {
        User user = getUser(userId);

        List<Account> accounts =
                accountRepository.findByUserOrderByIsPrimaryDescCreatedAtDesc(user);

        return new PageImpl<>(accounts, pageable, accounts.size());
    }

    public Page<Board> getMyBoardList(Long userId, Pageable pageable) {
        /*
         * 기존 코드:
         * boardRepository.findByUserAndIsDeletedOrderByCreatedAtDesc(user, "N", pageable)
         *
         * 현재 BoardRepository는 userId 기준 메서드를 가지고 있으므로,
         * Board.USER_ID 컬럼과 직접 매칭되는 userId 기준 조회로 통일한다.
         *
         * getUser(userId)는 회원 존재 여부 검증을 위해 유지한다.
         */
        getUser(userId);

        return boardRepository.findByUserIdAndIsDeletedOrderByCreatedAtDesc(
                userId,
                "N",
                pageable
        );
    }

    public Page<PartyPost> getMyPartyList(Long userId, Pageable pageable) {
        return partyRepository.findBySellerUserIdOrderByCreatedAtDesc(userId, pageable);
    }

    public PartyPost getPartyDetail(Long userId, Long pId) {
        PartyPost post = partyRepository.findById(pId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.PARTY_NOT_FOUND));

        if (!post.getSeller().getUserId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }

        return post;
    }

    @Transactional
    public void completePartyTrade(Long userId, Long pId) {
        PartyPost post = partyRepository.findById(pId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.PARTY_NOT_FOUND));

        if (!post.getSeller().getUserId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }

        post.setStatus("FULL");
        partyRepository.save(post);
    }

    @Transactional
    public void withdrawUser(Long userId, String password) {
        User user = getUser(userId);

        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new ValidationException(ErrorCode.PASSWORD_MISMATCH);
        }

        user.setAccountStatus("WITHDRAWN");
        userRepository.save(user);
    }

    @Transactional
    public void updateProfile(Long userId, UserUpdateRequest request) {
        User user = getUser(userId);

        user.setNickname(request.getNickname());
        user.setLoginId(request.getLoginId());
        user.setGender(request.getGender());
        user.setBirthDate(request.getBirthDate());

        userRepository.save(user);
    }

    @Transactional
    public String updateProfileImage(Long userId, MultipartFile file) throws IOException {
        return "/display?fileName=" + file.getOriginalFilename();
    }

    private boolean isNotificationEnabled(User user) {
        return "Y".equalsIgnoreCase(user.getIsNotiEnabled());
    }
}