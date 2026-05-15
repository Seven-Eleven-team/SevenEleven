package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.mypage.*;
import com.bu.jichulmate.dto.user.UserUpdateRequest;
import com.bu.jichulmate.exception.BusinessException;
import com.bu.jichulmate.response.ApiResponse;
import com.bu.jichulmate.service.*;
import com.bu.jichulmate.util.SessionUtils;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
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
     * MY-01: 마이페이지 메인 (요약 정보 및 계좌 목록)
     */
    @GetMapping
    public String myPage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("summary", myPageService.getMyPageSummary(userId));
        model.addAttribute("accounts", accountService.getAccountsByUser(userId));
        return "mypage/main";
    }

    /**
     * MY-02: 프로필 수정 페이지 이동
     */
    @GetMapping("/profile")
    public String profileUpdatePage(HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        // ★ 에러 해결: MyPageService에서 public으로 바뀐 getUser를 호출합니다.
        model.addAttribute("user", myPageService.getUser(userId));
        return "mypage/profile";
    }

    /**
     * MY-03: 프로필 정보 업데이트 (닉네임, 아이디, 성별 등)
     */
    @PostMapping("/profile")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updateProfile(@Valid @RequestBody UserUpdateRequest request, BindingResult bindingResult, HttpSession session) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(ApiResponse.error(bindingResult.getAllErrors().get(0).getDefaultMessage()));
        }
        try {
            myPageService.updateProfile(SessionUtils.getLoginUserId(session), request);
            return ResponseEntity.ok(ApiResponse.success("프로필 정보가 수정되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    /**
     * MY-04: 프로필 이미지 업로드 (AJAX)
     */
    @PostMapping("/profile/image")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> updateProfileImage(@RequestParam("profileImage") MultipartFile file, HttpSession session) {
        try {
            String imageUrl = myPageService.updateProfileImage(SessionUtils.getLoginUserId(session), file);
            return ResponseEntity.ok(ApiResponse.success(imageUrl));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error("프로필 이미지 업로드에 실패했습니다."));
        }
    }

    /**
     * MY-05: 내 구독 서비스 목록 조회 (페이징)
     */
    @GetMapping("/subscriptions")
    public String mySubscriptions(@PageableDefault(size = 5) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("subscriptions", myPageService.getMySubscriptionList(userId, pageable));
        return "mypage/sub-list";
    }

    /**
     * MY-06: 내 게시글 목록 조회 (페이징)
     */
    @GetMapping("/boards")
    public String myBoards(@PageableDefault(size = 10) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("boards", myPageService.getMyBoardList(userId, pageable));
        return "mypage/board-list";
    }

    /**
     * MY-07: 내 파티 목록 조회 (페이징)
     */
    @GetMapping("/parties")
    public String myParties(@PageableDefault(size = 5) Pageable pageable, HttpSession session, Model model) {
        Long userId = SessionUtils.getLoginUserId(session);
        model.addAttribute("parties", myPageService.getMyPartyList(userId, pageable));
        return "mypage/party-list";
    }

    /**
     * MY-08: 계좌 등록
     */
    @PostMapping("/accounts")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> registerAccount(@Valid @RequestBody AccountRegisterRequest request, BindingResult bindingResult, HttpSession session) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(ApiResponse.error(bindingResult.getAllErrors().get(0).getDefaultMessage()));
        }
        try {
            accountService.registerAccount(SessionUtils.getLoginUserId(session), request);
            return ResponseEntity.ok(ApiResponse.success("계좌가 정상적으로 등록되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    /**
     * MY-09: 계좌 삭제
     */
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

    /**
     * MY-10: 대표 계좌 설정
     */
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

    /**
     * MY-11: 회원 탈퇴
     */
    @PostMapping("/withdraw")
    @ResponseBody
    public ResponseEntity<ApiResponse<String>> withdraw(@RequestParam String password, HttpSession session) {
        try {
            myPageService.withdrawUser(SessionUtils.getLoginUserId(session), password);
            session.invalidate(); // 탈퇴 시 세션 무효화
            return ResponseEntity.ok(ApiResponse.success("회원 탈퇴가 완료되었습니다."));
        } catch (BusinessException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
}