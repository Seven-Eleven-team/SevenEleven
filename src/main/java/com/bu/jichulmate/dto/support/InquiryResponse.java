package com.bu.jichulmate.dto.support;

import lombok.Data;
import java.time.LocalDateTime;

@Data // ★ 이게 있어야 빨간 줄이 사라집니다!
public class InquiryResponse {
    private Long id;
    private String title;
    private String content;
    private String status;
    private LocalDateTime createdAt;
}