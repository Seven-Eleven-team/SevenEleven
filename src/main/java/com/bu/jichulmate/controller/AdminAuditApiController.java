package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.admin.AdminAuditLogResponse;
import com.bu.jichulmate.service.AdminAuditService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/audit-logs") // ★ 공통 주소 세팅 완료!
@RequiredArgsConstructor
public class AdminAuditApiController {

    private final AdminAuditService adminAuditService;

    // 1. 관리자 활동 추적 로그 조회 API
    @GetMapping
    public ResponseEntity<Map<String, Object>> getAuditLogs() {
        List<AdminAuditLogResponse> logs = adminAuditService.getAuditLogs();

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", true);
        body.put("logs", logs);
        return ResponseEntity.ok(body);
    }
}