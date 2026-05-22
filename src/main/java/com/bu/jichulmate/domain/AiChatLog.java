package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "AI_CHAT_LOGS")
public class AiChatLog {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_ai_chat_logs_gen")
    @SequenceGenerator(
            name = "seq_ai_chat_logs_gen",     // 다른 파일들처럼 _gen 접미사 규칙 통일!
            sequenceName = "seq_ai_chat_logs", // 실제 DB에 소문자로 생성된 시퀀스 이름 매핑
            allocationSize = 1
    )
    @Column(name = "chat_id")
    private Long chatId;

    // 비기능 요구사항에 따른 LAZY(지연 로딩) 전략 적용
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    // 유저와 멘토를 구분하기 위한 타입 (안전한 관리를 위해 Enum 활용 권장, 여기서는 테이블 규격에 맞춰 String 매핑)
    @Column(name = "SENDER_TYPE", nullable = false, length = 10)
    private String senderType; // "USER" 또는 "MENTOR"

    // Oracle CLOB 타입 매핑을 위한 설정
    @Lob
    @Column(name = "MESSAGE", nullable = false)
    private String message;

    // DEFAULT SYSDATE 규격에 맞추어 엔티티 생성 시 최신 시간이 자동 입력되도록 설정
    @CreationTimestamp
    @Column(name = "CHAT_DATE", nullable = false, updatable = false)
    private LocalDateTime chatDate;
}