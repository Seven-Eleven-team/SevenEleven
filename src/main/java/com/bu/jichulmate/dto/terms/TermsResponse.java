package com.bu.jichulmate.dto.terms;

import com.bu.jichulmate.domain.Terms;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class TermsResponse {

    private Long termId;
    private String termType;
    private String title;
    private String version;
    private String content;
    private boolean required;
    private LocalDateTime applyDate;
    private int displayOrder;

    public static TermsResponse from(Terms terms) {
        return TermsResponse.builder()
                .termId(terms.getTermId())
                .termType(terms.getTermType().name())
                .title(terms.getTermType().getTitle())
                .version(terms.getVersion())
                .content(terms.getContent())
                .required(terms.required())
                .applyDate(terms.getApplyDate())
                .displayOrder(terms.getTermType().getDisplayOrder())
                .build();
    }
}
