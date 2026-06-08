package com.bu.jichulmate.dto.mypage;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class NotificationResponse {
    private Long logId;
    private String type;     // 아이콘 구분을 위해 (예: EMAIL, PAYMENT, NOTICE)
    private String content;  // 알림 내용
    private LocalDateTime createdAt;
}
