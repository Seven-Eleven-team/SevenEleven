package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.ai.FeedbackResponse;
import com.bu.jichulmate.dto.ai.AiChatHistoryResponse;
import com.bu.jichulmate.service.AiMentorService;
import com.bu.jichulmate.util.SessionUtils; // ★ 팀 표준 세션 유틸리티 import 추가!
import jakarta.servlet.http.HttpSession;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/ai")
public class AiMentorController {

    private final AiMentorService aiMentorService;

    @Data
    public static class ChatRequest {
        private String message;
    }

    /**
     * AI 금융 멘토와 대화를 나누고 답변을 받는 API
     * POST /api/v1/ai/chat
     */
    @PostMapping("/chat")
    public ResponseEntity<FeedbackResponse> chatWithMentor(
            @RequestBody ChatRequest request,
            HttpSession session) {

        // ★ 수정됨: 엉뚱한 "userId" 대신, 팀 표준 SessionUtils를 사용해 안전하게 ID 추출!
        Long userId = SessionUtils.getLoginUserId(session);

        // 멘토 서비스에 유저 ID와 메시지를 전달하여 대화 처리
        FeedbackResponse response = aiMentorService.getChatFeedback(userId, request.getMessage());

        return ResponseEntity.ok(response);
    }

    /**
     * 과거 채팅 이력을 순서대로 조회하는 API
     * GET /api/v1/ai/history
     */
    @GetMapping("/history")
    public ResponseEntity<List<AiChatHistoryResponse>> getChatHistory(HttpSession session) {

        // ★ 수정됨: 팀 표준 SessionUtils 사용
        Long userId = SessionUtils.getLoginUserId(session);

        // 서비스로부터 대화 내역 List 획득
        List<AiChatHistoryResponse> history = aiMentorService.getChatHistory(userId);

        return ResponseEntity.ok(history);
    }
}