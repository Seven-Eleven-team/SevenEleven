package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.admin.AdminUserResponse;
import com.bu.jichulmate.dto.admin.UserStatusUpdateRequest;
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

        // 관리자 권한 철통 방어
        if (!SessionUtils.isAdmin(session)) {
            return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
        }

        try {
            adminUserService.updateUserStatus(userId, request.getStatus());

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("message", "회원 상태가 성공적으로 변경되었습니다.");

            return ResponseEntity.ok(body);

        } catch (IllegalArgumentException e) {
            return fail(HttpStatus.BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
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
}