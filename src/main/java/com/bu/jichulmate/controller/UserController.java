package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.User; // User 엔티티 임포트 경로를 확인하세요
import com.bu.jichulmate.dto.user.UserUpdateRequest;
import com.bu.jichulmate.service.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * UserController
 * 사용자 프로필 및 계정 관련 요청을 처리하는 컨트롤러입니다.
 */
@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    /**
     * 프로필 수정 API
     *
     * @param request  클라이언트로부터 전달받은 수정 정보 (DTO)
     * @param session  현재 로그인된 사용자의 세션 정보
     * @return        성공 여부와 메시지를 담은 JSON 응답
     */
    @PostMapping("/updateProfile")
    public ResponseEntity<Map<String, Object>> updateProfile(
            @RequestBody @Valid UserUpdateRequest request,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        try {
            // 1. 세션에서 로그인 유저 정보 가져오기
            User loginUser = (User) session.getAttribute("loginUser");

            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다. 다시 로그인해주세요.");
                return ResponseEntity.status(401).body(result); // 401 Unauthorized
            }

            // 2. 서비스 계층으로 업데이트 요청
            // 중요: User 엔티티의 ID 필드명이 userId이므로 getUserId()를 호출해야 함
            User updatedUser = userService.updateProfile(loginUser.getUserId(), request);

            // 3. 세션 정보 갱신
            // DB만 수정하고 세션을 그대로 두면, 마이페이지 화면에 옛날 정보가 표시됨.
            // 따라서 업데이트된 User 객체를 세션에 다시 저장하여 최신 상태를 유지함.
            session.setAttribute("loginUser", updatedUser);

            // 4. 성공 응답 반환
            result.put("success", true);
            result.put("message", "정보가 성공적으로 수정되었습니다.");
            return ResponseEntity.ok(result);

        } catch (IllegalArgumentException e) {
            // 서비스 계층에서 발생한 비즈니스 로직 에러 (예: 비밀번호 불일치, 중복 이메일 등)
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(result); // 400 Bad Request

        } catch (Exception e) {
            // 예상치 못한 서버 내부 에러
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 내부 오류가 발생했습니다. 관리자에게 문의하세요.");
            return ResponseEntity.internalServerError().body(result); // 500 Internal Server Error
        }
    }
}
