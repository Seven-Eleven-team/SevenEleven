package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.domain.AiChatLog;
import com.bu.jichulmate.domain.Category;
import com.bu.jichulmate.domain.Expense;
import com.bu.jichulmate.domain.SavingGoal;
import com.bu.jichulmate.repository.UserRepository;
import com.bu.jichulmate.repository.AiChatLogRepository;
import com.bu.jichulmate.repository.ExpenseRepository;
import com.bu.jichulmate.repository.CategoryRepository;
import com.bu.jichulmate.repository.GoalRepository;
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

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;
import java.util.stream.Collectors;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
public class AiMentorService {

    private final RestTemplate restTemplate;
    private final UserRepository userRepository;
    private final AiChatLogRepository aiChatLogRepository;
    private final ExpenseRepository expenseRepository;
    private final CategoryRepository categoryRepository;
    private final GoalRepository goalRepository;



    @Value("${gemini.api.url}")
    private String apiUrl;

    @Value("${gemini.api.key}")
    private String apiKey;

    private static final String PROMPT_MILD = "지시사항: 너는 세상에서 제일 다정하고 친절한 금융 멘토 '지출메이트'야. 반말을 섞어서 친근하게 말하고, 이모티콘을 많이 사용해. 사용자가 상처받지 않게 따뜻하게 조언해줘. 단, 텍스트를 강조하기 위한 마크다운 기호(***, **, ###, ---, * 등)는 절대 사용하지 말고 오직 순수 텍스트로만 답변해줘.\n\n";
    private static final String PROMPT_MEDIUM = "지시사항: 너는 객관적이고 이성적인 재무 설계사야. 감정적인 공감보다는 분석적이고 논리적인 조언을 담백하게 제공해줘. 단, 텍스트를 강조하기 위한 마크다운 기호(***, **, ###, ---, * 등)는 절대 사용하지 말고 오직 순수 텍스트로만 답변해줘.\n\n";
    private static final String PROMPT_HOT = "지시사항: 너는 차갑고 냉정한 팩트 폭격기야. 돈을 낭비하는 것에 대해 아주 신랄하고 뼈때리는 직설적인 경고형 문체로 조언해줘. 이모티콘은 절대 쓰지 말고 단호하게 말해. 단, 텍스트를 강조하기 위한 마크다운 기호(***, **, ###, ---, * 등)는 절대 사용하지 말고 오직 순수 텍스트로만 답변해줘.\n\n";

    // ★ 은아님 기획 반영: 지출, 저축, 목표 설정을 아우르는 마법의 지시사항!
    private static final String AI_ACTION_INSTRUCTION =
            "\n\n[중요 지시사항: AI 비서 자동 기록 명령]\n" +
                    "사용자의 대화를 분석해서, 가계부에 기록하거나 목표를 세워야 하는 내용이 있다면 반드시 대답 맨 마지막에 아래 태그를 붙여줘. (해당 없으면 생략)\n" +
                    "1. 일반 지출 입력: ||SAVE_EXPENSE:카테고리번호:금액||\n" +
                    "   - 카테고리번호: 1(주거비), 2(식비), 3(교통비), 4(통신비), 5(보험료), 6(교육비), 7(의료비), 8(오락/문화), 9(의류/미용), 10(기타)\n" +
                    "2. 저축 입력: ||SAVE_SAVING:목표ID:금액||\n" +
                    "   - 목표ID는 내가 아래 제공할 [현재 목표 달성 진행률] 목록에 적힌 (ID:숫자)를 보고 알맞은 목표의 ID를 넣어줘.\n" +
                    "3. 새 목표 설정: ||SAVE_GOAL:목표이름:목표금액:고정여부||\n" +
                    "   - 고정여부는 Y(고정 저축) 또는 N(일반 저축)으로 적어. (예: ||SAVE_GOAL:유럽여행:3000000:N||)\n";

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

        String systemPrompt = "MILD".equals(tone) ? PROMPT_MILD : ("HOT".equals(tone) ? PROMPT_HOT : PROMPT_MEDIUM);

        // ==========================================================
        // 대시보드 상태 수집 로직
        // ==========================================================
        YearMonth thisMonth = YearMonth.now();
        YearMonth lastMonth = thisMonth.minusMonths(1);

        List<Expense> thisMonthExpenses = expenseRepository.findMonthlyExpenses(userId, thisMonth.atDay(1), thisMonth.atEndOfMonth());
        List<Expense> lastMonthExpenses = expenseRepository.findMonthlyExpenses(userId, lastMonth.atDay(1), lastMonth.atEndOfMonth());

        long thisTotal = 0, fixedTotal = 0, variableTotal = 0, savingsTotal = 0;
        Map<String, Long> categoryMap = new HashMap<>();

        for (Expense e : thisMonthExpenses) {
            String catName = e.getCategory().getName();
            if ("저축".equals(catName)) {
                savingsTotal += e.getAmount();
            } else {
                thisTotal += e.getAmount();
                if ("Y".equals(e.getIsFixed())) fixedTotal += e.getAmount();
                else variableTotal += e.getAmount();
                categoryMap.put(catName, categoryMap.getOrDefault(catName, 0L) + e.getAmount());
            }
        }

        long lastTotal = lastMonthExpenses.stream()
                .filter(e -> !"저축".equals(e.getCategory().getName()))
                .mapToLong(Expense::getAmount).sum();

        List<SavingGoal> goalList = goalRepository.findByUserUserId(userId);
        List<Object[]> savingDataRaw = expenseRepository.getMonthlySavingsGroupedByGoal(userId);
        Map<Long, Long> goalCurrentTotals = new HashMap<>();
        for (Object[] row : savingDataRaw) {
            Long gId = ((Number) row[0]).longValue();
            Long amt = ((Number) row[2]).longValue();
            goalCurrentTotals.put(gId, goalCurrentTotals.getOrDefault(gId, 0L) + amt);
        }

        StringBuilder expenseContext = new StringBuilder();
        expenseContext.append("\n### [유저의 현재 대시보드 재무 상태 요약 (").append(thisMonth).append(" 기준)]\n");
        expenseContext.append("- 이번 달 총 지출: ").append(String.format("%,d", thisTotal)).append("원 (지난달 총 지출: ").append(String.format("%,d", lastTotal)).append("원)\n");
        expenseContext.append("- 지출 구성: 고정 지출 ").append(String.format("%,d", fixedTotal)).append("원 / 변동 지출 ").append(String.format("%,d", variableTotal)).append("원\n");
        expenseContext.append("- 이번 달 총 저축액: ").append(String.format("%,d", savingsTotal)).append("원\n");

        expenseContext.append("\n[이번 달 카테고리별 지출 상세]\n");
        if (categoryMap.isEmpty()) expenseContext.append("- 기록 없음\n");
        else categoryMap.entrySet().stream().sorted(Map.Entry.<String, Long>comparingByValue().reversed())
                .forEach(entry -> expenseContext.append("- ").append(entry.getKey()).append(": ").append(String.format("%,d", entry.getValue())).append("원\n"));

        expenseContext.append("\n[현재 목표 달성 진행률]\n");
        if (goalList.isEmpty()) {
            expenseContext.append("- 현재 설정된 재무 목표가 없어.\n");
        } else {
            for (SavingGoal g : goalList) {
                long currentSaved = goalCurrentTotals.getOrDefault(g.getId(), 0L);
                long target = g.getTargetAmount(); // 에러 잡았던 부분!
                double percent = target > 0 ? ((double) currentSaved / target) * 100 : 0;
                // ★ AI가 알 수 있도록 ID를 명시적으로 알려줍니다!
                expenseContext.append("- (ID:").append(g.getId()).append(") [")
                        .append(g.getIsFixed().equals("Y") ? "고정목표" : "일반목표").append("] ")
                        .append(g.getGoalName()).append(": ")
                        .append(String.format("%,d", currentSaved)).append("원 / ").append(String.format("%,d", target)).append("원 (달성률: ")
                        .append(String.format("%.1f", percent)).append("%)\n");
            }
        }

        systemPrompt = systemPrompt + expenseContext.toString() + AI_ACTION_INSTRUCTION;

        // API 요청 세팅
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
                boolean isActionTaken = false;

                // ==========================================================
                // ★ 1. 일반 지출 저장 파싱 로직
                // ==========================================================
                Matcher expenseMatcher = Pattern.compile("\\|\\|SAVE_EXPENSE:(\\d+):(\\d+)\\|\\|").matcher(aiText);
                while (expenseMatcher.find()) {
                    try {
                        Long categoryId = Long.parseLong(expenseMatcher.group(1));
                        Long amount = Long.parseLong(expenseMatcher.group(2));
                        Category category = categoryRepository.findById(categoryId).orElse(null);

                        if (category != null) {
                            Expense newExpense = Expense.builder()
                                    .userId(userId)
                                    .category(category)
                                    .amount(amount)
                                    .expenseDate(LocalDate.now())
                                    .isFixed("N")
                                    .build();
                            expenseRepository.save(newExpense);
                            isActionTaken = true;
                        }
                    } catch (Exception e) {}
                }
                aiText = expenseMatcher.replaceAll("");

                // ==========================================================
                // ★ 2. 저축 저장 파싱 로직 (은아님 기획!)
                // ==========================================================
                Matcher savingMatcher = Pattern.compile("\\|\\|SAVE_SAVING:(\\d+):(\\d+)\\|\\|").matcher(aiText);
                while (savingMatcher.find()) {
                    try {
                        Long goalId = Long.parseLong(savingMatcher.group(1));
                        Long amount = Long.parseLong(savingMatcher.group(2));
                        Category savingCategory = categoryRepository.findById(11L).orElse(null); // 11번이 저축 카테고리
                        SavingGoal linkedGoal = goalRepository.findById(goalId).orElse(null);

                        if (savingCategory != null && linkedGoal != null) {
                            Expense newSaving = Expense.builder()
                                    .userId(userId)
                                    .category(savingCategory)
                                    .savingGoal(linkedGoal)
                                    .amount(amount)
                                    .expenseDate(LocalDate.now())
                                    .isFixed(linkedGoal.getIsFixed())
                                    .build();
                            expenseRepository.save(newSaving);
                            isActionTaken = true;
                        }
                    } catch (Exception e) {}
                }
                aiText = savingMatcher.replaceAll("");

                // ==========================================================
                // ★ 3. 새 목표 설정 파싱 로직 (은아님 기획!)
                // ==========================================================
                Matcher goalMatcher = Pattern.compile("\\|\\|SAVE_GOAL:([^:]+):(\\d+):([YN])\\|\\|").matcher(aiText);
                while (goalMatcher.find()) {
                    try {
                        String goalName = goalMatcher.group(1).trim();
                        Long targetAmt = Long.parseLong(goalMatcher.group(2));
                        String isFixed = goalMatcher.group(3);

                        SavingGoal newGoal = SavingGoal.builder()
                                .user(user)
                                .goalName(goalName)
                                .targetAmount(targetAmt)
                                .isFixed(isFixed)
                                .build();
                        goalRepository.save(newGoal);
                        isActionTaken = true;
                    } catch (Exception e) {}
                }
                aiText = goalMatcher.replaceAll("").trim();

                // 액션이 성공했다면 유저에게 알려주는 추임새
                if (isActionTaken) {
                    aiText += "\n\n*(방금 말해준 내용은 내가 시스템에 완벽하게 등록해뒀어! 대시보드를 새로고침 해봐 📝)*";
                }

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