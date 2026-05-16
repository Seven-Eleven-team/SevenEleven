package com.bu.jichulmate.dto.mypage;

import lombok.*;
import java.time.LocalDate;
import java.util.List;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class MyPageSummaryResponse {
    private Long userId;
    private String loginId; // ★ 이메일 형식의 로그인 아이디
    private String nickname;
    private String gender;
    private LocalDate birthDate;
    private String profileImage;
    private String role;
    private boolean sellerRegistered;
    private boolean emailNotify;
    private int activeSubscriptionCount;
    private int unreadNotificationCount;
    private long monthlySubscriptionTotal;
    private String nextBillingDate;
    private List<GoalSummary> goals;
    private String primaryBankName;
    private String primaryAccountNumber;

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
    public static class GoalSummary {
        private Long goalId;
        private String goalName;
        private long targetAmount;
        private long savedAmount;
        private int achievementRate;
    }

    @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
    public static class SubscriptionDetail {
        private Long subscriptionId;
        private String serviceName;
        private String serviceLogo;
        private String orderCode;
        private long monthlyFee;
        private String status;
        private String chargeTimeline;
        private String chargeDateTime;
        private String accountStatus;
        private String paymentMethod;
        private int remainingDays;
        private String ottUserId;
        private LocalDate startDate;
        private LocalDate nextBillingDate;
    }
}