package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name = "INQUIRIES")
public class Inquiry {

    // ===============================
    // PK (시퀀스 기반)
    // ===============================
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_INQUIRIES")
    @SequenceGenerator(
            name = "SEQ_INQUIRIES",           // 반드시 동일하게
            sequenceName = "SEQ_INQUIRIES",   // DB 시퀀스 이름
            allocationSize = 1
    )
    @Column(name = "INQUIRY_ID")
    private Long id;

    // ===============================
    // 사용자 ID
    // ===============================
    @Column(name = "USER_ID", nullable = false)
    private Long userId;

    // ===============================
    // 제목
    // ===============================
    @Column(name = "TITLE", nullable = false)
    private String title;

    // ===============================
    // 내용
    // ===============================
    @Column(name = "CONTENT", nullable = false)
    private String content;

    // ===============================
    // 상태 (WAITING / ANSWERED)
    // ===============================
    @Column(name = "STATUS")
    private String status;

    // ===============================
    // 생성일 (자동 처리)
    // ===============================
    @CreatedDate
    @Column(name = "CREATED_AT", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    // ===============================
    // 관리자 답변
    // ===============================
    @Column(name = "ANSWER_CONTENT")
    private String answerContent;

    // ===============================
    // 수정일
    // ===============================
    @Column(name = "UPDATED_AT")
    private LocalDateTime updatedAt;
}