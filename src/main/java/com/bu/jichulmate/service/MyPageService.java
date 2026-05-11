package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.*;
import com.bu.jichulmate.dto.mypage.*;
import com.bu.jichulmate.dto.mypage.MyPageSummaryResponse.*;
import com.bu.jichulmate.exception.*;
import com.bu.jichulmate.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.time.*;
import java.time.temporal.ChronoUnit;
import java.util.*;
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

    public MyPageSummaryResponse getMyPageSummary(Long userId) {
        User user = findUser(userId);

        List<Subscription> activeList = subscriptionRepository.findByUserAndStatus(user, "ACTIVE");
        long monthlyTotal = activeList.stream().mapToLong(Subscription::getMonthlyFee).sum();
        String nextBilling = activeList.stream()
                .filter(s -> s.getNextBillingDate() != null)
                .map(s -> s.getNextBillingDate().toString())
                .min(String::compareTo).orElse("-");

        List<GoalSummary> goals = goalRepository.findTop3ByUserAndDeletedFalseOrderByCreatedAtDesc(user).stream()
                .map(g -> {
                    long target = g.getTargetAmount();
                    long saved = g.getSavedAmount();
                    int rate = target == 0 ? 0 : (int) Math.min((saved * 100L) / target, 100);
                    return GoalSummary.builder()
                            .goalId(g.getId()).goalName(g.getGoalName())
                            .targetAmount(target).savedAmount(saved).achievementRate(rate).build();
                }).collect(Collectors.toList());

        Account primaryAccount = accountRepository.findByUserAndPrimaryTrueAndDeletedFalse(user).orElse(null);

        return MyPageSummaryResponse.builder()
                .userId(user.getUserId())
                .loginId(user.getLoginId())
                .nickname(user.getNickname())
                .email(user.getEmail()) // ✅ 수정완료: getLoginId() -> getEmail()
                .gender(user.getGender())
                .birthDate(user.getBirthDate())
                .profileImage(user.getProfileImage())
                .role(user.getRole())
                .sellerRegistered(false)
                .emailNotify(user.isEmailNotify())
                .activeSubscriptionCount(activeList.size())
                .monthlySubscriptionTotal(monthlyTotal)
                .nextBillingDate(nextBilling)
                .goals(goals)
                .primaryBankName(primaryAccount != null ? primaryAccount.getBankName() : "-")
                .primaryAccountNumber(primaryAccount != null ? maskAccountNumber(primaryAccount.getAccountNumber()) : "-")
                .build();
    }

    @Transactional
    public void updateProfile(Long userId, String loginId, String nickname, String email, String gender, LocalDate birthDate) {
        User user = findUser(userId);
        if (loginId != null && !loginId.equals(user.getLoginId()) && userRepository.existsByLoginId(loginId))
            throw new DuplicateException(ErrorCode.DUPLICATE_LOGIN_ID);
        if (nickname != null && !nickname.equals(user.getNickname()) && userRepository.existsByNickname(nickname))
            throw new DuplicateException(ErrorCode.DUPLICATE_NICKNAME);

        user.setLoginId(loginId);
        user.setNickname(nickname);
        user.setEmail(email); // ✅ 수정완료: 이메일 업데이트 누락 해결
        user.setGender(gender);
        user.setBirthDate(birthDate);
        userRepository.save(user);
    }

    @Transactional
    public void changePassword(Long userId, String current, String newPwd, String confirm) {
        User user = findUser(userId);
        if (!passwordEncoder.matches(current, user.getPassword())) throw new ValidationException(ErrorCode.PASSWORD_MISMATCH);
        if (!newPwd.equals(confirm)) throw new ValidationException(ErrorCode.INVALID_INPUT, "비밀번호 불일치");
        user.setPassword(passwordEncoder.encode(newPwd));
        userRepository.save(user);
    }

    @Transactional
    public String updateProfileImage(Long userId, MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) throw new ValidationException(ErrorCode.INVALID_INPUT, "파일 없음");
        String savedName = UUID.randomUUID() + ".jpg";
        File dir = new File(UPLOAD_DIR); if (!dir.exists()) dir.mkdirs();
        file.transferTo(new File(UPLOAD_DIR + savedName));
        User user = findUser(userId);
        user.setProfileImage("/" + UPLOAD_DIR + savedName);
        userRepository.save(user);
        return user.getProfileImage();
    }

    @Transactional
    public void updatePin(Long userId, PinUpdateRequest request) {
        if (!request.getNewPin().matches("^[0-9]{4,6}$")) throw new ValidationException(ErrorCode.INVALID_INPUT, "PIN 형식 오류");
        if (!request.getNewPin().equals(request.getConfirmPin())) throw new ValidationException(ErrorCode.INVALID_INPUT, "PIN 불일치");
        User user = findUser(userId);
        user.setPin(passwordEncoder.encode(request.getNewPin()));
        userRepository.save(user);
    }

    @Transactional
    public void updateMentorType(Long userId, String type) {
        // AI 멘토 성향 (MILD, MEDIUM, SPICY) 대문자 저장
        String upperType = type.toUpperCase();
        if (!List.of("MILD", "MEDIUM", "SPICY").contains(upperType)) throw new ValidationException(ErrorCode.INVALID_INPUT, "잘못된 성향");
        User user = findUser(userId);
        user.setMentorTone(upperType);
        userRepository.save(user);
    }

    public SubscriptionDetail getSubscriptionDetail(Long userId, Long subId) {
        Subscription sub = subscriptionRepository.findById(subId).orElseThrow(() -> new NotFoundException(ErrorCode.SUBSCRIPTION_NOT_FOUND));
        if (!sub.getUser().getUserId().equals(userId)) throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        int days = sub.getNextBillingDate() != null ? (int) ChronoUnit.DAYS.between(LocalDate.now(), sub.getNextBillingDate()) : 0;
        return SubscriptionDetail.builder()
                .subscriptionId(sub.getId()).serviceName(sub.getServiceName()).serviceLogo(sub.getServiceLogo())
                .orderCode(sub.getOrderCode()).monthlyFee(sub.getMonthlyFee()).status(sub.getStatus())
                .chargeTimeline(sub.getChargeTimeline()).chargeDateTime(sub.getChargeDateTime())
                .accountStatus(sub.getAccountStatus()).paymentMethod(sub.getPaymentMethod())
                .remainingDays(Math.max(days, 0)).ottUserId(sub.getOttUserId()).startDate(sub.getStartDate())
                .nextBillingDate(sub.getNextBillingDate()).build();
    }

    public Page<Subscription> getMySubscriptions(Long userId, Pageable p) { return subscriptionRepository.findByUserAndStatusOrderByCreatedAtDesc(findUser(userId), "ACTIVE", p); }
    public Page<Subscription> getMyOrderHistory(Long userId, Pageable p) { return subscriptionRepository.findByUserOrderByCreatedAtDesc(findUser(userId), p); }

    @Transactional
    public void resubscribe(Long userId, Long subId) {
        User user = findUser(userId);
        Subscription old = subscriptionRepository.findById(subId).orElseThrow(() -> new NotFoundException(ErrorCode.SUBSCRIPTION_NOT_FOUND));
        if (!old.getUser().getUserId().equals(userId)) throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        subscriptionRepository.save(Subscription.builder()
                .user(user).serviceName(old.getServiceName()).serviceLogo(old.getServiceLogo())
                .monthlyFee(old.getMonthlyFee()).status("ACTIVE").startDate(LocalDate.now())
                .nextBillingDate(LocalDate.now().plusMonths(1)).cancelUrl(old.getCancelUrl()).build());
    }

    @Transactional
    public void reportSubscription(Long userId, Long subId, String reason) {
        User user = findUser(userId);
        Subscription sub = subscriptionRepository.findById(subId).orElseThrow(() -> new NotFoundException(ErrorCode.SUBSCRIPTION_NOT_FOUND));
        if (!sub.getUser().getUserId().equals(userId)) throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        reportRepository.save(Report.builder().reporter(user).targetType("SUBSCRIPTION").targetId(subId).reportReason(reason).build());
    }

    public Page<Board> getMyBoards(Long userId, Pageable p) { return boardRepository.findByUserAndDeletedFalseOrderByCreatedAtDesc(findUser(userId), p); }
    @Transactional
    public void deleteMyBoard(Long userId, Long bId) {
        Board b = boardRepository.findById(bId).orElseThrow(() -> new NotFoundException(ErrorCode.BOARD_NOT_FOUND));
        if (!b.getUser().getUserId().equals(userId)) throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        b.setDeleted(true); boardRepository.save(b);
    }

    public Page<Inquiry> getMyInquiries(Long userId, Pageable p) { return inquiryRepository.findByUserOrderByCreatedAtDesc(findUser(userId), p); }
    @Transactional
    public void deleteMyInquiry(Long userId, Long iId) {
        Inquiry i = inquiryRepository.findById(iId).orElseThrow(() -> new NotFoundException(ErrorCode.INQUIRY_NOT_FOUND));
        if (!i.getUser().getUserId().equals(userId)) throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        if ("ANSWERED".equals(i.getStatus())) throw new BusinessException(ErrorCode.INVALID_INPUT, "답변 완료된 문의 삭제 불가");
        inquiryRepository.delete(i);
    }

    public Page<Report> getMyReports(Long userId, Pageable p) { return reportRepository.findByReporterOrderByCreatedAtDesc(findUser(userId), p); }
    public Page<NotificationLog> getMyNotifications(Long userId, Pageable p) { return notificationLogRepository.findByUserOrderByCreatedAtDesc(findUser(userId), p); }

    @Transactional
    public boolean toggleEmailNotify(Long userId) {
        User user = findUser(userId);
        user.setEmailNotify(!user.isEmailNotify());
        userRepository.save(user);
        return user.isEmailNotify();
    }

    @Transactional
    public void markNotificationAsRead(Long userId, Long nId) {
        NotificationLog log = notificationLogRepository.findById(nId).orElseThrow(() -> new NotFoundException(ErrorCode.NOTIFICATION_NOT_FOUND));
        if (!log.getUser().getUserId().equals(userId)) throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        log.setRead(true); notificationLogRepository.save(log);
    }

    public Page<PartyPost> getMyPartyPosts(Long userId, Pageable p) { return partyRepository.findByHostUserOrderByCreatedAtDesc(findUser(userId), p); }
    public PartyPost getMyPartyPostDetail(Long userId, Long pId) {
        PartyPost post = partyRepository.findById(pId).orElseThrow(() -> new NotFoundException(ErrorCode.PARTY_NOT_FOUND));
        if (!post.getHostUser().getUserId().equals(userId)) throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        return post;
    }

    @Transactional
    public void completePartyTrade(Long userId, Long pId) {
        PartyPost post = partyRepository.findById(pId).orElseThrow(() -> new NotFoundException(ErrorCode.PARTY_NOT_FOUND));
        if (!post.getHostUser().getUserId().equals(userId)) throw new UnauthorizedException(ErrorCode.ACCESS_DENIED);
        post.setStatus("COMPLETED"); partyRepository.save(post);
    }

    @Transactional
    public void withdrawUser(Long userId, String password) {
        User user = findUser(userId);
        if (!passwordEncoder.matches(password, user.getPassword())) throw new ValidationException(ErrorCode.PASSWORD_MISMATCH);
        user.setRole("WITHDRAWN"); userRepository.save(user);
    }

    private User findUser(Long userId) { return userRepository.findById(userId).orElseThrow(() -> new NotFoundException(ErrorCode.USER_NOT_FOUND)); }
    private String maskAccountNumber(String acc) { return (acc == null || acc.length() < 4) ? acc : "****" + acc.substring(acc.length() - 4); }
}
