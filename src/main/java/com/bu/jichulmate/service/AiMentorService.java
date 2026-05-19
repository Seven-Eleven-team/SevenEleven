package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.AiChatLog;
import com.bu.jichulmate.dto.ai.FeedbackResponse;
import com.bu.jichulmate.repository.AiChatLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AiMentorService {

    private final RestTemplate restTemplate;
    private final AiChatLogRepository aiChatLogRepository; // ★ 추가

    @Value("${gemini.api.url}")
    private String apiUrl;

    @Value("${gemini.api.key}")
    private String apiKey;

    // ★ 추가: 과거 대화 내역 가져오기 리스트
    public List<AiChatLog> getChatHistory(Long userId) {
        return aiChatLogRepository.findByUserIdOrderByChatDateAsc(userId);
    }

    /**
     * 유저 아이디(userId)를 함께 받아 대화 내역을 DB에 저장하고, 과거 문맥을 기억하게 합니다.
     */
    @Transactional
    public FeedbackResponse getChatFeedback(Long userId, String userMessage, String flavor) {

        // [1] 사용자가 보낸 질문 DB에 먼저 저장
        AiChatLog userLog = AiChatLog.builder()
                .userId(userId)
                .senderType("USER")
                .message(userMessage)
                .build();
        aiChatLogRepository.save(userLog);

        // [2] 시스템 성향 프롬프트 세팅
        String systemPrompt = "";
        if ("mild".equals(flavor)) {
            systemPrompt = "지시사항: 너는 세상에서 제일 다정하고 친절한 금융 멘토 '지출메이트'야. 반말을 섞어서 친근하게 말하고, 이모티콘을 많이 사용해. 사용자가 상처받지 않게 따뜻하게 조언해줘.\n\n";
        } else if ("spicy".equals(flavor)) {
            systemPrompt = "지시사항: 너는 차갑고 냉정한 팩트 폭격기야. 돈을 낭비하는 것에 대해 아주 신랄하고 뼈때리는 조언을 해줘. 이모티콘은 절대 쓰지 말고 단호하게 말해.\n\n";
        } else {
            systemPrompt = "지시사항: 너는 객관적이고 이성적인 재무 설계사야. 감정적인 공감보다는 분석적이고 논리적인 조언을 해줘.\n\n";
        }

        // [3] ★ 시나리오 B의 핵심: DB에서 과거 대화 내역을 최대 6개까지 긁어와 문맥 쌓기
        List<AiChatLog> history = aiChatLogRepository.findByUserIdOrderByChatDateAsc(userId);
        StringBuilder contextBuilder = new StringBuilder();
        contextBuilder.append(systemPrompt).append("이전 대화 기억:\n");

        int startIdx = Math.max(0, history.size() - 7); // 너무 길면 터지므로 최신 6~7개만 문맥 유지
        for (int i = startIdx; i < history.size() - 1; i++) { // 방금 저장한 유저 메시지 직전까지
            AiChatLog log = history.get(i);
            contextBuilder.append(log.getSenderType()).append(": ").append(log.getMessage()).append("\n");
        }
        contextBuilder.append("USER: ").append(userMessage).append("\nAI: ");

        String finalPrompt = contextBuilder.toString();

        // [4] Gemini 요청 그릇 세팅
        FeedbackResponse.GeminiRequest.Part part = new FeedbackResponse.GeminiRequest.Part();
        part.setText(finalPrompt);

        FeedbackResponse.GeminiRequest.Content content = new FeedbackResponse.GeminiRequest.Content();
        content.setParts(Collections.singletonList(part));

        FeedbackResponse.GeminiRequest request = new FeedbackResponse.GeminiRequest();
        request.setContents(Collections.singletonList(content));

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String requestUrl = apiUrl + "?key=" + apiKey;
        HttpEntity<FeedbackResponse.GeminiRequest> entity = new HttpEntity<>(request, headers);

        FeedbackResponse result = new FeedbackResponse();
        result.setFlavor(flavor);

        try {
            FeedbackResponse.GeminiResponse apiResponse = restTemplate.postForObject(requestUrl, entity, FeedbackResponse.GeminiResponse.class);

            if (apiResponse != null && apiResponse.getCandidates() != null && !apiResponse.getCandidates().isEmpty()) {
                String aiText = apiResponse.getCandidates().get(0).getContent().getParts().get(0).getText();
                result.setMentorMessage(aiText);

                // [5] AI가 준 답변 DB에 저장
                AiChatLog aiLog = AiChatLog.builder()
                        .userId(userId)
                        .senderType("AI")
                        .message(aiText)
                        .build();
                aiChatLogRepository.save(aiLog);

            } else {
                result.setMentorMessage("AI 멘토가 잠시 생각에 잠겼어요. 다시 시도해주세요!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.setMentorMessage("앗, 멘토와 연결이 끊어졌어요. 잠시 후 다시 말을 걸어주세요.");
        }

        return result;
    }
}