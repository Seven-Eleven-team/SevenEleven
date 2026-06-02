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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MyPageController {

    private final MyPageService myPageService;
    private final AccountService accountService;

    /* [내 정보 수정 페이지] */
    @GetMapping("/editprofile")
    public String editProfile(HttpSession session) {
        // 로그인 체크: ID가 없으면 메인으로 리다이렉트
        if (SessionUtils.getLoginUserId(session) == null) {
            return "redirect:/";
        }
        return "members/mypage/editprofile";
    }

    /**
     * 마이페이지 메인
     */
    @GetMapping({"", "/", "/mypage"})
    public String myPage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);

        // 로그인 체크
        if (userId == null) {
            return "redirect:/";
        }

        model.addAttribute("summary", myPageService.getMyPageSummary(userId));
        model.addAttribute("accounts", accountService.getAccountsByUser(userId));

        Pageable pageable = Pageable.ofSize(5);
        Page<Subscription> subscriptionPage = myPageService.getMySubscriptionList(userId, pageable);
        model.addAttribute("subscriptions", subscriptionPage.getContent());

        return "members/mypage/mypage";
    }

    /**
     * 계좌 등록 / 수정 처리
     */
    @PostMapping("/accounts")
    public String registerOrUpdateAccount(
            @Valid @ModelAttribute AccountRegisterRequest request,
            BindingResult bindingResult,
            @RequestParam(value = "mode", defaultValue = "register") String mode,
            @RequestParam(value = "accountId", required = false) Long accountId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // 로그인 체크
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) {
            return "redirect:/";
        }

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    bindingResult.getAllErrors().get(0).getDefaultMessage());
            return "redirect:/mypage";
        }

        try {
            if ("edit".equals(mode) && accountId != null) {
                accountService.updateAccount(userId, accountId, request);
                redirectAttributes.addFlashAttribute("successMessage",
                        "✅ 계좌가 성공적으로 수정되었습니다.");
            } else {
                accountService.registerAccount(userId, request);
                redirectAttributes.addFlashAttribute("successMessage",
                        "✅ 계좌가 성공적으로 등록되었습니다.");
            }
            return "redirect:/mypage";

        } catch (BusinessException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/mypage";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "계좌 처리 중 오류가 발생했습니다.");
            return "redirect:/mypage";
        }
    }

    /**
     * 새 계좌 등록 화면 (모달용)
     */
    @GetMapping("/accounts/new")
    public String newAccountForm(HttpSession session) {
        if (SessionUtils.getLoginUserId(session) == null) {
            return "redirect:/";
        }
        return "members/mypage/mybank";
    }

    // ==================== 프로필 이미지 업로드 ====================

    @PostMapping("/profile/image")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updateProfileImage(
            @RequestParam("profileImage") MultipartFile file,
            HttpSession session) {

        // API 응답은 401 Unauthorized 상태코드를 전달
        if (SessionUtils.getLoginUserId(session) == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(ApiResponse.error("로그인이 필요합니다."));
        }

        try {
            String imageUrl = myPageService.updateProfileImage(SessionUtils.getLoginUserId(session), file);
            return ResponseEntity.ok(ApiResponse.success(imageUrl));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error("프로필 이미지 업로드에 실패했습니다."));
        }
    }

    // ==================== 나머지 마이페이지 메뉴들 ====================

    @GetMapping("/alarm")
    public String myAlarm(HttpSession session) {
        if (SessionUtils.getLoginUserId(session) == null) {
            return "redirect:/";
        }
        return "members/mypage/myalarm";
    }

    @GetMapping("/posts")
    public String myPosts(@PageableDefault(size = 10) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) {
            return "redirect:/";
        }
        model.addAttribute("boards", myPageService.getMyBoardList(userId, pageable));
        return "members/mypage/mypost";
    }

    @GetMapping("/questions")
    public String myQuestions(HttpSession session) {
        if (SessionUtils.getLoginUserId(session) == null) {
            return "redirect:/";
        }
        return "members/mypage/myque";
    }

    @GetMapping("/reports")
    public String myReports(HttpSession session) {
        if (SessionUtils.getLoginUserId(session) == null) {
            return "redirect:/";
        }
        return "members/mypage/myreport";
    }

    @GetMapping("/sales")
    public String mySales(HttpSession session) {
        if (SessionUtils.getLoginUserId(session) == null) {
            return "redirect:/";
        }
        return "members/mypage/mysales";
    }

    @GetMapping("/sales/list")
    public String mySalesList(HttpSession session) {
        if (SessionUtils.getLoginUserId(session) == null) {
            return "redirect:/";
        }
        return "members/mypage/mysaleslist";
    }

    @GetMapping("/subscriptions")
    public String mySubscriptions(@PageableDefault(size = 5) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) {
            return "redirect:/";
        }
        model.addAttribute("subscriptions", myPageService.getMySubscriptionList(userId, pageable));
        return "members/mypage/mysub";
    }

    @GetMapping("/profile")
    public String profileUpdatePage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) {
            return "redirect:/";
        }
        model.addAttribute("user", myPageService.getUser(userId));
        return "members/mypage/profile";
    }

    @PostMapping("/profile")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updateProfile(
            @Valid @RequestBody UserUpdateRequest request,
            BindingResult bindingResult,
            HttpSession session) {

        if (SessionUtils.getLoginUserId(session) == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(ApiResponse.error("로그인이 필요합니다."));
        }

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
        if (userId == null) {
            return "redirect:/";
        }
        model.addAttribute("boards", myPageService.getMyBoardList(userId, pageable));
        return "members/mypage/mypost";
    }

    @GetMapping("/parties")
    public String myParties(@PageableDefault(size = 5) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) {
            return "redirect:/";
        }
        model.addAttribute("parties", myPageService.getMyPartyList(userId, pageable));
        return "members/mypage/mysaleslist";
    }

    @PostMapping("/withdraw")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> withdraw(@RequestParam String password, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(ApiResponse.error("로그인이 필요합니다."));
        }

        try {
            myPageService.withdrawUser(userId, password);
            session.invalidate();
            return ResponseEntity.ok(ApiResponse.success("회원 탈퇴가 완료되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
}
