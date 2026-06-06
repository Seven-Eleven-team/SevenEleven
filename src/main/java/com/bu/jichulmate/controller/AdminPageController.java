package com.bu.jichulmate.controller;

import com.bu.jichulmate.util.SessionUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminPageController {

    @GetMapping({"", "/"})
    public String adminIndex(HttpSession session) {
        if (!SessionUtils.isAdmin(session)) {
            return "redirect:/login";
        }

        return "admin/admin_index";
    }
}