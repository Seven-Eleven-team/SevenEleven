package com.bu.jichulmate.dto.support;

public class FaqRequest {

    private String category;
    private String question;
    private String answer;
    private Integer sortOrder;
    private String isActive;

    public String getCategory() { return category; }
    public String getQuestion() { return question; }
    public String getAnswer() { return answer; }
    public Integer getSortOrder() { return sortOrder; }
    public String getIsActive() { return isActive; }
}