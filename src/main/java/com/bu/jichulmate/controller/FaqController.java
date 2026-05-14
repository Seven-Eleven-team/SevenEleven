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
    @GetMapping("/api/admin/faqs")
    public List<FaqResponse> getAllFaqs() {
        return faqService.getAllFaqList();
    }

    @ResponseBody
    @PostMapping("/api/admin/faqs")
    public ResponseEntity<FaqResponse> createFaq(@RequestBody FaqRequest request) {
        return ResponseEntity.ok(faqService.createFaq(request));
    }

    @ResponseBody
    @PutMapping("/api/admin/faqs/{faqId}")
    public ResponseEntity<FaqResponse> updateFaq(@PathVariable Long faqId, @RequestBody FaqRequest request) {
        return ResponseEntity.ok(faqService.updateFaq(faqId, request));
    }

    @ResponseBody
    @DeleteMapping("/api/admin/faqs/{faqId}")
    public ResponseEntity<Void> deleteFaq(@PathVariable Long faqId) {
        faqService.deleteFaq(faqId);
        return ResponseEntity.ok().build();
    }

    @ResponseBody
    @GetMapping("/api/faqs/chat")
    public ResponseEntity<?> getFaqByChat(@RequestParam String input) {
        String trimmed = input.trim();

        if (!trimmed.matches("\\d+")) {
            return ResponseEntity.badRequest().body("숫자만 입력해주세요.");
        }

        int index = Integer.parseInt(trimmed);
        FaqResponse response = faqService.getFaqByIndex(index);

        if (response == null) {
            return ResponseEntity.badRequest().body("해당 번호의 FAQ가 없습니다.");
        }

        return ResponseEntity.ok(response);
    }
}