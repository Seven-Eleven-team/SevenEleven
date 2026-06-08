package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.subscription.SubscriptionCreateRequest;
import com.bu.jichulmate.dto.subscription.SubscriptionResponse;
import com.bu.jichulmate.service.SubscriptionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;
import com.bu.jichulmate.util.SessionUtils;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/subscription")
public class SubscriptionController {

    private final SubscriptionService subscriptionService;

    // =====================================================================
    // 🌟 [추가] 마이페이지 대시보드 메인 화면 연동
    // =====================================================================
    @GetMapping("/mypage")
    public String mypageDashboard(Model model) {
        // 현재 테스트 중이신 사용자 ID 2L 적용
        Long userId = 2L;

        List<SubscriptionResponse> top3Subs;
        try {
            // 서비스에서 대시보드용 최신 3개 데이터 가져오기
            top3Subs = subscriptionService.getTop3Subscriptions(userId);
        } catch (Exception e) {
            e.printStackTrace();
            top3Subs = new ArrayList<>();
        }

        // JSP 파일에서 ${top3Subscriptions} 로 꺼내 쓸 수 있도록 모델에 적재
        model.addAttribute("top3Subscriptions", top3Subs);

        // 마이페이지 메인 JSP 경로 반환
        return "members/mypage/mypage";
    }

    // 구독 구매 페이지
    @GetMapping("/buy")
    public String buyPage() {

        return "subscription/buy";
    }

    // 구독 저장
    @PostMapping("/ott")
    public String create(
            SubscriptionCreateRequest request,
            HttpSession session
    ) {

        Long userId =
                SessionUtils.getLoginUserId(session);

        subscriptionService.createSubscription(
                userId,
                request
        );

        return "subscription/paymentSuccess";
    }
    //마이페이지 내 구독관리
    @GetMapping("/my")
    public String mySubscriptions(Model model) {
        Long userId = 2L;

        List<SubscriptionResponse> subs;
        try {
            subs = subscriptionService.getMySubscriptions(userId);
        } catch (Exception e) {
            e.printStackTrace();
            subs = new ArrayList<>();
        }

        System.out.println("=== 구독 수: " + subs.size());
        System.out.println("=== 타입: " + subs.getClass().getName());

        model.addAttribute("subscriptions", subs);
        return "members/mypage/mysub";
    }
    //마이페이지 내 구독관리 취소
    @PostMapping("/cancel/{id}")
    public String cancel(@PathVariable Long id) {
        subscriptionService.cancelSubscription(id);
        return "redirect:/subscription/my";
    }

    // 결제 완료 페이지
    @GetMapping("/paymentSuccess")
    public String paymentSuccess() {
        return "subscription/paymentSuccess";
    }
}