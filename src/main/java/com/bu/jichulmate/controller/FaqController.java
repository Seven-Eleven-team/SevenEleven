package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.support.FaqRequest;
import com.bu.jichulmate.dto.support.FaqResponse;
import com.bu.jichulmate.service.FaqService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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

    @ResponseBody
    @GetMapping("/api/faqs")
    public List<FaqResponse> getFaqs() {
        return faqService.getFaqList();
    }

    @ResponseBody
    @GetMapping("/api/faqs/category")
    public List<FaqResponse> getFaqsByCategory(@RequestParam String category) {
        return faqService.getFaqListByCategory(category);
    }


    @ResponseBody
    @PostMapping("/api/faqs/chat")
    public ResponseEntity<?> getFaqByChat(@RequestBody Map<String, String> body) {

        String input = body.getOrDefault("input", "").trim();

        if (!input.matches("\\d+")) {
            return ResponseEntity.badRequest()
                    .body("숫자만 입력해주세요.");
        }

        int index = Integer.parseInt(input) -1;
        FaqResponse response = faqService.getFaqByIndex(index);

        if (response == null) {
            return ResponseEntity.badRequest()
                    .body("해당 번호의 FAQ가 없습니다.");
        }

        return ResponseEntity.ok(response);
    }

    @ResponseBody
    @GetMapping("/api/faqs/guide")
    public ResponseEntity<String> getGuideMessage() {
        return ResponseEntity.ok("추가로 궁금한 내용이 있으시면 번호를 입력해주세요.");
    }

    @ResponseBody
    @GetMapping("/api/faqs/questions")
    public List<String> getFaqQuestionsOnly() {
        return faqService.getFaqList()
                .stream()
                .map(FaqResponse::getQuestion)
                .toList();
    }

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