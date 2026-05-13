package com.bu.jichulmate.dto.support;

import lombok.Data;

@Data // ★ 이게 있어야 SupportService에서 에러가 안 납니다!
public class InquiryCreateRequest {
    private String title;
    private String content;
}