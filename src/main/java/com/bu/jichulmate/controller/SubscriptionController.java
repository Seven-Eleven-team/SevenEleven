package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.subscription.SubscriptionCreateRequest;
import com.bu.jichulmate.service.SubscriptionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;
import com.bu.jichulmate.util.SessionUtils;

@Controller
@RequiredArgsConstructor
@RequestMapping("/subscription")
public class SubscriptionController {

    private final SubscriptionService subscriptionService;

    // OTT 구독 페이지
    @GetMapping("/ott")
    public String ottPage() {
        return "subscription/ott";
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

    // 결제 완료 페이지
    @GetMapping("/paymentSuccess")
    public String paymentSuccess() {
        return "subscription/paymentSuccess";
    }
}