package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
@Setter
@Entity
@Getter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Table(name="inquiries")

public class Inquiry {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "inquiry_seq")
    @SequenceGenerator(name = "inquiry_seq", sequenceName = "inquiries_seq", allocationSize = 1)
    private Long id;

    private Long userId;
    private String title;
    private String content;
    private String status;

    @CreatedDate
    @Column(updatable = false)
    private LocalDateTime createdAt;
}
