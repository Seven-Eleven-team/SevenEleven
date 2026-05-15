package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.SavingGoal;
import com.bu.jichulmate.domain.User; // ★ 추가
import com.bu.jichulmate.repository.GoalRepository;
import com.bu.jichulmate.repository.UserRepository; // ★ 추가
import lombok.RequiredArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/goals")
public class GoalController {

    private final GoalRepository goalRepository;
    private final UserRepository userRepository; // ★ User 정보를 DB에서 찾기 위해 필수 추가!

    // ★ 프론트에서 넘어오는 데이터를 안전하게 담을 전용 그릇(DTO)
    @Getter @Setter
    public static class GoalRequest {
        private Long userId;
        private String itemName;
        private Long itemPrice;
    }

    @PostMapping
    public ResponseEntity<String> saveGoal(@RequestBody GoalRequest request) {
        try {
            // ★ 에러 해결의 핵심: 프론트에서 온 숫자(userId)로 진짜 User 객체를 찾아옵니다.
            User user = userRepository.findById(request.getUserId())
                    .orElseThrow(() -> new RuntimeException("유저를 찾을 수 없습니다."));

            // 1. 새로운 목표 객체 생성 및 안전한 데이터 세팅
            SavingGoal goal = new SavingGoal();
            goal.setGoalName(request.getItemName());
            goal.setTargetAmount(request.getItemPrice());

            // ★ 세팅 방식 변경: setUserId 가 아니라 setUser(객체) 로 넣습니다!
            goal.setUser(user);
            goal.setSavedAmount(0L); // 초기값 0원 세팅

            // 2. DB에 저장
            goalRepository.save(goal);

            return ResponseEntity.ok("성공");

        } catch (Exception e) {
            // ★ 에러가 나면 인텔리제이 콘솔에 빨간 글씨로 원인을 출력해 줍니다.
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("실패: " + e.getMessage());
        }
    }
}