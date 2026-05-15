package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.subscription.SubscriptionCreateRequest;
import com.bu.jichulmate.service.SubscriptionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/subscription")
public class SubscriptionController {

    private final SubscriptionService subscriptionService;

    // 구독 구매 페이지
    @GetMapping("/buy")
    public String buyPage() {

        return "subscription/buy";
    }

    // 구독 저장
    @PostMapping("/buy")
    public String create(SubscriptionCreateRequest request) {

        // TODO : 로그인 연동 후 실제 사용자 ID 적용
        Long userId = 1L;

        subscriptionService.createSubscription(userId, request);

        return "subscription/success";
    }
}