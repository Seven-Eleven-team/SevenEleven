package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.admin.AdminUserResponse;
import com.bu.jichulmate.dto.admin.UserStatusUpdateRequest;
import com.bu.jichulmate.service.AdminAuditService;
import com.bu.jichulmate.service.AdminUserService;
import com.bu.jichulmate.util.SessionUtils;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/users") // ★ 공통 주소를 /users까지 확장하여 코드가 짧아집니다!
@RequiredArgsConstructor
public class AdminUserApiController {

    private final AdminUserService adminUserService;
    private final AdminAuditService adminAuditService;

    // 1. 회원 목록 조회 API
    @GetMapping
    public ResponseEntity<Map<String, Object>> getUserList(HttpSession session) {
        // 관리자 권한 철통 방어
        if (!SessionUtils.isAdmin(session)) {
            return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
        }

        List<AdminUserResponse> users = adminUserService.getAllUsers();

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", true);
        body.put("users", users);

        return ResponseEntity.ok(body);
    }

    // 2. 회원 상태 변경 API (정지/활성화)
    @PatchMapping("/{userId}/status")
    public ResponseEntity<Map<String, Object>> changeUserStatus(
            @PathVariable("userId") Long userId,
            @RequestBody UserStatusUpdateRequest request,
            HttpSession session) {

        if (!SessionUtils.isAdmin(session)) {
            return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
        }

        try {
            // 1. 상태 변경은 확실하게 수행
            adminUserService.updateUserStatus(userId, request.getStatus());

            // 2. 로그 기록을 별도 try-catch로 감싸서,
            // 로그 저장에 실패해도 상태 변경은 성공한 것으로 처리합니다.
            try {
                User admin = (User) session.getAttribute(SessionUtils.SESSION_USER);
                if (admin != null) {
                    adminAuditService.recordLog(admin, "USER_STATUS_UPDATE", "USERS", userId, "127.0.0.1");
                }
            } catch (Exception logError) {
                // 로그 저장 실패는 에러로 치지 않고 기록만 남깁니다.
                logError.printStackTrace();
            }

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("message", "회원 상태가 변경되었습니다.");
            return ResponseEntity.ok(body);

        } catch (Exception e) {
            e.printStackTrace();
            return fail(HttpStatus.INTERNAL_SERVER_ERROR, "상태 변경 중 오류가 발생했습니다.");
        }
    }

    // 공통 실패 응답 템플릿
    private ResponseEntity<Map<String, Object>> fail(HttpStatus status, String message) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", false);
        body.put("message", message);
        return ResponseEntity.status(status).body(body);
    }

    @GetMapping("/{userId}")
    public ResponseEntity<Map<String, Object>> getUserDetail(@PathVariable("userId") Long userId) {
        // 이제 서비스의 최적화된 단건 조회 메서드를 호출합니다.
        AdminUserResponse user = adminUserService.getUserById(userId);

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", true);
        body.put("user", user);
        return ResponseEntity.ok(body);
    }
}