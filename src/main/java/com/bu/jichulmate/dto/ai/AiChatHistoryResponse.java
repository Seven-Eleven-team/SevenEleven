package com.bu.jichulmate.dto.ai;

import com.bu.jichulmate.domain.AiChatLog;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AiChatHistoryResponse {

    private Long chatId;
    private String senderType; // "USER" 또는 "MENTOR"
    private String message;
    private LocalDateTime chatDate;

    /**
     * Entity 객체를 DTO 구조로 안전하게 변환하기 위한 정적 팩토리 메서드
     */
    public static AiChatHistoryResponse fromEntity(AiChatLog chatLog) {
        return AiChatHistoryResponse.builder()
                .chatId(chatLog.getChatId())
                .senderType(chatLog.getSenderType())
                .message(chatLog.getMessage())
                .chatDate(chatLog.getChatDate())
                .build();
    }
}