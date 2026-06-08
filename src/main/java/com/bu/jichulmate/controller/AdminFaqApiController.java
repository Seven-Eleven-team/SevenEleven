package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.User; // ★ 추가
import com.bu.jichulmate.dto.support.FaqRequest;
import com.bu.jichulmate.service.FaqService;
import com.bu.jichulmate.util.SessionUtils; // ★ 추가
import jakarta.servlet.http.HttpServletRequest; // ★ 추가
import jakarta.servlet.http.HttpSession; // ★ 추가
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/faqs")
@RequiredArgsConstructor
public class AdminFaqApiController {

    private final FaqService faqService;

    // 1. 관리자 - 전체 FAQ 목록 조회 (권한 체크 추가)
    @GetMapping
    public ResponseEntity<?> getAllFaqs(HttpSession session) {
        if (!SessionUtils.isAdmin(session)) {
            return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
        }
        return ResponseEntity.ok(faqService.getAllFaqList());
    }

    // 2. 관리자 - 새 FAQ 등록
    @PostMapping
    public ResponseEntity<?> createFaq(
            @RequestBody FaqRequest request,
            HttpSession session,               // ★ 세션 추가
            HttpServletRequest httpRequest) {  // ★ IP 추출용 추가

        if (!SessionUtils.isAdmin(session)) {
            return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
        }

        User admin = (User) session.getAttribute(SessionUtils.SESSION_USER);
        String ipAddress = httpRequest.getRemoteAddr();

        return ResponseEntity.ok(faqService.createFaq(request, admin, ipAddress));
    }

    // 3. 관리자 - FAQ 수정
    @PutMapping("/{faqId}")
    public ResponseEntity<?> updateFaq(
            @PathVariable("faqId") Long faqId,
            @RequestBody FaqRequest request,
            HttpSession session,               // ★ 세션 추가
            HttpServletRequest httpRequest) {  // ★ IP 추출용 추가

        if (!SessionUtils.isAdmin(session)) {
            return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
        }

        User admin = (User) session.getAttribute(SessionUtils.SESSION_USER);
        String ipAddress = httpRequest.getRemoteAddr();

        return ResponseEntity.ok(faqService.updateFaq(faqId, request, admin, ipAddress));
    }

    // 4. 관리자 - FAQ 삭제
    @DeleteMapping("/{faqId}")
    public ResponseEntity<?> deleteFaq(
            @PathVariable("faqId") Long faqId,
            HttpSession session,               // ★ 세션 추가
            HttpServletRequest httpRequest) {  // ★ IP 추출용 추가

        if (!SessionUtils.isAdmin(session)) {
            return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
        }

        User admin = (User) session.getAttribute(SessionUtils.SESSION_USER);
        String ipAddress = httpRequest.getRemoteAddr();

        faqService.deleteFaq(faqId, admin, ipAddress);
        return ResponseEntity.ok().build();
    }

    // 공통 실패 응답 템플릿
    private ResponseEntity<Map<String, Object>> fail(HttpStatus status, String message) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", false);
        body.put("message", message);
        return ResponseEntity.status(status).body(body);
    }
}