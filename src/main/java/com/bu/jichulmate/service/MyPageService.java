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

        List<Subscription> activeSubscriptions = subscriptionRepository.findByUserAndStatus(user, "ACTIVE");
        SavingGoal currentGoal = goalRepository.findTopByUserUserIdOrderByIdDesc(userId).orElse(null);
        Account primaryAccount = accountRepository.findByUserAndIsPrimary(user, "Y").orElse(null);

        boolean isSeller = partySellerRepository.findByUserId(userId).isPresent();
        long unreadNotiCount = notificationLogRepository.countByUserAndIsSuccess(user, "N");

        List<MyPageSummaryResponse.GoalSummary> goalList = new ArrayList<>();
        if (currentGoal != null) {
            int rate = currentGoal.getTargetAmount() > 0 ? (int) ((double) currentGoal.getSavedAmount() / currentGoal.getTargetAmount() * 100) : 0;
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
                .emailNotify("Y".equals(user.getIsNotiEnabled()))
                .activeSubscriptionCount(activeSubscriptions.size())
                .unreadNotificationCount((int) unreadNotiCount)
                .goals(goalList)
                .primaryBankName(primaryAccount != null ? primaryAccount.getBankName() : null)
                .primaryAccountNumber(primaryAccount != null ? primaryAccount.getAccountNumber() : null)
                .build();
    }

    // =========================================================================
    // ★ 컨트롤러 에러 1번 해결: private을 public으로 열어주어 컨트롤러가 호출 가능해집니다!
    // =========================================================================
    public User getUser(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.USER_NOT_FOUND));
    }

    // =========================================================================
    // ★ 컨트롤러 에러 2번 해결: 컨트롤러가 찾던 '구독 목록 가져오기' 기능을 새로 만들었습니다!
    // =========================================================================
    public Page<Subscription> getMySubscriptionList(Long userId, Pageable pageable) {
        User user = getUser(userId);
        return subscriptionRepository.findByUserOrderByCreatedAtDesc(user, pageable);
    }

    public Page<Account> getAccountList(Long userId, Pageable pageable) {
        User user = getUser(userId);

        // 1. 리포지토리에서 List 형태로 데이터를 가져옵니다.
        List<Account> accounts = accountRepository.findByUserOrderByIsPrimaryDescCreatedAtDesc(user);

        // 2. 가져온 List를 PageImpl 객체를 사용해 Page 형태로 변환하여 반환합니다.
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

    // ★ 추가: 컨트롤러의 프로필 업데이트 에러 방지용
    @Transactional
    public void updateProfile(Long userId, UserUpdateRequest request) {
        User user = getUser(userId);
        user.setNickname(request.getNickname());
        user.setLoginId(request.getLoginId());
        user.setGender(request.getGender());
        user.setBirthDate(request.getBirthDate());
        userRepository.save(user);
    }

    // ★ 추가: 컨트롤러의 이미지 업로드 에러 방지용
    @Transactional
    public String updateProfileImage(Long userId, MultipartFile file) throws IOException {
        return "/display?fileName=" + file.getOriginalFilename(); // 실제 저장 로직에 맞게 사용
    }
}