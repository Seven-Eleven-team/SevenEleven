package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.User; // ★ 추가
import com.bu.jichulmate.dto.admin.AdminInquiryResponse;
import com.bu.jichulmate.dto.admin.InquiryAnswerRequest;
import com.bu.jichulmate.service.AdminSupportService;
import com.bu.jichulmate.util.SessionUtils; // ★ 추가
import jakarta.servlet.http.HttpServletRequest; // ★ 추가
import jakarta.servlet.http.HttpSession; // ★ 추가
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/inquiries")
@RequiredArgsConstructor
public class AdminSupportApiController {

    private final AdminSupportService adminSupportService;

    @GetMapping
    public ResponseEntity<Map<String, Object>> getInquiries(HttpSession session) {
        // ★ 접근 권한 체크 추가
        if (!SessionUtils.isAdmin(session)) {
            return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
        }

        List<AdminInquiryResponse> inquiries = adminSupportService.getAllInquiries();

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", true);
        body.put("inquiries", inquiries);
        return ResponseEntity.ok(body);
    }

    @PostMapping("/{inquiryId}/answer")
    public ResponseEntity<Map<String, Object>> answerInquiry(
            @PathVariable("inquiryId") Long inquiryId,
            @RequestBody InquiryAnswerRequest request,
            HttpSession session,               // ★ 세션 추가
            HttpServletRequest httpRequest) {  // ★ IP 추출용 추가
        try {
            // ★ 권한 체크
            if (!SessionUtils.isAdmin(session)) {
                return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
            }

            // ★ 세션에서 관리자 정보 꺼내기 & IP 주소 꺼내기
            User admin = (User) session.getAttribute(SessionUtils.SESSION_USER);
            String ipAddress = httpRequest.getRemoteAddr();

            // ★ 서비스로 admin, ipAddress 넘기기
            adminSupportService.answerInquiry(inquiryId, request.getAnswer(), admin, ipAddress);

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("message", "문의 답변이 등록되었습니다.");
            return ResponseEntity.ok(body);

        } catch (IllegalArgumentException e) {
            return fail(HttpStatus.BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            return fail(HttpStatus.INTERNAL_SERVER_ERROR, "문의 답변 등록 중 오류가 발생했습니다.");
        }
    }

    private ResponseEntity<Map<String, Object>> fail(HttpStatus status, String message) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", false);
        body.put("message", message);
        return ResponseEntity.status(status).body(body);
    }
}