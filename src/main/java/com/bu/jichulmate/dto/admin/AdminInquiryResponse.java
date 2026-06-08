package com.bu.jichulmate.dto.admin;

import com.bu.jichulmate.domain.Inquiry;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class AdminInquiryResponse {
    private Long inquiryId;
    private Long authorId;         // 작성자 번호 (User 객체 대신 userId 숫자를 그대로 가져옵니다)
    private String title;          // 문의 제목
    private String content;        // 문의 내용
    private String status;         // 상태 (WAITING, ANSWERED 등)
    private String answerContent;  // 관리자 답변 내용 (변수명 일치)
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Entity -> DTO 변환
    public static AdminInquiryResponse fromEntity(Inquiry inquiry) {
        return AdminInquiryResponse.builder()
                .inquiryId(inquiry.getId())
                .authorId(inquiry.getUserId())             // userId 매핑
                .title(inquiry.getTitle())
                .content(inquiry.getContent())
                .status(inquiry.getStatus())
                .answerContent(inquiry.getAnswerContent()) // answerContent 매핑
                .createdAt(inquiry.getCreatedAt())
                .updatedAt(inquiry.getUpdatedAt())
                .build();
    }
}