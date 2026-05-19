package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.AiChatLog;
import com.bu.jichulmate.dto.ai.FeedbackResponse;
import com.bu.jichulmate.service.AiMentorService;
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
        private Long userId; // ★ 추가: 유저 구분용 식별자
        private String message;
        private String flavor;
    }

    // 1. 실시간 채팅 및 저장
    @PostMapping("/chat")
    public ResponseEntity<FeedbackResponse> chatWithMentor(@RequestBody ChatRequest request) {
        String flavor = request.getFlavor() != null ? request.getFlavor() : "medium";

        // Service 단에 userId를 함께 넘겨서 DB 작업 진행
        FeedbackResponse response = aiMentorService.getChatFeedback(request.getUserId(), request.getMessage(), flavor);
        return ResponseEntity.ok(response);
    }

    // 2. ★ 추가: 모달창이 켜질 때 예전 대화 기록 싹 긁어오는 API
    @GetMapping("/history/{userId}")
    public ResponseEntity<List<AiChatLog>> getHistory(@PathVariable("userId") Long userId) {
        List<AiChatLog> history = aiMentorService.getChatHistory(userId);
        return ResponseEntity.ok(history);
    }
}