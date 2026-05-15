package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "PARTY_POSTS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class PartyPost {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "party_seq")
    @SequenceGenerator(name = "party_seq", sequenceName = "PARTY_SEQ", allocationSize = 1)
    private Long id;

    // ★ sellerId(Long) 대신 User 객체로 연결!
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "host_user_id", nullable = false)
    private User hostUser;

    @Column(nullable = false)
    private String ottCategory;

    @Column(nullable = false)
    private String shareId;

    @Column(nullable = false)
    private String sharePassword;

    @Column(nullable = false)
    private Integer monthlyPrice;

    @Lob
    @Column(length = 4000)
    private String description;

    @Column(nullable = false)
    private String status = "RECRUITING";

    @Column(nullable = false)
    private boolean deleted = false;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
}