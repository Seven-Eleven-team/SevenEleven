package com.bu.jichulmate.dto.support;

import com.bu.jichulmate.domain.Faq; // ★ 가장 중요한 임포트! (에러의 주범 해결)
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FaqResponse {

    private Long faqId;
    private String category;
    private String question;
    private String answer;
    private Integer sortOrder;

    // Faq 엔티티를 받아서 DTO로 변환해주는 똑똑한 생성자
    public FaqResponse(Faq faq) {
        this.faqId = faq.getFaqId();
        this.category = faq.getCategory();
        this.question = faq.getQuestion();
        this.answer = faq.getAnswer();
        this.sortOrder = faq.getSortOrder();
    }
}