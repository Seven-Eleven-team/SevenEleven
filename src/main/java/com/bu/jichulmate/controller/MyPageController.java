package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.mypage.*;
import com.bu.jichulmate.dto.mypage.MyPageSummaryResponse.SubscriptionDetail;
import com.bu.jichulmate.dto.user.UserUpdateRequest;
import com.bu.jichulmate.exception.BusinessException;
import com.bu.jichulmate.response.ApiResponse;
import com.bu.jichulmate.service.*;
import com.bu.jichulmate.util.SessionUtils;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
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

    @GetMapping
    public String myPage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("summary", myPageService.getMyPageSummary(userId));
        model.addAttribute("accounts", accountService.getAccountsByUser(userId));
        return "mypage/main";
    }

    @GetMapping("/edit")
    public String editPage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("summary", myPageService.getMyPageSummary(userId));
        model.addAttribute("userUpdateRequest", new UserUpdateRequest());
        return "mypage/edit";
    }

    @PostMapping("/edit")
    public String editProfile(@Valid @ModelAttribute UserUpdateRequest request, BindingResult bindingResult, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (bindingResult.hasErrors()) {
            model.addAttribute("summary", myPageService.getMyPageSummary(userId));
            return "mypage/edit";
        }
        try {
            myPageService.updateProfile(userId, request.getLoginId(), request.getNickname(), request.getEmail(), request.getGender(), request.getBirthDate());
            if (request.getNewPassword() != null && !request.getNewPassword().isBlank()) {
                myPageService.changePassword(userId, request.getCurrentPassword(), request.getNewPassword(), request.getConfirmPassword());
            }
            return "redirect:/mypage?editSuccess";
        } catch (BusinessException e) {
            model.addAttribute("errorMsg", e.getMessage());
            model.addAttribute("summary", myPageService.getMyPageSummary(userId));
            return "mypage/edit";
        }
    }

    @PostMapping("/edit/profile-image")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> uploadProfileImage(@RequestParam("file") MultipartFile file, HttpSession session) {
        try {
            return ResponseEntity.ok(ApiResponse.success(myPageService.updateProfileImage(SessionUtils.getLoginUserId(session), file)));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/security")
    public String securityPage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("summary", myPageService.getMyPageSummary(userId));
        model.addAttribute("pinUpdateRequest", new PinUpdateRequest());
        return "mypage/security";
    }

    @PostMapping("/security/pin")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updatePin(@Valid @RequestBody PinUpdateRequest request, HttpSession session) {
        try {
            myPageService.updatePin(SessionUtils.getLoginUserId(session), request);
            return ResponseEntity.ok(ApiResponse.success("PIN이 변경되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @PostMapping("/mentor-type")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updateMentorType(@RequestParam String mentorType, HttpSession session) {
        try {
            myPageService.updateMentorType(SessionUtils.getLoginUserId(session), mentorType);
            return ResponseEntity.ok(ApiResponse.success("멘토 성향이 저장되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/subscriptions/{subscriptionId}/detail")
    @ResponseBody
    public ResponseEntity<ApiResponse<SubscriptionDetail>> subscriptionDetail(@PathVariable Long subscriptionId, HttpSession session) {
        return ResponseEntity.ok(ApiResponse.success(myPageService.getSubscriptionDetail(SessionUtils.getLoginUserId(session), subscriptionId)));
    }

    @PostMapping("/subscriptions/{subscriptionId}/report")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> reportSubscription(@PathVariable Long subscriptionId, @RequestParam String reason, HttpSession session) {
        myPageService.reportSubscription(SessionUtils.getLoginUserId(session), subscriptionId, reason);
        return ResponseEntity.ok(ApiResponse.success("신고 접수 완료"));
    }

    @GetMapping("/subscriptions")
    public String mySubscriptions(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, HttpSession session, Model model) {
        model.addAttribute("subscriptions", myPageService.getMySubscriptions(SessionUtils.getLoginUserId(session), PageRequest.of(page, size)));
        model.addAttribute("activeTab", "subscriptions");
        model.addAttribute("currentPage", page);
        return "mypage/subscriptions";
    }

    @GetMapping("/orders")
    public String myOrders(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, HttpSession session, Model model) {
        model.addAttribute("subscriptions", myPageService.getMyOrderHistory(SessionUtils.getLoginUserId(session), PageRequest.of(page, size)));
        model.addAttribute("activeTab", "orders");
        model.addAttribute("currentPage", page);
        return "mypage/subscriptions";
    }

    @PostMapping("/orders/{subscriptionId}/resubscribe")
    public String resubscribe(@PathVariable Long subscriptionId, HttpSession session) {
        myPageService.resubscribe(SessionUtils.getLoginUserId(session), subscriptionId);
        return "redirect:/mypage/subscriptions?resubscribeSuccess";
    }

    @GetMapping("/boards")
    public String myBoards(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, HttpSession session, Model model) {
        model.addAttribute("boards", myPageService.getMyBoards(SessionUtils.getLoginUserId(session), PageRequest.of(page, size)));
        model.addAttribute("currentPage", page);
        return "mypage/boards";
    }

    @PostMapping("/boards/{boardId}/delete")
    public String deleteMyBoard(@PathVariable Long boardId, HttpSession session) {
        myPageService.deleteMyBoard(SessionUtils.getLoginUserId(session), boardId);
        return "redirect:/mypage/boards?deleteSuccess";
    }

    @GetMapping("/inquiries")
    public String myInquiries(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, HttpSession session, Model model) {
        model.addAttribute("inquiries", myPageService.getMyInquiries(SessionUtils.getLoginUserId(session), PageRequest.of(page, size)));
        model.addAttribute("currentPage", page);
        return "mypage/inquiries";
    }

    @PostMapping("/inquiries/{inquiryId}/delete")
    public String deleteMyInquiry(@PathVariable Long inquiryId, HttpSession session) {
        myPageService.deleteMyInquiry(SessionUtils.getLoginUserId(session), inquiryId);
        return "redirect:/mypage/inquiries?deleteSuccess";
    }

    @GetMapping("/reports")
    public String myReports(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, HttpSession session, Model model) {
        model.addAttribute("reports", myPageService.getMyReports(SessionUtils.getLoginUserId(session), PageRequest.of(page, size)));
        model.addAttribute("currentPage", page);
        return "mypage/reports";
    }

    @GetMapping("/notifications")
    public String notifications(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "20") int size, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("notifications", myPageService.getMyNotifications(userId, PageRequest.of(page, size)));
        model.addAttribute("emailNotify", myPageService.getMyPageSummary(userId).isEmailNotify());
        model.addAttribute("currentPage", page);
        return "mypage/notifications";
    }

    @PostMapping("/notifications/toggle-email")
    @ResponseBody
    public ResponseEntity<ApiResponse<Boolean>> toggleEmailNotify(HttpSession session) {
        return ResponseEntity.ok(ApiResponse.success(myPageService.toggleEmailNotify(SessionUtils.getLoginUserId(session))));
    }

    @PostMapping("/notifications/{notificationId}/read")
    @ResponseBody
    public ResponseEntity<ApiResponse<Void>> markAsRead(@PathVariable Long notificationId, HttpSession session) {
        myPageService.markNotificationAsRead(SessionUtils.getLoginUserId(session), notificationId);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @GetMapping("/sales")
    public String mySales(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        MyPageSummaryResponse summary = myPageService.getMyPageSummary(userId);
        if (!summary.isSellerRegistered()) return "mypage/sales_unregistered";
        model.addAttribute("posts", myPageService.getMyPartyPosts(userId, PageRequest.of(page, size)));
        model.addAttribute("currentPage", page);
        return "mypage/sales";
    }

    @GetMapping("/sales/{partyId}")
    public String mySaleDetail(@PathVariable Long partyId, HttpSession session, Model model) {
        model.addAttribute("post", myPageService.getMyPartyPostDetail(SessionUtils.getLoginUserId(session), partyId));
        return "mypage/sales_detail";
    }

    @PostMapping("/sales/{partyId}/complete")
    public String completeTrade(@PathVariable Long partyId, HttpSession session) {
        myPageService.completePartyTrade(SessionUtils.getLoginUserId(session), partyId);
        return "redirect:/mypage/sales/" + partyId + "?completeSuccess";
    }

    @PostMapping("/accounts")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> registerAccount(@Valid @RequestBody AccountRegisterRequest request, HttpSession session) {
        try {
            accountService.registerAccount(SessionUtils.getLoginUserId(session), request);
            return ResponseEntity.ok(ApiResponse.success("계좌 등록 완료"));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @PutMapping("/accounts/{accountId}")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updateAccount(@PathVariable Long accountId, @Valid @RequestBody AccountUpdateRequest request, HttpSession session) {
        try {
            accountService.updateAccount(SessionUtils.getLoginUserId(session), accountId, request);
            return ResponseEntity.ok(ApiResponse.success("계좌 수정 완료"));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @DeleteMapping("/accounts/{accountId}")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> deleteAccount(@PathVariable Long accountId, HttpSession session) {
        try {
            accountService.deleteAccount(SessionUtils.getLoginUserId(session), accountId);
            return ResponseEntity.ok(ApiResponse.success("계좌 삭제 완료"));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @PostMapping("/accounts/{accountId}/primary")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> setPrimary(@PathVariable Long accountId, HttpSession session) {
        accountService.setPrimaryAccount(SessionUtils.getLoginUserId(session), accountId);
        return ResponseEntity.ok(ApiResponse.success("대표계좌 설정 완료"));
    }

    @PostMapping("/withdraw")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> withdraw(@RequestParam String password, HttpSession session) {
        try {
            myPageService.withdrawUser(SessionUtils.getLoginUserId(session), password);
            session.invalidate();
            return ResponseEntity.ok(ApiResponse.success("탈퇴 완료"));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
}
