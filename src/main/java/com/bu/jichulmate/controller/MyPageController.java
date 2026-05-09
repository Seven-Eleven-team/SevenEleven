/*
package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.*;
import com.bu.jichulmate.dto.mypage.*;
import com.bu.jichulmate.dto.mypage.MyPageSummaryResponse.SubscriptionDetail;
import com.bu.jichulmate.dto.user.UserUpdateRequest;
import com.bu.jichulmate.response.ApiResponse;
import com.bu.jichulmate.service.AccountService;
import com.bu.jichulmate.service.MyPageService;
import com.bu.jichulmate.util.SessionUtils;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MyPageController {

    private final MyPageService myPageService;
    private final AccountService accountService;

    // ── 마이페이지 메인 ───────────────────────────────────────

    @GetMapping
    public String myPage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        MyPageSummaryResponse summary = myPageService.getMyPageSummary(userId);
        List<Account> accounts = accountService.getAccountsByUser(userId);
        model.addAttribute("summary", summary);
        model.addAttribute("accounts", accounts);
        return "mypage/main";
    }

    // ── MY-01: 내 정보 수정 (아이디 포함) ────────────────────

    @GetMapping("/edit")
    public String editPage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("summary", myPageService.getMyPageSummary(userId));
        model.addAttribute("userUpdateRequest", new UserUpdateRequest());
        return "mypage/edit";
    }

    @PostMapping("/edit")
    public String editProfile(@Valid @ModelAttribute UserUpdateRequest request,
                              BindingResult bindingResult,
                              HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (bindingResult.hasErrors()) {
            model.addAttribute("summary", myPageService.getMyPageSummary(userId));
            return "mypage/edit";
        }
        try {
            // MY-01: 아이디 포함 수정
            myPageService.updateProfile(userId,
                    request.getLoginId(),
                    request.getNickname(),
                    request.getEmail(),
                    request.getGender(),
                    request.getBirthDate());

            if (request.getNewPassword() != null
                    && !request.getNewPassword().isBlank()) {
                myPageService.changePassword(userId,
                        request.getCurrentPassword(),
                        request.getNewPassword(),
                        request.getConfirmPassword());
            }
            return "redirect:/mypage?editSuccess";
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMsg", e.getMessage());
            model.addAttribute("summary", myPageService.getMyPageSummary(userId));
            return "mypage/edit";
        }
    }

    */
/**
     * POST /mypage/edit/profile-image  (AJAX - 프로필 사진 변경)
     *//*

    @PostMapping("/edit/profile-image")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> uploadProfileImage(
            @RequestParam("file") MultipartFile file,
            HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        try {
            String imageUrl = myPageService.updateProfileImage(userId, file);
            return ResponseEntity.ok(ApiResponse.success(imageUrl));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error("사진 업로드 실패: " + e.getMessage()));
        }
    }

    // ── MY-02: 보안 설정 (PIN) ────────────────────────────────

    */
/**
     * GET /mypage/security
     * 보안 설정 페이지
     *//*

    @GetMapping("/security")
    public String securityPage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("summary", myPageService.getMyPageSummary(userId));
        model.addAttribute("pinUpdateRequest", new PinUpdateRequest());
        return "mypage/security";
    }

    */
/**
     * POST /mypage/security/pin  (AJAX)
     * PIN 번호 변경
     *//*

    @PostMapping("/security/pin")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updatePin(
            @Valid @RequestBody PinUpdateRequest request,
            HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        try {
            myPageService.updatePin(userId, request);
            return ResponseEntity.ok(ApiResponse.success("PIN이 변경되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error(e.getMessage()));
        }
    }

    // ── MY-05: 멘토 성향 설정 ─────────────────────────────────

    */
/**
     * POST /mypage/mentor-type  (AJAX)
     * 멘토 성향 선택 저장
     * mentorType: MILD(순한맛) / MEDIUM(중간맛) / SPICY(매운맛)
     *//*

    @PostMapping("/mentor-type")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updateMentorType(
            @RequestParam String mentorType,
            HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        try {
            myPageService.updateMentorType(userId, mentorType);
            return ResponseEntity.ok(ApiResponse.success("멘토 성향이 저장되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error(e.getMessage()));
        }
    }

    // ── 구독 상세 / 신고 / 재구독 ─────────────────────────────

    @GetMapping("/subscriptions/{subscriptionId}/detail")
    @ResponseBody
    public ResponseEntity<ApiResponse<SubscriptionDetail>> subscriptionDetail(
            @PathVariable Long subscriptionId, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        SubscriptionDetail detail =
                myPageService.getSubscriptionDetail(userId, subscriptionId);
        return ResponseEntity.ok(ApiResponse.success(detail));
    }

    @PostMapping("/subscriptions/{subscriptionId}/report")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> reportSubscription(
            @PathVariable Long subscriptionId,
            @RequestParam String reason,
            HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        myPageService.reportSubscription(userId, subscriptionId, reason);
        return ResponseEntity.ok(ApiResponse.success("신고가 접수되었습니다."));
    }

    @GetMapping("/subscriptions")
    public String mySubscriptions(@RequestParam(defaultValue = "0") int page,
                                  @RequestParam(defaultValue = "10") int size,
                                  HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        Page<Subscription> subscriptions = myPageService
                .getMySubscriptions(userId, PageRequest.of(page, size));
        model.addAttribute("subscriptions", subscriptions);
        model.addAttribute("activeTab", "subscriptions");
        model.addAttribute("currentPage", page);
        return "mypage/subscriptions";
    }

    @GetMapping("/orders")
    public String myOrders(@RequestParam(defaultValue = "0") int page,
                           @RequestParam(defaultValue = "10") int size,
                           HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        Page<Subscription> orders = myPageService
                .getMyOrderHistory(userId, PageRequest.of(page, size));
        model.addAttribute("subscriptions", orders);
        model.addAttribute("activeTab", "orders");
        model.addAttribute("currentPage", page);
        return "mypage/subscriptions";
    }

    @PostMapping("/orders/{subscriptionId}/resubscribe")
    public String resubscribe(@PathVariable Long subscriptionId,
                              HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        myPageService.resubscribe(userId, subscriptionId);
        return "redirect:/mypage/subscriptions?resubscribeSuccess";
    }

    // ── 내 게시글 보기 ────────────────────────────────────────

    @GetMapping("/boards")
    public String myBoards(@RequestParam(defaultValue = "0") int page,
                           @RequestParam(defaultValue = "10") int size,
                           HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        Page<Board> boards = myPageService
                .getMyBoards(userId, PageRequest.of(page, size));
        model.addAttribute("boards", boards);
        model.addAttribute("currentPage", page);
        return "mypage/boards";
    }

    @PostMapping("/boards/{boardId}/delete")
    public String deleteMyBoard(@PathVariable Long boardId, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        myPageService.deleteMyBoard(userId, boardId);
        return "redirect:/mypage/boards?deleteSuccess";
    }

    // ── 내 문의 ───────────────────────────────────────────────

    @GetMapping("/inquiries")
    public String myInquiries(@RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "10") int size,
                              HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        Page<Inquiry> inquiries = myPageService
                .getMyInquiries(userId, PageRequest.of(page, size));
        model.addAttribute("inquiries", inquiries);
        model.addAttribute("currentPage", page);
        return "mypage/inquiries";
    }

    @PostMapping("/inquiries/{inquiryId}/delete")
    public String deleteMyInquiry(@PathVariable Long inquiryId, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        myPageService.deleteMyInquiry(userId, inquiryId);
        return "redirect:/mypage/inquiries?deleteSuccess";
    }

    // ── MY-07: 알림 ───────────────────────────────────────────

    @GetMapping("/notifications")
    public String notifications(@RequestParam(defaultValue = "0") int page,
                                @RequestParam(defaultValue = "20") int size,
                                HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        Page<NotificationLog> notifications = myPageService
                .getMyNotifications(userId, PageRequest.of(page, size));
        MyPageSummaryResponse summary = myPageService.getMyPageSummary(userId);
        model.addAttribute("notifications", notifications);
        model.addAttribute("emailNotify", summary.isEmailNotify());
        model.addAttribute("currentPage", page);
        return "mypage/notifications";
    }

    @PostMapping("/notifications/toggle-email")
    @ResponseBody
    public ResponseEntity<ApiResponse<Boolean>> toggleEmailNotify(HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        boolean result = myPageService.toggleEmailNotify(userId);
        return ResponseEntity.ok(ApiResponse.success(result));
    }

    @PostMapping("/notifications/{notificationId}/read")
    @ResponseBody
    public ResponseEntity<ApiResponse<Void>> markAsRead(
            @PathVariable Long notificationId, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        myPageService.markNotificationAsRead(userId, notificationId);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    // ── 내 판매 목록 ──────────────────────────────────────────

    @GetMapping("/sales")
    public String mySales(@RequestParam(defaultValue = "0") int page,
                          @RequestParam(defaultValue = "10") int size,
                          HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        MyPageSummaryResponse summary = myPageService.getMyPageSummary(userId);
        if (!summary.isSellerRegistered()) {
            return "mypage/sales_unregistered";
        }
        Page<PartyPost> posts = myPageService
                .getMyPartyPosts(userId, PageRequest.of(page, size));
        model.addAttribute("posts", posts);
        model.addAttribute("currentPage", page);
        return "mypage/sales";
    }

    @GetMapping("/sales/{partyId}")
    public String mySaleDetail(@PathVariable Long partyId,
                               @RequestParam(defaultValue = "0") int page,
                               @RequestParam(defaultValue = "10") int size,
                               HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        PartyPost post = myPageService.getMyPartyPostDetail(userId, partyId);
        Page<PartyMember> members = myPageService
                .getPartyMembers(userId, partyId, PageRequest.of(page, size));
        model.addAttribute("post", post);
        model.addAttribute("members", members);
        model.addAttribute("currentPage", page);
        return "mypage/sales_detail";
    }

    @PostMapping("/sales/{partyId}/complete")
    public String completeTrade(@PathVariable Long partyId, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        myPageService.completePartyTrade(userId, partyId);
        return "redirect:/mypage/sales/" + partyId + "?completeSuccess";
    }

    // ── 계좌 관리 AJAX ────────────────────────────────────────

    @PostMapping("/accounts")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> registerAccount(
            @Valid @RequestBody AccountRegisterRequest request,
            HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        try {
            accountService.registerAccount(userId, request);
            return ResponseEntity.ok(ApiResponse.success("계좌가 등록되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error(e.getMessage()));
        }
    }

    @PutMapping("/accounts/{accountId}")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updateAccount(
            @PathVariable Long accountId,
            @Valid @RequestBody AccountUpdateRequest request,
            HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        try {
            accountService.updateAccount(userId, accountId, request);
            return ResponseEntity.ok(ApiResponse.success("계좌가 수정되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error(e.getMessage()));
        }
    }

    @DeleteMapping("/accounts/{accountId}")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> deleteAccount(
            @PathVariable Long accountId, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        try {
            accountService.deleteAccount(userId, accountId);
            return ResponseEntity.ok(ApiResponse.success("계좌가 삭제되었습니다."));
        } catch (IllegalStateException e) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error(e.getMessage()));
        }
    }

    @PostMapping("/accounts/{accountId}/primary")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> setPrimary(
            @PathVariable Long accountId, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        accountService.setPrimaryAccount(userId, accountId);
        return ResponseEntity.ok(ApiResponse.success("대표계좌로 설정되었습니다."));
    }

    // ── 회원 탈퇴 ─────────────────────────────────────────────

    @PostMapping("/withdraw")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> withdraw(
            @RequestParam String password, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        try {
            myPageService.withdrawUser(userId, password);
            session.invalidate();
            return ResponseEntity.ok(ApiResponse.success("탈퇴가 완료되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error(e.getMessage()));
        }
    }
}*/
