package com.bu.jichulmate.dto.ai;

import lombok.Data;
import java.util.List;

@Data
public class FeedbackResponse {
    private String mentorMessage; // AI의 답변 메시지
    private String flavor;        // 선택된 멘토 성향 (mild, medium, spicy)

    // ==========================================
    // ★ Gemini API 통신을 위한 내부 구조 (이너 클래스)
    // ==========================================
    @Data
    public static class GeminiRequest {
        private List<Content> contents;

        @Data
        public static class Content {
            private List<Part> parts;
        }

        @Data
        public static class Part {
            private String text;
        }
    }

    @Data
    public static class GeminiResponse {
        private List<Candidate> candidates;

        @Data
        public static class Candidate {
            private Content content;
        }

        @Data
        public static class Content {
            private List<Part> parts;
        }

        @Data
        public static class Part {
            private String text;
        }
    }
}