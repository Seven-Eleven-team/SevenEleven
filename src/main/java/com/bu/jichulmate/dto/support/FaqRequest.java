package com.bu.jichulmate.dto.support;

public class FaqRequest {
    private String question;
    private String answer;
    private Integer sortOrder;

    public String getQuestion() { return question; }
    public String getAnswer() { return answer; }
    public Integer getSortOrder() { return sortOrder; }
}