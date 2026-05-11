package com.bu.jichulmate.faq.controller;

import com.bu.jichulmate.faq.dto.FaqRequest;
import com.bu.jichulmate.faq.dto.FaqResponse;
import com.bu.jichulmate.faq.service.FaqService;
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

    // 페이지 이동
    @GetMapping("/faq")
    public String faqPage() {
        return "support/faq";
    }

    // 사용자 - 전체 FAQ 조회
    @ResponseBody
    @GetMapping("/api/faqs")
    public List<FaqResponse> getFaqs() {
        return faqService.getFaqList();
    }

    // 사용자 - 카테고리별 FAQ 조회
    @ResponseBody
    @GetMapping("/api/faqs/category")
    public List<FaqResponse> getFaqsByCategory(@RequestParam String category) {
        return faqService.getFaqListByCategory(category);
    }

    // 관리자 - 전체 FAQ 조회 (비활성 포함)
    @ResponseBody
    @GetMapping("/api/admin/faqs")
    public List<FaqResponse> getAllFaqs() {
        return faqService.getAllFaqList();
    }

    // 관리자 - FAQ 등록
    @ResponseBody
    @PostMapping("/api/admin/faqs")
    public ResponseEntity<FaqResponse> createFaq(@RequestBody FaqRequest request) {
        return ResponseEntity.ok(faqService.createFaq(request));
    }

    // 관리자 - FAQ 수정
    @ResponseBody
    @PutMapping("/api/admin/faqs/{faqId}")
    public ResponseEntity<FaqResponse> updateFaq(@PathVariable Long faqId, @RequestBody FaqRequest request) {
        return ResponseEntity.ok(faqService.updateFaq(faqId, request));
    }

    // 관리자 - FAQ 삭제
    @ResponseBody
    @DeleteMapping("/api/admin/faqs/{faqId}")
    public ResponseEntity<Void> deleteFaq(@PathVariable Long faqId) {
        faqService.deleteFaq(faqId);
        return ResponseEntity.ok().build();
    }
}