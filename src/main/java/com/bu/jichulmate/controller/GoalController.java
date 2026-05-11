package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.SavingGoal;
import com.bu.jichulmate.repository.GoalRepository;
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
            // 1. 새로운 목표 객체 생성 및 안전한 데이터 세팅
            SavingGoal goal = new SavingGoal();
            goal.setItemName(request.getItemName());
            goal.setItemPrice(request.getItemPrice());
            goal.setUserId(request.getUserId());
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