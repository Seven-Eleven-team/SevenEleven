package com.bu.jichulmate.dto.mypage;

import lombok.*;
import java.time.LocalDate;
import java.util.List;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class MyPageSummaryResponse {

    private Long userId;
    private String loginId;
    private String nickname;
    private String email;
    private String gender;
    private LocalDate birthDate;        // 생년월일 (이미지1)
    private String profileImage;
    private String role;
    private boolean sellerRegistered;
    private boolean emailNotify;

    // 구독 요약
    private int activeSubscriptionCount;
    private long monthlySubscriptionTotal;
    private String nextBillingDate;

    // 내 절약 목표 (최대 3개)
    private List<GoalSummary> goals;

    // 대표 계좌
    private String primaryBankName;
    private String primaryAccountNumber;

    // ── inner class: 절약 목표 요약 ──────────────────────────
    @Getter @Setter
    @NoArgsConstructor @AllArgsConstructor
    @Builder
    public static class GoalSummary {
        private Long goalId;
        private String goalName;
        private long targetAmount;
        private long savedAmount;
        private int achievementRate;
    }

    // ── inner class: 구독 상세 (이미지2 - 파일 추가 없이 해결) ─
    @Getter @Setter
    @NoArgsConstructor @AllArgsConstructor
    @Builder
    public static class SubscriptionDetail {
        private Long subscriptionId;
        private String serviceName;
        private String serviceLogo;
        private String orderCode;           // 주문 코드
        private long monthlyFee;
        private String status;              // ACTIVE / CANCELLED

        // 이미지2 왼쪽 - 계정 충전 정보
        private String chargeTimeline;      // 계정 충전 타임라인
        private String chargeDateTime;      // 대리 충전 일시

        // 이미지2 오른쪽 - 계정 상태
        private String accountStatus;       // 계정 상태 설명
        private String paymentMethod;       // 결제 방식
        private int remainingDays;          // 남은 기간
        private String ottUserId;           // 사용자 이름

        private LocalDate startDate;
        private LocalDate nextBillingDate;
    }
}