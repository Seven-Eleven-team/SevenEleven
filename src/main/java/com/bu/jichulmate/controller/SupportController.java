package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.support.InquiryCreateRequest;
import com.bu.jichulmate.service.SupportService;
import com.bu.jichulmate.util.SessionUtils;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/support")
public class SupportController {

    private final SupportService supportService;

    /**
     * 고객센터 메인
     * URL: /support
     * View: /WEB-INF/views/support/support.jsp
     */
    @GetMapping
    public String supportMain() {
        return "support/support";
    }

    /**
     * 문의 목록
     * URL: /support/qna
     * View: /WEB-INF/views/support/qna.jsp
     */
    @GetMapping("/qna")
    public String qna(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("qnas", supportService.getMyInquiries(userId));
        return "support/qna";
    }

    /**
     * 문의 작성 페이지
     * URL: /support/qna/write
     * View: /WEB-INF/views/support/qnaForm.jsp
     */
    @GetMapping("/qna/write")
    public String writePage() {
        return "support/qnaForm";
    }

    /**
     * 문의 등록
     * URL: /support/qna
     */
    @PostMapping("/qna")
    public String create(InquiryCreateRequest request, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        supportService.createInquiry(userId, request);
        return "redirect:/support/qna";
    }

    /**
     * 기존 타입 기반 답변 API
     * URL: /support/type?type=1
     */
    @GetMapping("/type")
    @ResponseBody
    public String getAnswer(@RequestParam int type) {
        return supportService.getAnswerByType(type);
    }
}