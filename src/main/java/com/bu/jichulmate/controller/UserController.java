package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.user.UserUpdateRequest;
import com.bu.jichulmate.service.UserService;
import com.bu.jichulmate.service.FileService; // ★ FileService 임포트 추가
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile; // ★ MultipartFile 임포트 추가

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final FileService fileService; // ★ FileService 의존성 주입

    /**
     * 프로필 수정 API (사진 + 텍스트 동시 처리)
     */
    @PostMapping("/updateProfile")
    public ResponseEntity<Map<String, Object>> updateProfile(
            // ★ @RequestBody 대신 @RequestPart 사용 (JSON 텍스트 매핑)
            @RequestPart("userRequest") @Valid UserUpdateRequest request,
            BindingResult bindingResult,
            // ★ 사진 파일을 받기 위한 매개변수 추가 (required = false로 설정하여 사진 안 바꿀 때도 에러 안 나게 함)
            @RequestPart(value = "profileImage", required = false) MultipartFile profileImage,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        try {
            User loginUser = (User) session.getAttribute("loginUser");

            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다. 다시 로그인해주세요.");
                return ResponseEntity.status(401).body(result);
            }

            // 1. 기존 텍스트 정보 업데이트 (UserService)
            User updatedUser = userService.updateProfile(loginUser.getUserId(), request);

            // ★ 2. 프로필 사진 업로드 처리 (FileService)
            if (profileImage != null && !profileImage.isEmpty()) {
                // (1) 기존에 등록된 프사가 있다면 C드라이브 물리 파일과 DB 기록 모두 깔끔하게 삭제
                fileService.deleteFilesWithPhysicalFile("USERS", updatedUser.getUserId());

                // (2) 새 프사를 C드라이브에 저장하고 ATTACHMENTS 테이블에 기록
                fileService.uploadFile(profileImage, "USERS", updatedUser.getUserId());
            }

            // 3. 세션 정보 갱신
            session.setAttribute("loginUser", updatedUser);

            result.put("success", true);
            result.put("message", "정보가 성공적으로 수정되었습니다.");
            return ResponseEntity.ok(result);

        } catch (IllegalArgumentException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(result);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 내부 오류가 발생했습니다. 관리자에게 문의하세요.");
            return ResponseEntity.internalServerError().body(result);
        }
    }

    /**
     * 회원 탈퇴 API
     */
    @PostMapping("/withdraw")
    public ResponseEntity<Map<String, Object>> withdrawUser(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            User loginUser = (User) session.getAttribute("loginUser");

            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인 상태가 아닙니다.");
                return ResponseEntity.status(401).body(result);
            }

            userService.withdrawUser(loginUser.getUserId());
            session.invalidate();

            result.put("success", true);
            result.put("message", "회원 탈퇴가 정상적으로 처리되었습니다.");
            return ResponseEntity.ok(result);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "탈퇴 처리 중 서버 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(result);
        }
    }
}