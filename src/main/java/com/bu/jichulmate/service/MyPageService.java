/*
package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.*;
import com.bu.jichulmate.dto.mypage.MyPageSummaryResponse;
import com.bu.jichulmate.dto.mypage.MyPageSummaryResponse.SubscriptionDetail;
import com.bu.jichulmate.dto.mypage.PinUpdateRequest;
import com.bu.jichulmate.exception.ErrorCode;
import com.bu.jichulmate.exception.NotFoundException;
import com.bu.jichulmate.exception.UnauthorizedException;
import com.bu.jichulmate.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

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
    private final PasswordEncoder passwordEncoder;

    private static final String UPLOAD_DIR = "uploads/profile/";

    // ── 이미지1 - 마이페이지 메인 요약 ───────────────────────

    public MyPageSummaryResponse getMyPageSummary(Long userId) {
        User user = findUser(userId);

        List<Subscription> activeList =
                subscriptionRepository.findByUserAndStatus(user, "ACTIVE");
        long monthlyTotal = activeList.stream()
                .mapToLong(Subscription::getMonthlyFee).sum();
        String nextBilling = activeList.stream()
                .filter(s -> s.getNextBillingDate() != null)
                .map(s -> s.getNextBillingDate().toString())
                .min(String::compareTo)
                .orElse("-");

        List<MyPageSummaryResponse.GoalSummary> goals =
                goalRepository.findTop3ByUserAndDeletedFalseOrderByCreatedAtDesc(user)
                        .stream()
                        .map(g -> {
                            int rate = g.getTargetAmount() == 0 ? 0
                                    : (int) Math.min(
                                    (g.getSavedAmount() * 100L) / g.getTargetAmount(), 100);
                            return MyPageSummaryResponse.GoalSummary.builder()
                                    .goalId(g.getId())
                                    .goalName(g.getGoalName())
                                    .targetAmount(g.getTargetAmount())
                                    .savedAmount(g.getSavedAmount())
                                    .achievementRate(rate)
                                    .build();
                        })
                        .collect(Collectors.toList());

        String primaryBank = "-";
        String primaryAccountNo = "-";
        Account primaryAccount = accountRepository
                .findByUserAndPrimaryTrueAndDeletedFalse(user).orElse(null);
        if (primaryAccount != null) {
            primaryBank = primaryAccount.getBankName();
            primaryAccountNo = maskAccountNumber(primaryAccount.getAccountNumber());
        }

        return MyPageSummaryResponse.builder()
                .userId(user.getId())
                .loginId(user.getUserId())
                .nickname(user.getNickname())
                .email(user.getEmail())
                .gender(user.getGender())
                .birthDate(user.getBirthDate())
                .profileImage(user.getProfileImage())
                .role(user.getRole())
                .sellerRegistered(user.isSellerRegistered())
                .emailNotify(user.isEmailNotify())
                .activeSubscriptionCount(activeList.size())
                .monthlySubscriptionTotal(monthlyTotal)
                .nextBillingDate(nextBilling)
                .goals(goals)
                .primaryBankName(primaryBank)
                .primaryAccountNumber(primaryAccountNo)
                .build();
    }

    // ── MY-01: 회원 정보 변경 (아이디 포함) ──────────────────

    @Transactional
    public void updateProfile(Long userId, String loginId, String nickname,
                              String email, String gender, LocalDate birthDate) {
        User user = findUser(userId);

        // 아이디 중복 체크 (본인 제외)
        if (loginId != null && !loginId.equals(user.getUserId())) {
            if (userRepository.existsByUserId(loginId)) {
                throw new IllegalArgumentException("이미 사용 중인 아이디입니다.");
            }
            user.setUserId(loginId);
        }

        // 이메일 중복 체크 (본인 제외)
        userRepository.findByEmail(email)
                .filter(u -> !u.getId().equals(userId))
                .ifPresent(u -> {
                    throw new IllegalArgumentException("이미 사용 중인 이메일입니다.");
                });

        user.setNickname(nickname);
        user.setEmail(email);
        user.setGender(gender);
        user.setBirthDate(birthDate);
        userRepository.save(user);
    }

    @Transactional
    public void changePassword(Long userId, String currentPassword,
                               String newPassword, String confirmPassword) {
        User user = findUser(userId);
        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            throw new IllegalArgumentException("현재 비밀번호가 일치하지 않습니다.");
        }
        if (!newPassword.equals(confirmPassword)) {
            throw new IllegalArgumentException("새 비밀번호와 확인이 일치하지 않습니다.");
        }
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
    }

    */
/**
     * 프로필 사진 업로드
     *//*

    @Transactional
    public String updateProfileImage(Long userId, MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("파일이 없습니다.");
        }
        String originalName = file.getOriginalFilename();
        String ext = (originalName != null && originalName.contains("."))
                ? originalName.substring(originalName.lastIndexOf("."))
                : ".jpg";
        String savedName = UUID.randomUUID() + ext;

        File dir = new File(UPLOAD_DIR);
        if (!dir.exists()) dir.mkdirs();
        file.transferTo(new File(UPLOAD_DIR + savedName));

        String imageUrl = "/" + UPLOAD_DIR + savedName;
        User user = findUser(userId);
        user.setProfileImage(imageUrl);
        userRepository.save(user);
        return imageUrl;
    }

    // ── MY-02: 보안 설정 (PIN) ────────────────────────────────

    */
/**
     * PIN 번호 변경
     * 실패: "4자리 숫자 필요" 안내
     *//*

    @Transactional
    public void updatePin(Long userId, PinUpdateRequest request) {
        User user = findUser(userId);

        // PIN 형식 검증 (4~6자리 숫자)
        if (!request.getNewPin().matches("^[0-9]{4,6}$")) {
            throw new IllegalArgumentException("4자리 숫자 필요합니다.");
        }

        // 새 PIN 확인 일치 체크
        if (!request.getNewPin().equals(request.getConfirmPin())) {
            throw new IllegalArgumentException("새 PIN과 확인이 일치하지 않습니다.");
        }

        // 현재 PIN 검증 (암호화 저장 방식)
        if (user.getPin() != null
                && !passwordEncoder.matches(request.getCurrentPin(), user.getPin())) {
            throw new IllegalArgumentException("현재 PIN이 일치하지 않습니다.");
        }

        user.setPin(passwordEncoder.encode(request.getNewPin()));
        userRepository.save(user);
    }

    // ── MY-05: 멘토 성향 설정 ─────────────────────────────────

    */
/**
     * 멘토 성향 선택 저장
     * MILD(순한맛) / MEDIUM(중간맛) / SPICY(매운맛)
     *//*

    @Transactional
    public void updateMentorType(Long userId, String mentorType) {
        if (!List.of("MILD", "MEDIUM", "SPICY").contains(mentorType)) {
            throw new IllegalArgumentException("올바르지 않은 멘토 성향 값입니다.");
        }
        User user = findUser(userId);
        user.setMentorType(mentorType);
        userRepository.save(user);
    }

    // ── 이미지2 - 구독 상세 ───────────────────────────────────

    public SubscriptionDetail getSubscriptionDetail(Long userId, Long subscriptionId) {
        Subscription sub = subscriptionRepository.findById(subscriptionId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.SUBSCRIPTION_NOT_FOUND));
        if (!sub.getUser().getId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }

        int remainingDays = 0;
        if (sub.getNextBillingDate() != null) {
            remainingDays = (int) ChronoUnit.DAYS.between(
                    LocalDate.now(), sub.getNextBillingDate());
        }

        return SubscriptionDetail.builder()
                .subscriptionId(sub.getId())
                .serviceName(sub.getServiceName())
                .serviceLogo(sub.getServiceLogo())
                .orderCode(sub.getOrderCode())
                .monthlyFee(sub.getMonthlyFee())
                .status(sub.getStatus())
                .chargeTimeline(sub.getChargeTimeline())
                .chargeDateTime(sub.getChargeDateTime())
                .accountStatus(sub.getAccountStatus())
                .paymentMethod(sub.getPaymentMethod())
                .remainingDays(Math.max(remainingDays, 0))
                .ottUserId(sub.getOttUserId())
                .startDate(sub.getStartDate())
                .nextBillingDate(sub.getNextBillingDate())
                .build();
    }

    // ── 이미지2,3 - 내 구독 관리 / 주문 내역 ─────────────────

    public Page<Subscription> getMySubscriptions(Long userId, Pageable pageable) {
        User user = findUser(userId);
        return subscriptionRepository
                .findByUserAndStatusOrderByCreatedAtDesc(user, "ACTIVE", pageable);
    }

    public Page<Subscription> getMyOrderHistory(Long userId, Pageable pageable) {
        User user = findUser(userId);
        return subscriptionRepository.findByUserOrderByCreatedAtDesc(user, pageable);
    }

    @Transactional
    public void resubscribe(Long userId, Long subscriptionId) {
        User user = findUser(userId);
        Subscription old = subscriptionRepository.findById(subscriptionId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.SUBSCRIPTION_NOT_FOUND));
        if (!old.getUser().getId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }
        Subscription newSub = Subscription.builder()
                .user(user)
                .serviceName(old.getServiceName())
                .serviceLogo(old.getServiceLogo())
                .monthlyFee(old.getMonthlyFee())
                .status("ACTIVE")
                .startDate(LocalDate.now())
                .nextBillingDate(LocalDate.now().plusMonths(1))
                .cancelUrl(old.getCancelUrl())
                .build();
        subscriptionRepository.save(newSub);
    }

    @Transactional
    public void reportSubscription(Long userId, Long subscriptionId, String reason) {
        User user = findUser(userId);
        Subscription sub = subscriptionRepository.findById(subscriptionId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.SUBSCRIPTION_NOT_FOUND));
        if (!sub.getUser().getId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }
        Report report = Report.builder()
                .reporter(user)
                .targetType("SUBSCRIPTION")
                .targetId(subscriptionId)
                .reportReason(reason)
                .build();
        reportRepository.save(report);
    }

    // ── 이미지4 - 내 게시글 보기 ─────────────────────────────

    public Page<Board> getMyBoards(Long userId, Pageable pageable) {
        User user = findUser(userId);
        return boardRepository
                .findByUserAndDeletedFalseOrderByCreatedAtDesc(user, pageable);
    }

    @Transactional
    public void deleteMyBoard(Long userId, Long boardId) {
        User user = findUser(userId);
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.BOARD_NOT_FOUND));
        if (!board.getUser().getId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }
        board.setDeleted(true);
        boardRepository.save(board);
    }

    // ── 이미지5 - 내 문의 ─────────────────────────────────────

    public Page<Inquiry> getMyInquiries(Long userId, Pageable pageable) {
        User user = findUser(userId);
        return inquiryRepository.findByUserOrderByCreatedAtDesc(user, pageable);
    }

    @Transactional
    public void deleteMyInquiry(Long userId, Long inquiryId) {
        User user = findUser(userId);
        Inquiry inquiry = inquiryRepository.findById(inquiryId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.INQUIRY_NOT_FOUND));
        if (!inquiry.getUser().getId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }
        if ("ANSWERED".equals(inquiry.getStatus())) {
            throw new IllegalStateException("답변된 문의는 삭제할 수 없습니다.");
        }
        inquiryRepository.delete(inquiry);
    }

    // ── MY-07: 알림 ───────────────────────────────────────────

    public Page<NotificationLog> getMyNotifications(Long userId, Pageable pageable) {
        User user = findUser(userId);
        return notificationLogRepository.findByUserOrderByCreatedAtDesc(user, pageable);
    }

    @Transactional
    public boolean toggleEmailNotify(Long userId) {
        User user = findUser(userId);
        user.setEmailNotify(!user.isEmailNotify());
        userRepository.save(user);
        return user.isEmailNotify();
    }

    @Transactional
    public void markNotificationAsRead(Long userId, Long notificationId) {
        NotificationLog log = notificationLogRepository.findById(notificationId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.NOTIFICATION_NOT_FOUND));
        if (!log.getUser().getId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }
        log.setRead(true);
        notificationLogRepository.save(log);
    }

    // ── 내 판매 목록 ──────────────────────────────────────────

    public Page<PartyPost> getMyPartyPosts(Long userId, Pageable pageable) {
        User user = findUser(userId);
        return partyRepository.findByHostUserOrderByCreatedAtDesc(user, pageable);
    }

    public PartyPost getMyPartyPostDetail(Long userId, Long partyId) {
        PartyPost post = partyRepository.findById(partyId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.PARTY_NOT_FOUND));
        if (!post.getHostUser().getId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }
        return post;
    }

    public Page<PartyMember> getPartyMembers(Long userId, Long partyId, Pageable pageable) {
        PartyPost post = partyRepository.findById(partyId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.PARTY_NOT_FOUND));
        if (!post.getHostUser().getId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }
        return partyRepository.findMembersByPartyId(partyId, pageable);
    }

    @Transactional
    public void completePartyTrade(Long userId, Long partyId) {
        PartyPost post = partyRepository.findById(partyId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.PARTY_NOT_FOUND));
        if (!post.getHostUser().getId().equals(userId)) {
            throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        }
        post.setStatus("COMPLETED");
        partyRepository.save(post);
    }

    // ── 회원 탈퇴 ─────────────────────────────────────────────

    @Transactional
    public void withdrawUser(Long userId, String password) {
        User user = findUser(userId);
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }
        user.setStatus("WITHDRAWN");
        userRepository.save(user);
    }

    // ── private ──────────────────────────────────────────────

    private User findUser(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new NotFoundException(ErrorCode.USER_NOT_FOUND));
    }

    private String maskAccountNumber(String accountNumber) {
        if (accountNumber == null || accountNumber.length() < 4) return accountNumber;
        return "****" + accountNumber.substring(accountNumber.length() - 4);
    }
}*/
