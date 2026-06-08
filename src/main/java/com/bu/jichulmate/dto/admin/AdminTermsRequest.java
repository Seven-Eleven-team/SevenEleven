package com.bu.jichulmate.dto.admin;

import com.bu.jichulmate.domain.TermsType;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AdminTermsRequest {
    private String termType;   // 약관 종류 (예: SERVICE, PRIVACY)
    private String version;    // 버전 (예: "v1.1")
    private String content;    // 약관 내용
    private String isRequired; // 필수 여부 ("Y" 또는 "N")
}