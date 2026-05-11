package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.auth.FindPasswordRequest;
import com.bu.jichulmate.dto.auth.LoginRequest;
import com.bu.jichulmate.dto.auth.ResetPasswordRequest;
import com.bu.jichulmate.dto.auth.SignupRequest;
import com.bu.jichulmate.service.AuthService;
import com.bu.jichulmate.service.PasswordResetService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class AuthApiController {

    private final AuthService authService;
    private final PasswordResetService passwordResetService;

    @PostMapping("/auth/login")
    public ResponseEntity<Map<String, Object>> login(
            LoginRequest request,
            HttpSession session
    ) {
        return authService.login(request.getId(), request.getPassword())
                .map(user -> {
                    session.setAttribute("loginUserId", user.getUserId());
                    session.setAttribute("loginId", user.getLoginId());
                    session.setAttribute("nickname", user.getNickname());
                    session.setAttribute("role", user.getRole());

                    Map<String, Object> body = new LinkedHashMap<>();
                    body.put("ok", true);
                    body.put("message", "로그인이 완료되었습니다.");
                    body.put("redirectTo", "/");
                    return ResponseEntity.ok(body);
                })
                .orElseGet(() -> {
                    Map<String, Object> body = new LinkedHashMap<>();
                    body.put("ok", false);
                    body.put("message", "이메일 또는 비밀번호가 올바르지 않습니다.");
                    return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(body);
                });
    }

    @PostMapping("/auth/register")
    public ResponseEntity<Map<String, Object>> register(SignupRequest request) {
        try {
            authService.register(request);

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("message", "회원가입이 완료되었습니다.");
            body.put("redirectTo", "/");
            return ResponseEntity.ok(body);

        } catch (IllegalArgumentException e) {
            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", false);
            body.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(body);
        }
    }

    @PostMapping("/auth/find-password")
    public ResponseEntity<Map<String, Object>> findPassword(
            FindPasswordRequest request,
            HttpServletRequest servletRequest
    ) {
        try {
            String baseUrl = getBaseUrl(servletRequest);

            passwordResetService.sendResetLink(request.getEmail(), baseUrl);

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("message", "입력하신 이메일로 비밀번호 재설정 안내를 보냈습니다.");
            return ResponseEntity.ok(body);

        } catch (IllegalArgumentException e) {
            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", false);
            body.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(body);

        } catch (Exception e) {
            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", false);
            body.put("message", "메일 발송 중 문제가 발생했습니다. 잠시 후 다시 시도해 주세요.");
            return ResponseEntity.internalServerError().body(body);
        }
    }

    @PostMapping("/auth/password/reset")
    public ResponseEntity<Map<String, Object>> resetPassword(ResetPasswordRequest request) {
        try {
            passwordResetService.resetPassword(
                    request.getToken(),
                    request.getPassword(),
                    request.getPasswordConfirm()
            );

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("message", "비밀번호가 변경되었습니다. 새 비밀번호로 로그인해 주세요.");
            body.put("redirectTo", "/auth/login");
            return ResponseEntity.ok(body);

        } catch (IllegalArgumentException e) {
            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", false);
            body.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(body);
        }
    }

    @GetMapping("/api/auth/id-exists")
    public Map<String, Object> idExists(@RequestParam String id) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("exists", authService.existsByLoginId(id));
        return body;
    }

    @GetMapping("/api/auth/email-exists")
    public Map<String, Object> emailExists(@RequestParam String email) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("exists", authService.existsByEmail(email));
        return body;
    }

    @GetMapping("/api/auth/nickname-exists")
    public Map<String, Object> nicknameExists(@RequestParam String nickname) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("exists", authService.existsByNickname(nickname));
        return body;
    }

    @PostMapping("/auth/logout")
    public Map<String, Object> logout(HttpSession session) {
        session.invalidate();

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", true);
        body.put("message", "로그아웃되었습니다.");
        return body;
    }

    private String getBaseUrl(HttpServletRequest request) {
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();

        boolean isDefaultHttp = "http".equals(scheme) && serverPort == 80;
        boolean isDefaultHttps = "https".equals(scheme) && serverPort == 443;

        if (isDefaultHttp || isDefaultHttps) {
            return scheme + "://" + serverName;
        }

        return scheme + "://" + serverName + ":" + serverPort;
    }
}