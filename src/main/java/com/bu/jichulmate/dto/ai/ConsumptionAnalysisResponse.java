package com.bu.jichulmate.dto.ai;

import lombok.Data;
import java.util.List;

@Data
public class ConsumptionAnalysisResponse {
    // 멘토가 분석한 핵심 내용 (예: "식비가 지난달보다 20% 늘었어")
    private String analysisResult;
    private String advice;

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