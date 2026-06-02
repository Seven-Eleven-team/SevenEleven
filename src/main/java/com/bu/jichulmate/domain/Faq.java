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

    // [수정] nullable = false 제거하여 ORA-01758 해결
    @Column(name = "CATEGORY", length = 50)
    private String category;

    @Column(name = "QUESTION", nullable = false, length = 200)
    private String question;

    @Column(name = "ANSWER", nullable = false, length = 4000)
    private String answer;

    @Column(name = "SORT_ORDER") // nullable = false 제거
    private Integer sortOrder;

    // [수정] nullable = false 제거하여 ORA-01758 해결
    @Column(name = "IS_ACTIVE", length = 1)
    private String isActive;

    @Column(name = "CREATED_AT", updatable = false)
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
}
