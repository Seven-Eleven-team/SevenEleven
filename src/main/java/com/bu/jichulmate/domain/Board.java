package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "BOARDS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Board {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_boards_gen")
    @SequenceGenerator(name = "seq_boards_gen", sequenceName = "SEQ_BOARDS", allocationSize = 1)
    @Column(name = "BOARD_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    @Column(name = "BOARD_TYPE", nullable = false, length = 30)
    private String boardType;

    @Column(name = "TITLE", nullable = false, length = 150)
    private String title;

    @Column(name = "CONTENT", nullable = false, length = 4000)
    private String content;

    @Builder.Default
    @Column(name = "VIEWS_COUNT", nullable = false)
    private Integer viewsCount = 0;

    @Builder.Default
    @Column(name = "LIKES_COUNT", nullable = false)
    private Integer likesCount = 0;

    @Builder.Default
    @Column(name = "IS_DELETED", nullable = false, length = 1)
    private String isDeleted = "N";

    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "UPDATED_AT")
    private LocalDateTime updatedAt;
}
