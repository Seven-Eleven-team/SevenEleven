package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "PARTY_POSTS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class PartyPost {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_party_posts_gen")
    @SequenceGenerator(name = "seq_party_posts_gen", sequenceName = "SEQ_PARTY_POSTS", allocationSize = 1)
    @Column(name = "PARTY_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SELLER_ID", nullable = false) // ★ PartySeller 테이블 참조로 변경
    private PartySeller seller;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SERVICE_ID", nullable = false) // ★ 마스터 테이블 참조로 변경
    private SubscriptionMaster service;

    @Column(name = "SHARE_ID", nullable = false, length = 100)
    private String shareId;

    @Column(name = "SHARE_PASSWORD", nullable = false, length = 255)
    private String sharePassword;

    @Column(name = "MONTHLY_PRICE", nullable = false)
    private Integer monthlyPrice;

    @Builder.Default
    @Column(name = "TOTAL_SLOTS", nullable = false)
    private Integer totalSlots = 4;

    @Builder.Default
    @Column(name = "OCCUPIED_SLOTS", nullable = false)
    private Integer occupiedSlots = 0;

    @Builder.Default
    @Column(name = "STATUS", nullable = false, length = 20)
    private String status = "WAITING"; // WAITING, APPROVED, REJECTED, FULL

    @Column(name = "REJECT_REASON", length = 500)
    private String rejectReason;

    @Lob
    @Column(name = "DESCRIPTION")
    private String description;

    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "UPDATED_AT")
    private LocalDateTime updatedAt;
}
