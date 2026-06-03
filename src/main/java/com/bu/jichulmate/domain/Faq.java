package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "FAQS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Faq {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_faqs_gen")
    @SequenceGenerator(name = "seq_faqs_gen", sequenceName = "SEQ_FAQS", allocationSize = 1)
    @Column(name = "FAQ_ID")
    private Long faqId;

    @Column(name = "QUESTION", nullable = false, length = 200)
    private String question;

    @Column(name = "ANSWER", nullable = false, length = 4000)
    private String answer;

    @Column(name = "SORT_ORDER", nullable = false)
    private Integer sortOrder;


    @Column(name = "CREATED_AT", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
        if (this.sortOrder == null) this.sortOrder = 1;
    }

    // ★ FaqService의 에러를 해결해주는 핵심 비즈니스 로직 메서드!
    // 이것은 DB 컬럼이 아니라 자바 객체 내부의 데이터를 변경하는 기능입니다.
    public void update(String question, String answer, Integer sortOrder) {
        this.question = question;
        this.answer = answer;
        this.sortOrder = sortOrder;
    }
}