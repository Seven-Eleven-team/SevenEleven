package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.domain.AiChatLog;
import com.bu.jichulmate.domain.Category;
import com.bu.jichulmate.domain.Expense;
import com.bu.jichulmate.repository.UserRepository;
import com.bu.jichulmate.repository.AiChatLogRepository;
import com.bu.jichulmate.repository.ExpenseRepository;
import com.bu.jichulmate.repository.CategoryRepository; // ★ Category 조회를 위해 추가됨
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

import java.time.LocalDate; // ★ 오늘 날짜 저장용
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.regex.Matcher; // ★ 정규식 파싱(태그 추출)용
import java.util.regex.Pattern; // ★ 정규식 파싱(태그 추출)용

@Service
@RequiredArgsConstructor
public class AiMentorService {

    private final RestTemplate restTemplate;
    private final UserRepository userRepository;
    private final AiChatLogRepository aiChatLogRepository;
    private final ExpenseRepository expenseRepository;
    private final CategoryRepository categoryRepository; // ★ 의존성 주입

    @Value("${gemini.api.url}")
    private String apiUrl;

    @Value("${gemini.api.key}")
    private String apiKey;

    private static final String PROMPT_MILD = "지시사항: 너는 세상에서 제일 다정하고 친절한 금융 멘토 '지출메이트'야. 반말을 섞어서 친근하게 말하고, 이모티콘을 많이 사용해. 사용자가 상처받지 않게 따뜻하게 조언해줘.\n\n";
    private static final String PROMPT_MEDIUM = "지시사항: 너는 객관적이고 이성적인 재무 설계사야. 감정적인 공감보다는 분석적이고 논리적인 조언을 담백하게 제공해줘.\n\n";
    private static final String PROMPT_HOT = "지시사항: 너는 차갑고 냉정한 팩트 폭격기야. 돈을 낭비하는 것에 대해 아주 신랄하고 뼈때리는 직설적인 경고형 문체로 조언해줘. 이모티콘은 절대 쓰지 말고 단호하게 말해.\n\n";

    // ★ 핵심 지시사항: AI에게 암호 태그를 뱉으라고 강력하게 명령합니다!
    private static final String EXPENSE_SAVE_INSTRUCTION =
            "\n\n[중요 지시사항: 지출 자동 기록]\n" +
                    "사용자가 새로운 지출 내역(예: '오늘 떡볶이 5000원 먹었어', '택시비 7000원 썼어')을 말하면, 반드시 응답 메시지 맨 마지막에 아래와 같은 특수 태그를 덧붙여줘. 지출 내역을 말하지 않았으면 절대 쓰지 마.\n" +
                    "태그 형식: ||SAVE_EXPENSE:카테고리번호:금액||\n" +
                    "카테고리 번호: 1(주거비), 2(식비), 3(교통비), 4(통신비), 5(보험료), 6(교육비), 7(의료비), 8(오락/문화), 9(의류/미용), 10(기타)\n" +
                    "만약 지출이 여러 건이면 여러 개를 작성해. 예시: ||SAVE_EXPENSE:2:5000|| ||SAVE_EXPENSE:3:7000||";

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

        String currentYearMonth = YearMonth.now().toString();
        List<Object[]> monthlyStats = expenseRepository.getMonthlyCategoryStats(userId, currentYearMonth);

        StringBuilder expenseContext = new StringBuilder();
        expenseContext.append("### 참고 데이터: 현재 질문하는 사용자의 이번 달(").append(currentYearMonth).append(") 실제 지출 내역\n");

        long totalSum = 0;
        if (monthlyStats == null || monthlyStats.isEmpty()) {
            expenseContext.append("현재 지출 내역이 하나도 없어.\n");
        } else {
            for (Object[] stat : monthlyStats) {
                String categoryName = (String) stat[0];
                Number amount = (Number) stat[1];

                if (amount != null && amount.longValue() > 0) {
                    expenseContext.append("- ").append(categoryName).append(": ").append(String.format("%,d", amount.longValue())).append("원\n");
                    totalSum += amount.longValue();
                }
            }
            expenseContext.append("▶ 총 지출 합계: ").append(String.format("%,d", totalSum)).append("원\n");
        }
        expenseContext.append("이 실제 지출 데이터를 기반으로 분석해서 대답해줘.\n");

        // ★ 기존 프롬프트 + 지출 통계 + 태그 생성 지시사항 병합
        systemPrompt = systemPrompt + expenseContext.toString() + EXPENSE_SAVE_INSTRUCTION;

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

        FeedbackResponse.GeminiRequest.Part currentPart = new FeedbackResponse.GeminiRequest.Part();
        currentPart.setText(systemPrompt + "\n사용자 현재 질문: " + userMessage);

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

                // ==========================================================
                // ★ AI가 뱉어낸 태그를 찾아 DB에 저장하는 마법의 파싱 로직
                // ==========================================================
                Pattern pattern = Pattern.compile("\\|\\|SAVE_EXPENSE:(\\d+):(\\d+)\\|\\|");
                Matcher matcher = pattern.matcher(aiText);

                boolean isSaved = false;
                while (matcher.find()) {
                    try {
                        Long categoryId = Long.parseLong(matcher.group(1));
                        Long amount = Long.parseLong(matcher.group(2));

                        Category category = categoryRepository.findById(categoryId).orElse(null);
                        if (category != null) {
                            // 은아님이 만든 Expense 엔티티의 @Builder 사용 (완벽하게 일치함)
                            Expense newExpense = Expense.builder()
                                    .userId(userId)
                                    .category(category)
                                    .amount(amount)
                                    .expenseDate(LocalDate.now()) // 오늘 날짜로 저장
                                    .isFixed("N") // 기본값 변동지출
                                    .build();

                            expenseRepository.save(newExpense);
                            isSaved = true;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                // 화면에 보여줄 땐 보기 싫은 ||SAVE_EXPENSE...|| 태그를 싹 지워버립니다.
                aiText = matcher.replaceAll("").trim();

                // 만약 지출이 성공적으로 DB에 저장되었다면, AI 멘트에 귀여운 추임새 추가!
                if (isSaved) {
                    aiText += "\n\n*(방금 말해준 지출 내역은 내가 가계부에 쏙! 기록해뒀어 📝)*";
                }
                // ==========================================================

                result.setMentorMessage(aiText);

                // DB에 기록되는 AI 로그에도 태그가 제거된 깔끔한 텍스트만 저장
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