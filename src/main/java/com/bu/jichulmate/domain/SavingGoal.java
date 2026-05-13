package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "SAVING_GOALS") // 설계서 4번 테이블
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class SavingGoal {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "goal_seq")
    @SequenceGenerator(name = "goal_seq", sequenceName = "GOAL_SEQ", allocationSize = 1)
    @Column(name = "GOAL_ID") // PK
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false) // FK
    private User user;

    @Column(name = "ITEM_NAME", nullable = false, length = 100)
    private String goalName;

    @Column(name = "ITEM_PRICE", nullable = false)
    private long targetAmount;

    @Column(name = "SAVED_AMOUNT", nullable = false)
    private long savedAmount;

    @Column(name = "STATUS", nullable = false, length = 20)
    private String status = "IN_PROGRESS"; // 설계서에 명시된 달성 상태

    // ★ 에러의 원인이었던 deleted와 createdAt 변수는 DB에 없으므로 완전히 삭제했습니다!
}