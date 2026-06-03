package com.bu.jichulmate.dto.ai;

import lombok.Data;
import java.util.List;

@Data
public class FeedbackResponse {

    private String mentorMessage;
    private String flavor;

    // Gemini API 요청 구조 그릇
    @Data
    public static class GeminiRequest {
        private List<Content> contents;

        @Data
        public static class Content {
            private String role; // ★ 대화 주체(user / model) 식별을 위해 신규 추가!
            private List<Part> parts;
        }

        @Data
        public static class Part {
            private String text;
        }
    }

    // Gemini API 응답 구조 그릇
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