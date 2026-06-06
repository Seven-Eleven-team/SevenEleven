package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.support.FaqRequest;
import com.bu.jichulmate.dto.support.FaqResponse;
import com.bu.jichulmate.service.FaqService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/faqs") // ★ 다른 관리자 기능들과 주소 완벽 통일!
@RequiredArgsConstructor
public class AdminFaqApiController {

    private final FaqService faqService;

    // 1. 관리자 - 전체 FAQ 목록 조회
    @GetMapping
    public List<FaqResponse> getAllFaqs() {
        return faqService.getAllFaqList();
    }

    // 2. 관리자 - 새 FAQ 등록
    @PostMapping
    public ResponseEntity<FaqResponse> createFaq(@RequestBody FaqRequest request) {
        return ResponseEntity.ok(faqService.createFaq(request));
    }

    // 3. 관리자 - FAQ 수정
    @PutMapping("/{faqId}")
    public ResponseEntity<FaqResponse> updateFaq(
            @PathVariable("faqId") Long faqId,
            @RequestBody FaqRequest request
    ) {
        return ResponseEntity.ok(faqService.updateFaq(faqId, request));
    }

    // 4. 관리자 - FAQ 삭제
    @DeleteMapping("/{faqId}")
    public ResponseEntity<Void> deleteFaq(@PathVariable("faqId") Long faqId) {
        faqService.deleteFaq(faqId);
        return ResponseEntity.ok().build();
    }
}