package com.bu.jichulmate.dto.support;

import com.bu.jichulmate.domain.Faq;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FaqResponse {

    private Long faqId;
    private String question;
    private String answer;
    private Integer sortOrder;

    // Faq 엔티티를 받아서 DTO로 변환
    public FaqResponse(Faq faq) {
        this.faqId = faq.getFaqId();
        this.question = faq.getQuestion();
        this.answer = faq.getAnswer();
        this.sortOrder = faq.getSortOrder();
    }
}