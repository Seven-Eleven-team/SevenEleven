package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.domain.AiChatLog;
import com.bu.jichulmate.repository.UserRepository;
import com.bu.jichulmate.repository.AiChatLogRepository;
import com.bu.jichulmate.repository.ExpenseRepository; // ★ DB 통계 조회를 위한 레포지토리 추가
import com.bu.jichulmate.dto.ai.FeedbackResponse;
import com.bu.jichulmate.dto.ai.AiChatHistoryResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.time.YearMonth; // ★ 이번 달 계산을 위한 클래스
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AiMentorService {

    private final RestTemplate restTemplate;
    private final UserRepository userRepository;
    private final AiChatLogRepository aiChatLogRepository;
    private final ExpenseRepository expenseRepository; // ★ 신규 주입 (지출 내역 확인용)

    @Value("${gemini.api.url}")
    private String apiUrl;

    @Value("${gemini.api.key}")
    private String apiKey;

    private static final String PROMPT_MILD = "지시사항: 너는 세상에서 제일 다정하고 친절한 금융 멘토 '지출메이트'야. 반말을 섞어서 친근하게 말하고, 이모티콘을 많이 사용해. 사용자가 상처받지 않게 따뜻하게 조언해줘.\n\n";
    private static final String PROMPT_MEDIUM = "지시사항: 너는 객관적이고 이성적인 재무 설계사야. 감정적인 공감보다는 분석적이고 논리적인 조언을 담백하게 제공해줘.\n\n";
    private static final String PROMPT_HOT = "지시사항: 너는 차갑고 냉정한 팩트 폭격기야. 돈을 낭비하는 것에 대해 아주 신랄하고 뼈때리는 직설적인 경고형 문체로 조언해줘. 이모티콘은 절대 쓰지 말고 단호하게 말해.\n\n";

    @Transactional
    public FeedbackResponse getChatFeedback(Long userId, String userMessage) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 유저입니다."));

        String tone = user.getMentorTone() != null ? user.getMentorTone().toUpperCase() : "MILD";

        AiChatLog userLog = AiChatLog.builder()
                .user(user)
                .senderType("USER")
                .message(userMessage)
                .build();
        aiChatLogRepository.save(userLog);

        String systemPrompt;
        if ("MILD".equals(tone)) {
            systemPrompt = PROMPT_MILD;
        } else if ("HOT".equals(tone)) {
            systemPrompt = PROMPT_HOT;
        } else {
            systemPrompt = PROMPT_MEDIUM;
        }

        // =========================================================================
        // ★ 핵심 로직 추가: DB에서 이번 달 지출 내역을 가져와서 AI에게 알려줄 문자열 생성
        // =========================================================================
        String currentYearMonth = YearMonth.now().toString(); // 예: "2026-05"
        List<Object[]> monthlyStats = expenseRepository.getMonthlyCategoryStats(userId, currentYearMonth);

        StringBuilder expenseContext = new StringBuilder();
        expenseContext.append("### 참고 데이터: 현재 질문하는 사용자의 이번 달(").append(currentYearMonth).append(") 실제 지출 내역\n");

        long totalSum = 0;
        if (monthlyStats == null || monthlyStats.isEmpty()) {
            expenseContext.append("현재 지출 내역이 하나도 없어.\n");
        } else {
            for (Object[] stat : monthlyStats) {
                String categoryName = (String) stat[0];
                Number amount = (Number) stat[1]; // 오라클 DB SUM 결과는 Number 계열로 반환됨

                if (amount != null && amount.longValue() > 0) {
                    expenseContext.append("- ").append(categoryName).append(": ").append(String.format("%,d", amount.longValue())).append("원\n");
                    totalSum += amount.longValue();
                }
            }
            expenseContext.append("▶ 총 지출 합계: ").append(String.format("%,d", totalSum)).append("원\n");
        }
        expenseContext.append("이 실제 지출 데이터를 기반으로 분석해서 대답해줘. 만약 지출 내역이 없다면 지출을 등록해달라고 안내해.\n\n");

        // 기존 시스템 프롬프트에 방금 만든 지출 내역 데이터(expenseContext)를 이어붙임
        systemPrompt = systemPrompt + expenseContext.toString();
        // =========================================================================

        List<FeedbackResponse.GeminiRequest.Content> contentsList = new ArrayList<>();

        Pageable pageLimit = PageRequest.of(0, 10);
        List<AiChatLog> rawHistory = aiChatLogRepository.findByUser_UserIdOrderByChatDateDesc(userId, pageLimit);

        List<AiChatLog> orderedHistory = new ArrayList<>(rawHistory);
        Collections.reverse(orderedHistory);

        for (AiChatLog log : orderedHistory) {
            FeedbackResponse.GeminiRequest.Part part = new FeedbackResponse.GeminiRequest.Part();
            part.setText(log.getMessage());

            FeedbackResponse.GeminiRequest.Content content = new FeedbackResponse.GeminiRequest.Content();
            content.setRole("USER".equals(log.getSenderType()) ? "user" : "model");
            content.setParts(Collections.singletonList(part));

            contentsList.add(content);
        }

        // 마지막 Content에 지출 내역이 합쳐진 최강의 시스템 프롬프트 + 유저 질문 세팅
        FeedbackResponse.GeminiRequest.Part currentPart = new FeedbackResponse.GeminiRequest.Part();
        currentPart.setText(systemPrompt + "사용자 현재 질문: " + userMessage);

        FeedbackResponse.GeminiRequest.Content currentContent = new FeedbackResponse.GeminiRequest.Content();
        currentContent.setRole("user");
        currentContent.setParts(Collections.singletonList(currentPart));
        contentsList.add(currentContent);

        FeedbackResponse.GeminiRequest request = new FeedbackResponse.GeminiRequest();
        request.setContents(contentsList);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String requestUrl = apiUrl + "?key=" + apiKey;
        HttpEntity<FeedbackResponse.GeminiRequest> entity = new HttpEntity<>(request, headers);

        FeedbackResponse result = new FeedbackResponse();
        result.setFlavor(tone.toLowerCase());

        try {
            FeedbackResponse.GeminiResponse apiResponse = restTemplate.postForObject(requestUrl, entity, FeedbackResponse.GeminiResponse.class);

            if (apiResponse != null && apiResponse.getCandidates() != null && !apiResponse.getCandidates().isEmpty()) {
                String aiText = apiResponse.getCandidates().get(0).getContent().getParts().get(0).getText();
                result.setMentorMessage(aiText);

                AiChatLog mentorLog = AiChatLog.builder()
                        .user(user)
                        .senderType("MENTOR")
                        .message(aiText)
                        .build();
                aiChatLogRepository.save(mentorLog);

            } else {
                result.setMentorMessage("AI 멘토가 잠시 생각에 잠겼어요. 다시 시도해주세요!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.setMentorMessage("앗, 멘토와 연결이 끊어졌어요. 잠시 후 다시 말을 걸어주세요.");
        }

        return result;
    }

    @Transactional(readOnly = true)
    public List<AiChatHistoryResponse> getChatHistory(Long userId) {
        return aiChatLogRepository.findByUser_UserIdOrderByChatDateAsc(userId).stream()
                .map(AiChatHistoryResponse::fromEntity)
                .collect(Collectors.toList());
    }
}