package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.Subscription;
import com.bu.jichulmate.dto.mypage.*;
import com.bu.jichulmate.dto.user.UserUpdateRequest;
import com.bu.jichulmate.exception.BusinessException;
import com.bu.jichulmate.response.ApiResponse;
import com.bu.jichulmate.service.AccountService;
import com.bu.jichulmate.service.MyPageService;
import com.bu.jichulmate.util.SessionUtils;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;   // ← 추가

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MyPageController {

    private final MyPageService myPageService;
    private final AccountService accountService;

    /**
     * 마이페이지 메인
     */
    @GetMapping
    public String myPage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);

        model.addAttribute("summary", myPageService.getMyPageSummary(userId));
        model.addAttribute("accounts", accountService.getAccountsByUser(userId));

        Pageable pageable = Pageable.ofSize(5);
        Page<Subscription> subscriptionPage = myPageService.getMySubscriptionList(userId, pageable);
        model.addAttribute("subscriptions", subscriptionPage.getContent());

        return "members/mypage/mypage";
    }

    /**
     * 새 계좌 등록 화면 (모달용 - 현재는 사용 안 함)
     */
    @GetMapping("/accounts/new")
    public String newAccountForm() {
        return "members/mypage/mybank";   // 모달 사용 중이므로 나중에 삭제 가능
    }

    /**
     * 계좌 등록 처리 (모달 Form 제출 방식)
     */
    @PostMapping("/accounts")
    public String registerAccount(
            @Valid @ModelAttribute AccountRegisterRequest request,   // @RequestBody → @ModelAttribute 변경
            BindingResult bindingResult,
            HttpSession session,
            RedirectAttributes redirectAttributes) {                 // RedirectAttributes 추가

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    bindingResult.getAllErrors().get(0).getDefaultMessage());
            return "redirect:/mypage";
        }

        Long userId = SessionUtils.getLoginUserId(session);

        try {
            accountService.registerAccount(userId, request);
            redirectAttributes.addFlashAttribute("successMessage",
                    "✅ 계좌가 성공적으로 등록되었습니다.");
            return "redirect:/mypage";
        } catch (BusinessException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/mypage";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "계좌 등록 중 오류가 발생했습니다.");
            return "redirect:/mypage";
        }
    }

    // ==================== 프로필 이미지 업로드 ====================

    @PostMapping("/profile/image")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updateProfileImage(
            @RequestParam("profileImage") MultipartFile file,
            HttpSession session
    ) {
        try {
            String imageUrl = myPageService.updateProfileImage(SessionUtils.getLoginUserId(session), file);
            return ResponseEntity.ok(ApiResponse.success(imageUrl));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error("프로필 이미지 업로드에 실패했습니다."));
        }
    }

    // ==================== 나머지 메서드들 ====================

    @GetMapping("/alarm")
    public String myAlarm() {
        return "members/mypage/myalarm";
    }

    @GetMapping("/posts")
    public String myPosts(@PageableDefault(size = 10) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("boards", myPageService.getMyBoardList(userId, pageable));
        return "members/mypage/mypost";
    }

    @GetMapping("/questions")
    public String myQuestions() {
        return "members/mypage/myque";
    }

    @GetMapping("/reports")
    public String myReports() {
        return "members/mypage/myreport";
    }

    @GetMapping("/sales")
    public String mySales() {
        return "members/mypage/mysales";
    }

    @GetMapping("/sales/list")
    public String mySalesList() {
        return "members/mypage/mysaleslist";
    }

    @GetMapping("/subscriptions")
    public String mySubscriptions(@PageableDefault(size = 5) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("subscriptions", myPageService.getMySubscriptionList(userId, pageable));
        return "members/mypage/mysub";
    }

    @GetMapping("/profile")
    public String profileUpdatePage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("user", myPageService.getUser(userId));
        return "members/mypage/profile";
    }

    @PostMapping("/profile")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updateProfile(
            @Valid @RequestBody UserUpdateRequest request,
            BindingResult bindingResult,
            HttpSession session
    ) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error(bindingResult.getAllErrors().get(0).getDefaultMessage()));
        }

        try {
            myPageService.updateProfile(SessionUtils.getLoginUserId(session), request);
            return ResponseEntity.ok(ApiResponse.success("프로필 정보가 수정되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/boards")
    public String myBoards(@PageableDefault(size = 10) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("boards", myPageService.getMyBoardList(userId, pageable));
        return "members/mypage/mypost";
    }

    @GetMapping("/parties")
    public String myParties(@PageableDefault(size = 5) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("parties", myPageService.getMyPartyList(userId, pageable));
        return "members/mypage/mysaleslist";
    }

    @PostMapping("/withdraw")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> withdraw(@RequestParam String password, HttpSession session) {
        try {
            myPageService.withdrawUser(SessionUtils.getLoginUserId(session), password);
            session.invalidate();
            return ResponseEntity.ok(ApiResponse.success("회원 탈퇴가 완료되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
}