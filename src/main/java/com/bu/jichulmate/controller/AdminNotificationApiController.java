package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.admin.NotificationLogResponse;
import com.bu.jichulmate.service.AdminNotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/notifications") // ★ 공통 주소를 깔끔하게 묶었습니다.
@RequiredArgsConstructor
public class AdminNotificationApiController {

    private final AdminNotificationService adminNotificationService;

    // 1. 알림 발송 내역 전체 조회 API
    @GetMapping
    public ResponseEntity<Map<String, Object>> getNotificationLogs() {
        List<NotificationLogResponse> logs = adminNotificationService.getAllNotificationLogs();

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", true);
        body.put("logs", logs);
        return ResponseEntity.ok(body);
    }
}