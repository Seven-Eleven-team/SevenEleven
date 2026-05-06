package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Setter
@Getter
@NoArgsConstructor
@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name = "INQUIRIES")
public class Inquiry {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "inquiry_seq")
    @SequenceGenerator(
            name = "inquiry_seq",
            sequenceName = "SEQ_INQUIRIES",
            allocationSize = 1
    )
    @Column(name = "INQUIRY_ID") // 🔥 PK 매핑
    private Long id;

    @Column(name = "USER_ID")
    private Long userId;

    @Column(name = "TITLE")
    private String title;

    @Column(name = "CONTENT")
    private String content;

    @Column(name = "STATUS")
    private String status;

    @CreatedDate
    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;

    // 🔽 선택 (나중 확장용 - 지금 안 써도 OK)
    @Column(name = "ANSWER_CONTENT")
    private String answerContent;

    @Column(name = "UPDATED_AT")
    private LocalDateTime updatedAt;
}