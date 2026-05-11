package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.ai.FeedbackResponse;
import com.bu.jichulmate.service.AiMentorService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/ai")
public class AiMentorController {

    private final AiMentorService aiMentorService;

    // 프론트(JS)에서 보내는 JSON 데이터를 받기 위한 임시 그릇
    @Data
    public static class ChatRequest {
        private String message;
        private String flavor; // "mild", "medium", "spicy"
    }

    @PostMapping("/chat")
    public ResponseEntity<FeedbackResponse> chatWithMentor(@RequestBody ChatRequest request) {
        // 프론트에서 넘어온 맛(flavor)이 없으면 기본 중간맛으로 세팅
        String flavor = request.getFlavor() != null ? request.getFlavor() : "medium";

        // Service에 일 시키기
        FeedbackResponse response = aiMentorService.getChatFeedback(request.getMessage(), flavor);

        return ResponseEntity.ok(response);
    }
}