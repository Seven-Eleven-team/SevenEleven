package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "SAVING_GOALS")
@Getter
@Setter
@NoArgsConstructor
public class SavingGoal {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "goal_seq")
    @SequenceGenerator(name = "goal_seq", sequenceName = "SEQ_SAVING_GOALS", allocationSize = 1)
    @Column(name = "GOAL_ID")
    private Long id;

    @Column(name = "USER_ID", nullable = false)
    private Long userId;

    @Column(name = "ITEM_NAME", nullable = false)
    private String itemName;

    @Column(name = "ITEM_PRICE", nullable = false)
    private Long itemPrice;

    @Column(name = "SAVED_AMOUNT", nullable = false)
    private Long savedAmount = 0L;

    @Column(name = "STATUS")
    private String status = "ING"; // 예전 DB 버전에 맞춤
}