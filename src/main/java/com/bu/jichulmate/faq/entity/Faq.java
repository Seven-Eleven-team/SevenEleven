package com.bu.jichulmate.faq.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "FAQS")
public class Faq {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "faqs_seq")
    @SequenceGenerator(name = "faqs_seq", sequenceName = "FAQS_SEQ", allocationSize = 1)
    @Column(name = "FAQ_ID")
    private Long faqId;

    @Column(name = "CATEGORY", nullable = false)
    private String category;

    @Column(name = "QUESTION", nullable = false)
    private String question;

    @Column(name = "ANSWER", nullable = false)
    private String answer;

    @Column(name = "SORT_ORDER", nullable = false)
    private Integer sortOrder;

    @Column(name = "IS_ACTIVE", nullable = false, length = 1)
    private String isActive;

    @Column(name = "CREATED_AT", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
        if (this.isActive == null) this.isActive = "Y";
        if (this.sortOrder == null) this.sortOrder = 1;
    }

    public void update(String category, String question, String answer, Integer sortOrder, String isActive) {
        this.category = category;
        this.question = question;
        this.answer = answer;
        this.sortOrder = sortOrder;
        this.isActive = isActive;
    }

    public Long getFaqId() { return faqId; }
    public String getCategory() { return category; }
    public String getQuestion() { return question; }
    public String getAnswer() { return answer; }
    public Integer getSortOrder() { return sortOrder; }
    public String getIsActive() { return isActive; }
    public LocalDateTime getCreatedAt() { return createdAt; }
}