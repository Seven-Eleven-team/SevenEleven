package com.bu.jichulmate.dto.admin;

import com.bu.jichulmate.domain.NotificationLog;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class NotificationLogResponse{
    private Long logId;
    private Long targetUserId; // 알림을 받은 유저의 번호
    private String type;       // 알림 타입 (예: PARTY, SYSTEM 등)
    private String content;    // 알림 내용 (엔티티에 맞춰 content로 변경)
    private String isSuccess;  // 발송 성공 여부 (예: Y/N)
    private String failReason; // 실패 사유 (성공 시 null)
    private LocalDateTime sentAt; // 발송 시간

    // Entity -> DTO 안전 변환
    public static NotificationLogResponse fromEntity(NotificationLog log) {
        return NotificationLogResponse.builder()
                .logId(log.getId())

                // User 객체 안에서 회원 번호(userId) 꺼내오기
                // (이전 회원 관리 코드에서 getUserId()를 쓰셨던 것을 기준으로 작성했습니다)
                .targetUserId(log.getUser() != null ? log.getUser().getUserId() : null)

                .type(log.getType())
                .content(log.getContent())
                .isSuccess(log.getIsSuccess())
                .failReason(log.getFailReason())
                .sentAt(log.getCreatedAt())
                .build();
    }
}