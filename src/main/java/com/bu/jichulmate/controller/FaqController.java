package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.support.FaqRequest;
import com.bu.jichulmate.dto.support.FaqResponse;
import com.bu.jichulmate.service.FaqService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/support")
public class FaqController {

    private final FaqService faqService;

    public FaqController(FaqService faqService) {
        this.faqService = faqService;
    }

    @GetMapping("/faq")
    public String faqPage() {
        return "support/faq";
    }

    // FAQ 전체 조회
    @ResponseBody
    @GetMapping("/api/faqs")
    public List<FaqResponse> getFaqs() {
        return faqService.getFaqList();
    }

    // 카테고리별 FAQ 조회
    @ResponseBody
    @GetMapping("/api/faqs/category")
    public List<FaqResponse> getFaqsByCategory(@RequestParam String category) {
        return faqService.getFaqListByCategory(category);
    }

    // 관리자 전체 FAQ 조회
    @ResponseBody
    @GetMapping("/api/admin/faqs")
    public List<FaqResponse> getAllFaqs() {
        return faqService.getAllFaqList();
    }

    // FAQ 등록
    @ResponseBody
    @PostMapping("/api/admin/faqs")
    public ResponseEntity<FaqResponse> createFaq(@RequestBody FaqRequest request) {
        return ResponseEntity.ok(faqService.createFaq(request));
    }

    // FAQ 수정
    @ResponseBody
    @PutMapping("/api/admin/faqs/{faqId}")
    public ResponseEntity<FaqResponse> updateFaq(
            @PathVariable Long faqId,
            @RequestBody FaqRequest request
    ) {
        return ResponseEntity.ok(faqService.updateFaq(faqId, request));
    }

    // FAQ 삭제
    @ResponseBody
    @DeleteMapping("/api/admin/faqs/{faqId}")
    public ResponseEntity<Void> deleteFaq(@PathVariable Long faqId) {
        faqService.deleteFaq(faqId);
        return ResponseEntity.ok().build();
    }

    // 채팅형 FAQ 조회
    @ResponseBody
    @GetMapping("/api/faqs/chat")
    public ResponseEntity<?> getFaqByChat(@RequestParam String input) {

        String trimmed = input.trim();

        if (!trimmed.matches("\\d+")) {
            return ResponseEntity.badRequest()
                    .body("숫자만 입력해주세요.");
        }

        int index = Integer.parseInt(trimmed);
        FaqResponse response = faqService.getFaqByIndex(index);

        if (response == null) {
            return ResponseEntity.badRequest()
                    .body("해당 번호의 FAQ가 없습니다.");
        }

        return ResponseEntity.ok(response);
    }

    // 안내 메시지 조회
    @ResponseBody
    @GetMapping("/api/faqs/guide")
    public ResponseEntity<String> getGuideMessage() {
        return ResponseEntity.ok("추가로 궁금한 내용이 있으시면 번호를 입력해주세요.");
    }

    // 질문만 전체 조회
    @ResponseBody
    @GetMapping("/api/faqs/questions")
    public List<String> getFaqQuestionsOnly() {
        return faqService.getFaqList()
                .stream()
                .map(FaqResponse::getQuestion)
                .toList();
    }

    // 질문만 번호별 조회
    @ResponseBody
    @GetMapping("/api/faqs/questions/{index}")
    public ResponseEntity<?> getFaqQuestionOnly(@PathVariable int index) {

        FaqResponse faq = faqService.getFaqByIndex(index);

        if (faq == null) {
            return ResponseEntity.badRequest()
                    .body("해당 번호의 FAQ가 없습니다.");
        }

        return ResponseEntity.ok(faq.getQuestion());
    }

    // 답변만 번호별 조회
    @ResponseBody
    @GetMapping("/api/faqs/answers/{index}")
    public ResponseEntity<?> getFaqAnswerOnly(@PathVariable int index) {

        FaqResponse faq = faqService.getFaqByIndex(index);

        if (faq == null) {
            return ResponseEntity.badRequest()
                    .body("해당 번호의 FAQ가 없습니다.");
        }

        return ResponseEntity.ok(faq.getAnswer());
    }
}