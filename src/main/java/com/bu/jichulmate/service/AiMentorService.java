package com.bu.jichulmate.service;

import com.bu.jichulmate.dto.ai.FeedbackResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;

@Service
@RequiredArgsConstructor
public class AiMentorService {

    private final RestTemplate restTemplate;

    @Value("${gemini.api.url}")
    private String apiUrl;

    @Value("${gemini.api.key}")
    private String apiKey;

    /**
     * 모달 채팅창에서 AI 멘토에게 질문하고 답변을 받아오는 메서드
     */
    public FeedbackResponse getChatFeedback(String userMessage, String flavor) {

        // 1. 성향(맛)에 따른 프롬프트 세팅
        String systemPrompt = "";
        if ("mild".equals(flavor)) {
            systemPrompt = "지시사항: 너는 세상에서 제일 다정하고 친절한 금융 멘토 '지출메이트'야. 반말을 섞어서 친근하게 말하고, 이모티콘을 많이 사용해. 사용자가 상처받지 않게 따뜻하게 조언해줘.\n\n";
        } else if ("spicy".equals(flavor)) {
            systemPrompt = "지시사항: 너는 차갑고 냉정한 팩트 폭격기야. 돈을 낭비하는 것에 대해 아주 신랄하고 뼈때리는 조언을 해줘. 이모티콘은 절대 쓰지 말고 단호하게 말해.\n\n";
        } else {
            // 기본값 (중간맛)
            systemPrompt = "지시사항: 너는 객관적이고 이성적인 재무 설계사야. 감정적인 공감보다는 분석적이고 논리적인 조언을 해줘.\n\n";
        }

        String finalPrompt = systemPrompt + "사용자 질문: " + userMessage;

        // 2. FeedbackResponse 안에 만들어둔 GeminiRequest 그릇에 데이터 담기
        FeedbackResponse.GeminiRequest.Part part = new FeedbackResponse.GeminiRequest.Part();
        part.setText(finalPrompt);

        FeedbackResponse.GeminiRequest.Content content = new FeedbackResponse.GeminiRequest.Content();
        content.setParts(Collections.singletonList(part));

        FeedbackResponse.GeminiRequest request = new FeedbackResponse.GeminiRequest();
        request.setContents(Collections.singletonList(content));

        // 3. HTTP 통신 세팅
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String requestUrl = apiUrl + "?key=" + apiKey;
        HttpEntity<FeedbackResponse.GeminiRequest> entity = new HttpEntity<>(request, headers);

        // 4. 최종 리턴할 응답 객체 생성
        FeedbackResponse result = new FeedbackResponse();
        result.setFlavor(flavor);

        try {
            // 5. API 호출 및 GeminiResponse 구조로 받기
            FeedbackResponse.GeminiResponse apiResponse = restTemplate.postForObject(requestUrl, entity, FeedbackResponse.GeminiResponse.class);

            if (apiResponse != null && apiResponse.getCandidates() != null && !apiResponse.getCandidates().isEmpty()) {
                String aiText = apiResponse.getCandidates().get(0).getContent().getParts().get(0).getText();
                result.setMentorMessage(aiText);
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