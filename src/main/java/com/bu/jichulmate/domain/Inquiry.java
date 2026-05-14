package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "INQUIRIES")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Inquiry {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_inquiries_gen")
    @SequenceGenerator(name = "seq_inquiries_gen", sequenceName = "SEQ_INQUIRIES", allocationSize = 1)
    @Column(name = "INQUIRY_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    @Column(name = "TITLE", nullable = false, length = 150)
    private String title;

    @Column(name = "CONTENT", nullable = false, length = 4000)
    private String content;

    @Column(name = "ANSWER_CONTENT", length = 4000) // ★ 관리자 답변용
    private String answerContent;

    @Builder.Default
    @Column(name = "STATUS", nullable = false, length = 20)
    private String status = "WAITING";

    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "UPDATED_AT")
    private LocalDateTime updatedAt;
}