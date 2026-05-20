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

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_boards_gen")
    @SequenceGenerator(
            name = "seq_boards_gen",
            sequenceName = "SEQ_BOARDS",
            allocationSize = 1
    )
    @Column(name = "BOARD_ID")
    private Long boardId;

    @Column(name = "USER_ID", nullable = false)
    private Long userId;

    /*
     * 작성자 정보 조회용 관계 매핑.
     *
     * 실제 게시글 저장/수정 시에는 userId 필드가 USER_ID 컬럼을 담당한다.
     * user 필드는 작성자 정보를 화면에 보여줄 때 사용할 수 있도록 연결만 해둔다.
     *
     * insertable = false, updatable = false로 설정한 이유:
     * - USER_ID 컬럼을 userId 필드와 user 필드가 동시에 수정하려고 하면 JPA 매핑 충돌이 발생할 수 있음
     * - 실제 저장 기준은 userId 하나로 통일하고, user는 조회용 관계로만 사용
     */
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

    @Builder.Default
    @Column(name = "IS_DELETED", nullable = false, length = 1)
    private String isDeleted = "N";

    @Column(name = "CREATED_AT", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "UPDATED_AT")
    private LocalDateTime updatedAt;

    /*
     * INSERT 전에 기본값을 보정한다.
     *
     * DB에 DEFAULT 값이 있더라도 JPA에서 null을 넘기면 의도와 다르게 들어갈 수 있으므로,
     * Java Entity 단계에서도 기본값을 한 번 더 잡아준다.
     */
    @PrePersist
    public void prePersist() {
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

        if (isDeleted == null || isDeleted.isBlank()) {
            isDeleted = "N";
        }
    }

    /*
     * UPDATE 전에 수정 시간을 갱신한다.
     */
    @PreUpdate
    public void preUpdate() {
        updatedAt = LocalDateTime.now();
    }

    /*
     * 현재 로그인한 사용자가 이 게시글 작성자인지 확인한다.
     *
     * CommunityController, CommunityService에서 수정/삭제 권한 확인에 사용한다.
     */
    public boolean isOwner(Long loginUserId) {
        return loginUserId != null && userId != null && userId.equals(loginUserId);
    }

    /*
     * JSP에서 ${post.createdAtText} 형태로 출력하기 위한 날짜 포맷 메서드다.
     */
    public String getCreatedAtText() {
        if (createdAt == null) {
            return "";
        }

        return createdAt.format(DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm"));
    }

    public String getWriterName() {
        if (userId == null) {
            return "알 수 없음";
        }

        return "사용자 " + userId;
    }
}