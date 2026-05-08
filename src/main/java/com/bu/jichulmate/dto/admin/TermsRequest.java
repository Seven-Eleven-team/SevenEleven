package com.bu.jichulmate.dto.admin;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class TermsRequest {

    private String termType;

    private String version;

    private String content;

    private String isRequired;

    private LocalDateTime applyDate;
}
