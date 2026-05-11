package com.bu.jichulmate.controller;

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
    @DeleteMapping("/api/admin/faqs/{faqId}")
    public ResponseEntity<Void> deleteFaq(@PathVariable Long faqId) {
        faqService.deleteFaq(faqId);
        return ResponseEntity.ok().build();
    }
}