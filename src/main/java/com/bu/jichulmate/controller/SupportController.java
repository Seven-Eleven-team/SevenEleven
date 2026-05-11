package com.bu.jichulmate.controller;

import org.springframework.ui.Model;
import com.bu.jichulmate.dto.support.InquiryCreateRequest;
import com.bu.jichulmate.service.SupportService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequiredArgsConstructor
@RequestMapping("/support")
public class SupportController {

    private final SupportService supportService;

    @GetMapping("/qna")
    public String qna(Model model){
        Long userId = 1L;
        model.addAttribute("qnas", supportService.getMyInquiries(userId));
        return "support/qna";
    }

    @GetMapping("/qna/write")
    public String writePage() {
        return "support/write";
    }

    @PostMapping("/qna")
    public String create(InquiryCreateRequest request){
        Long userId = 1L;
        supportService.createInquiry(userId, request);
        return "redirect:/support/qna";
    }

    @GetMapping("/type")
    @ResponseBody
    public String getAnswer(@RequestParam int type) {
        return supportService.getAnswerByType(type);
    }
}
