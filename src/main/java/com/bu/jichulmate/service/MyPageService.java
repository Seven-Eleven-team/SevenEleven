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
                .nickname(user.getNickname())
                .gender(user.getGender())
                .birthDate(user.getBirthDate())
                .role(user.getRole())
                .sellerRegistered(isSeller)

                // DB 2.0 기준:
                // 기존 EMAIL_NOTIFY → 현재 IS_NOTI_ENABLED
                // MyPageSummaryResponse의 emailNotify 필드는 유지하되,
                // User 엔티티의 isNotiEnabled 값을 boolean으로 변환해서 넣는다.
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
        User user = getUser(userId);
        return boardRepository.findByUserAndIsDeletedOrderByCreatedAtDesc(user, "N", pageable);
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
        // DB 2.0 USERS 테이블에는 PROFILE_IMAGE 컬럼이 없다.
        // 그래서 여기서는 User 엔티티에 저장하지 않고, 임시 반환만 유지한다.
        // 실제 이미지 저장 기능을 살리려면 ATTACHMENTS 또는 별도 PROFILE_IMAGE 테이블 기준으로 다시 연결해야 한다.
        return "/display?fileName=" + file.getOriginalFilename();
    }

    private boolean isNotificationEnabled(User user) {
        return "Y".equalsIgnoreCase(user.getIsNotiEnabled());
    }
}