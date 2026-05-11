package com.bu.jichulmate.dto.ai;

import lombok.Data;
import java.util.List;

@Data
public class OpportunityCostResponse {
    private String savedItem;     // 대신 살 수 있었던 물건
    private Long potentialSavings; // 아낄 수 있었던 총액

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