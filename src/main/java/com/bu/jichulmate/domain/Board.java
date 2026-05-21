package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "BOARDS")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Board {

    /*
     * 실제 DB에서 ID 컬럼이 NOT NULL로 존재하므로,
     * Java 코드에서 사용하는 게시글 번호 boardId를 ID 컬럼에 매핑한다.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_boards_gen")
    @SequenceGenerator(
            name = "seq_boards_gen",
            sequenceName = "SEQ_BOARDS",
            allocationSize = 1
    )
    @Column(name = "ID")
    private Long boardId;

    /*
     * 실제 DB에 BOARD_ID 컬럼도 NOT NULL로 존재하는 상태이므로,
     * ID와 같은 값을 BOARD_ID에도 같이 넣기 위한 보조 필드다.
     *
     * Controller, Service, Repository에서는 이 필드를 직접 사용하지 않고,
     * 기존처럼 boardId만 사용하면 된다.
     */
    @Column(name = "BOARD_ID", nullable = false, updatable = false)
    private Long dbBoardId;

    @Column(name = "USER_ID", nullable = false)
    private Long userId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", insertable = false, updatable = false)
    private User user;

    @Column(name = "BOARD_TYPE", nullable = false, length = 30)
    private String boardType;

    @Column(name = "TITLE", nullable = false, length = 150)
    private String title;

    @Column(name = "CONTENT", nullable = false, length = 4000)
    private String content;

    @Builder.Default
    @Column(name = "VIEWS_COUNT", nullable = false)
    private Long viewsCount = 0L;

    @Builder.Default
    @Column(name = "LIKES_COUNT", nullable = false)
    private Long likesCount = 0L;

    /*
     * 기존 게시판 로직에서 실제로 사용하는 삭제 여부 컬럼이다.
     * CommunityBoardRepository의 조회 조건도 이 필드를 기준으로 동작한다.
     */
    @Builder.Default
    @Column(name = "IS_DELETED", nullable = false, length = 1)
    private String isDeleted = "N";

    /*
     * 실제 DB에 DELETED 컬럼이 NOT NULL로 존재하는 경우를 위한 호환 필드다.
     * 현재 로직은 IS_DELETED를 기준으로 사용하되,
     * DB 저장 시 DELETED에도 기본값을 넣어 ORA-01400을 방지한다.
     *
     * 0 = 삭제 아님
     * 1 = 삭제됨
     */
    @Builder.Default
    @Column(name = "DELETED", nullable = false)
    private Integer deleted = 0;

    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "UPDATED_AT")
    private LocalDateTime updatedAt;

    @PrePersist
    public void prePersist() {
        syncBoardColumns();
        syncDeletedColumns();

        LocalDateTime now = LocalDateTime.now();

        if (createdAt == null) {
            createdAt = now;
        }

        if (updatedAt == null) {
            updatedAt = now;
        }

        if (viewsCount == null) {
            viewsCount = 0L;
        }

        if (likesCount == null) {
            likesCount = 0L;
        }
    }

    @PreUpdate
    public void preUpdate() {
        syncBoardColumns();
        syncDeletedColumns();

        updatedAt = LocalDateTime.now();

        if (viewsCount == null) {
            viewsCount = 0L;
        }

        if (likesCount == null) {
            likesCount = 0L;
        }
    }

    /*
     * Hibernate가 SEQ_BOARDS.NEXTVAL로 boardId 값을 만든 뒤,
     * 같은 값을 BOARD_ID 컬럼에도 넣도록 맞춘다.
     */
    private void syncBoardColumns() {
        if (boardId != null && dbBoardId == null) {
            dbBoardId = boardId;
        }
    }

    /*
     * 기존 로직의 IS_DELETED 값과 DB 호환용 DELETED 값을 같이 맞춘다.
     */
    private void syncDeletedColumns() {
        if (isDeleted == null || isDeleted.isBlank()) {
            isDeleted = "N";
        }

        if ("Y".equalsIgnoreCase(isDeleted)) {
            deleted = 1;
        } else {
            isDeleted = "N";
            deleted = 0;
        }
    }

    public boolean isOwner(Long loginUserId) {
        return loginUserId != null && userId != null && userId.equals(loginUserId);
    }

    public String getCreatedAtText() {
        if (createdAt == null) {
            return "";
        }

        return createdAt.format(DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm"));
    }

    public String getWriterName() {
        if (user == null || user.getNickname() == null || user.getNickname().isBlank()) {
            if (userId == null) {
                return "알 수 없음";
            }

            return "사용자 " + userId;
        }

        return user.getNickname();
    }
}