package com.bu.jichulmate.controller;

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
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MyPageController {

    private final MyPageService myPageService;
    private final AccountService accountService;

    /**
     * 마이페이지 메인
     * URL: /mypage
     * View: /WEB-INF/views/members/mypage/mypage.jsp
     */
    @GetMapping
    public String myPage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);

        model.addAttribute("summary", myPageService.getMyPageSummary(userId));
        model.addAttribute("accounts", accountService.getAccountsByUser(userId));

        return "members/mypage/mypage";
    }

    /**
     * 내 알림
     * URL: /mypage/alarm
     * View: /WEB-INF/views/members/mypage/myalarm.jsp
     */
    @GetMapping("/alarm")
    public String myAlarm() {
        return "members/mypage/myalarm";
    }

    /**
     * 내 게시글
     * URL: /mypage/posts
     * View: /WEB-INF/views/members/mypage/mypost.jsp
     */
    @GetMapping("/posts")
    public String myPosts(@PageableDefault(size = 10) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("boards", myPageService.getMyBoardList(userId, pageable));
        return "members/mypage/mypost";
    }

    /**
     * 내 문의
     * URL: /mypage/questions
     * View: /WEB-INF/views/members/mypage/myque.jsp
     */
    @GetMapping("/questions")
    public String myQuestions() {
        return "members/mypage/myque";
    }

    /**
     * 내 신고
     * URL: /mypage/reports
     * View: /WEB-INF/views/members/mypage/myreport.jsp
     */
    @GetMapping("/reports")
    public String myReports() {
        return "members/mypage/myreport";
    }

    /**
     * 판매자 페이지
     * URL: /mypage/sales
     * View: /WEB-INF/views/members/mypage/mysales.jsp
     */
    @GetMapping("/sales")
    public String mySales() {
        return "members/mypage/mysales";
    }

    /**
     * 판매 목록
     * URL: /mypage/sales/list
     * View: /WEB-INF/views/members/mypage/mysaleslist.jsp
     */
    @GetMapping("/sales/list")
    public String mySalesList() {
        return "members/mypage/mysaleslist";
    }

    /**
     * 내 구독
     * URL: /mypage/subscriptions
     * View: /WEB-INF/views/members/mypage/mysub.jsp
     */
    @GetMapping("/subscriptions")
    public String mySubscriptions(@PageableDefault(size = 5) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("subscriptions", myPageService.getMySubscriptionList(userId, pageable));
        return "members/mypage/mysub";
    }

    /**
     * 프로필 수정 페이지
     * 실제 profile.jsp가 없다면 이 매핑은 사용하지 않아도 된다.
     */
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

    @PostMapping("/accounts")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> registerAccount(
            @Valid @RequestBody AccountRegisterRequest request,
            BindingResult bindingResult,
            HttpSession session
    ) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error(bindingResult.getAllErrors().get(0).getDefaultMessage()));
        }

        try {
            accountService.registerAccount(SessionUtils.getLoginUserId(session), request);
            return ResponseEntity.ok(ApiResponse.success("계좌가 정상적으로 등록되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @DeleteMapping("/accounts/{accountId}")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> deleteAccount(@PathVariable Long accountId, HttpSession session) {
        try {
            accountService.deleteAccount(SessionUtils.getLoginUserId(session), accountId);
            return ResponseEntity.ok(ApiResponse.success("계좌가 삭제되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @PostMapping("/accounts/{accountId}/primary")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> setPrimary(@PathVariable Long accountId, HttpSession session) {
        try {
            accountService.setPrimaryAccount(SessionUtils.getLoginUserId(session), accountId);
            return ResponseEntity.ok(ApiResponse.success("대표 계좌가 설정되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
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