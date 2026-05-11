package com.bu.jichulmate.dto.support;

import com.bu.jichulmate.domain.Faq;

public class FaqResponse {

    private Long faqId;
    private String category;
    private String question;
    private String answer;
    private Integer sortOrder;

    public FaqResponse(Faq faq) {
        this.faqId = faq.getFaqId();
        this.category = faq.getCategory();
        this.question = faq.getQuestion();
        this.answer = faq.getAnswer();
        this.sortOrder = faq.getSortOrder();
    }

    public Long getFaqId() { return faqId; }
    public String getCategory() { return category; }
    public String getQuestion() { return question; }
    public String getAnswer() { return answer; }
    public Integer getSortOrder() { return sortOrder; }
}