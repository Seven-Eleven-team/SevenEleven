package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.admin.AdminInquiryResponse;
import com.bu.jichulmate.dto.admin.InquiryAnswerRequest;
import com.bu.jichulmate.service.AdminSupportService;
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
    public ResponseEntity<Map<String, Object>> getInquiries() {
        List<AdminInquiryResponse> inquiries = adminSupportService.getAllInquiries();

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", true);
        body.put("inquiries", inquiries);
        return ResponseEntity.ok(body);
    }

    @PostMapping("/{inquiryId}/answer")
    public ResponseEntity<Map<String, Object>> answerInquiry(
            @PathVariable("inquiryId") Long inquiryId,
            @RequestBody InquiryAnswerRequest request
    ) {
        try {
            adminSupportService.answerInquiry(inquiryId, request.getAnswer());

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
