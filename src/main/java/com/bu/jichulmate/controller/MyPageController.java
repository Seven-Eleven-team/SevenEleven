package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.*;
import com.bu.jichulmate.dto.mypage.*;
import com.bu.jichulmate.dto.subscription.SubscriptionResponse;
import com.bu.jichulmate.dto.user.UserUpdateRequest;
import com.bu.jichulmate.exception.BusinessException;
import com.bu.jichulmate.repository.GoalRepository;
import com.bu.jichulmate.repository.InquiryRepository;
import com.bu.jichulmate.response.ApiResponse;
import com.bu.jichulmate.service.*;
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
import com.bu.jichulmate.repository.ExpenseRepository;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.stream.Collectors;

import java.util.List;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MyPageController {

    private final MyPageService myPageService;
    private final AccountService accountService;
    private final SubscriptionService subscriptionService;
    private final GoalRepository goalRepository;
    private final InquiryRepository inquiryRepository;
    private final NotificationService notificationService;
    private final FileService fileService;
    private final ExpenseRepository expenseRepository;

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

        List<SubscriptionResponse> top3 = subscriptionService.getTop3Subscriptions(userId);
        model.addAttribute("top3Subscriptions", top3);

        model.addAttribute("fixedGoal", goalRepository.findTopByUserUserIdOrderByIdDesc(userId)
                .filter(g -> "Y".equals(g.getIsFixed()))
                .orElse(null));

        // ==========================================================
        // ★ [수정된 부분] 일반 목표를 최신순으로 정렬하고 딱 2개만 자릅니다!
        // ==========================================================
        List<SavingGoal> allGoals = goalRepository.findByUserUserId(userId);

        // 1. Expense(가계부) 테이블에서 각 목표별로 지금까지 저축한 총액 계산
        List<Object[]> savingDataRaw = expenseRepository.getMonthlySavingsGroupedByGoal(userId);
        Map<Long, Long> goalTotals = new HashMap<>();
        for (Object[] row : savingDataRaw) {
            Long gId = ((Number) row[0]).longValue();
            Long amt = ((Number) row[2]).longValue();
            goalTotals.put(gId, amt);
        }
        // 계산된 금액을 JSP로 전달!
        model.addAttribute("goalTotals", goalTotals);

        // 2. 고정 목표 1개
        SavingGoal fixed = allGoals.stream()
                .filter(g -> "Y".equals(g.getIsFixed()))
                .max((g1, g2) -> g1.getId().compareTo(g2.getId()))
                .orElse(null);
        model.addAttribute("fixedGoal", fixed);

        // 일반 목표 최신순 2개 찾기
        List<SavingGoal> normalGoals = allGoals.stream()
                .filter(g -> "N".equals(g.getIsFixed()))
                .sorted((g1, g2) -> g2.getId().compareTo(g1.getId()))
                .limit(2)
                .collect(Collectors.toList());
        model.addAttribute("normalGoals", normalGoals);

        // =====================================================================
        // ★ 프로필 이미지 불러오기 (FileService 이용)
        // =====================================================================
        List<Attachment> attachments = fileService.findFiles("USERS", userId);
        if (!attachments.isEmpty()) {
            // 가장 최근에 올린 사진의 경로를 JSP로 넘겨줌
            String latestProfileImage = attachments.get(attachments.size() - 1).getFilePath();
            model.addAttribute("profileImageUrl", latestProfileImage);
        }

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
    public String myAlarm(@PageableDefault(size = 10) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) {
            return "redirect:/";
        }

        // 서비스에 pageable을 함께 넘깁니다.
        Page<NotificationResponse> alarms = notificationService.getMyNotifications(userId, pageable);

        model.addAttribute("alarms", alarms);

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
    public String myQuestions(@PageableDefault(size = 10) Pageable pageable,
                              HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) return "redirect:/";

        model.addAttribute("inquiries",
                inquiryRepository.findByUserIdOrderByCreatedAtDesc(userId, pageable));
        return "members/mypage/myque";
    }

    @PostMapping("/questions/delete/{id}")
    public String deleteInquiry(@PathVariable Long id, HttpSession session) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) return "redirect:/";
        inquiryRepository.deleteById(id);
        return "redirect:/mypage/questions";
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

    // MyPageController.java
    @GetMapping("/subscriptions")
    public String mySubscriptions(@PageableDefault(size = 5) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) {
            return "redirect:/";
        }

        // 1. 서비스에서 데이터를 가져옵니다.
        Page<Subscription> subPage = myPageService.getMySubscriptionList(userId, pageable);

        // 2. ★ 중요: JSP의 ${subscriptions}와 일치하도록 모델에 담아줍니다!
        model.addAttribute("subscriptions", subPage.getContent());

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

    @GetMapping("/goals")
    public String myGoals(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        if (userId == null) {
            return "redirect:/";
        }
        model.addAttribute("fixedGoal", goalRepository.findTopByUserUserIdOrderByIdDesc(userId)
                .filter(g -> "Y".equals(g.getIsFixed()))
                .orElse(null));

        List<SavingGoal> normalGoals = goalRepository.findByUserUserId(userId)
                .stream()
                .filter(g -> "N".equals(g.getIsFixed()))
                .collect(Collectors.toList());
        model.addAttribute("normalGoals", normalGoals);

        return "members/mypage/mygoals";
    }



}
