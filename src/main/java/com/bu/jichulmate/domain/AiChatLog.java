package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
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
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "aiChatLogSeq")
    @SequenceGenerator(name = "aiChatLogSeq", sequenceName = "SEQ_AI_CHAT_LOGS", allocationSize = 1)
    @Column(name = "CHAT_ID")
    private Long id;

    @Column(name = "USER_ID", nullable = false)
    private Long userId;

    @Column(name = "SENDER_TYPE", nullable = false)
    private String senderType; // "USER" 또는 "AI"

    @Lob
    @Column(name = "MESSAGE", nullable = false)
    private String message;

    @Column(name = "CHAT_DATE", nullable = false)
    private LocalDateTime chatDate;

    @PrePersist
    protected void onCreate() {
        if (this.chatDate == null) {
            this.chatDate = LocalDateTime.now();
        }
    }
}