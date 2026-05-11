package com.bu.jichulmate.dto.support;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class InquiryResponse {

    private Long id;
    private String title;
    private String content;
    private String status;
    private LocalDateTime createdAt;
}