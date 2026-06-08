package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.admin.AdminUserResponse;
import com.bu.jichulmate.dto.admin.UserStatusUpdateRequest;
import com.bu.jichulmate.service.AdminUserService;
import com.bu.jichulmate.util.SessionUtils;
import jakarta.servlet.http.HttpServletRequest; // ★ IP 추출용 추가
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/users")
@RequiredArgsConstructor
public class AdminUserApiController {

    private final AdminUserService adminUserService;
    // ★ 컨트롤러에 있던 AdminAuditService는 서비스 계층으로 역할을 넘겼으므로 삭제했습니다.

    @GetMapping
    public ResponseEntity<Map<String, Object>> getUserList(HttpSession session) {
        if (!SessionUtils.isAdmin(session)) {
            return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
        }

        List<AdminUserResponse> users = adminUserService.getAllUsers();
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", true);
        body.put("users", users);

        return ResponseEntity.ok(body);
    }

    @PatchMapping("/{userId}/status")
    public ResponseEntity<Map<String, Object>> changeUserStatus(
            @PathVariable("userId") Long userId,
            @RequestBody UserStatusUpdateRequest request,
            HttpSession session,
            HttpServletRequest httpRequest) { // ★ HttpServletRequest 추가

        if (!SessionUtils.isAdmin(session)) {
            return fail(HttpStatus.FORBIDDEN, "관리자 권한이 필요합니다.");
        }

        try {
            // ★ 세션에서 실제 관리자 객체 꺼내기
            User admin = (User) session.getAttribute(SessionUtils.SESSION_USER);
            // ★ 실제 접속 IP 꺼내기 (127.0.0.1 하드코딩 제거)
            String ipAddress = httpRequest.getRemoteAddr();

            // ★ 서비스로 모든 재료(대상, 상태, 관리자, IP)를 한 번에 넘겨줍니다.
            adminUserService.updateUserStatus(userId, request.getStatus(), admin, ipAddress);

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("message", "회원 상태가 변경되었습니다.");
            return ResponseEntity.ok(body);

        } catch (Exception e) {
            e.printStackTrace();
            return fail(HttpStatus.INTERNAL_SERVER_ERROR, "상태 변경 중 오류가 발생했습니다.");
        }
    }

    private ResponseEntity<Map<String, Object>> fail(HttpStatus status, String message) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", false);
        body.put("message", message);
        return ResponseEntity.status(status).body(body);
    }

    @GetMapping("/{userId}")
    public ResponseEntity<Map<String, Object>> getUserDetail(@PathVariable("userId") Long userId) {
        AdminUserResponse user = adminUserService.getUserById(userId);
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", true);
        body.put("user", user);
        return ResponseEntity.ok(body);
    }
}