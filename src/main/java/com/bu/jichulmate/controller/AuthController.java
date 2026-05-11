package com.bu.jichulmate.controller;

import com.bu.jichulmate.service.PasswordResetService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class AuthController {

    private final PasswordResetService passwordResetService;

    @GetMapping("/auth/login")
    public String loginPage() {
        return "auth/login";
    }

    @GetMapping("/auth/register")
    public String registerPage() {
        return "auth/register";
    }

    @GetMapping("/auth/find-password")
    public String findPasswordPage() {
        return "auth/find-password";
    }

    @GetMapping("/auth/password/reset")
    public String resetPasswordPage(String token, Model model) {
        if (!passwordResetService.isValidToken(token)) {
            model.addAttribute("error", "유효하지 않거나 만료된 비밀번호 재설정 링크입니다.");
            return "auth/reset-password-invalid";
        }

        model.addAttribute("token", token);
        return "auth/reset-password";
    }
}