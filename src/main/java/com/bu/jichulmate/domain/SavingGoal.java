package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "SAVING_GOALS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class SavingGoal {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_saving_goals_gen")
    @SequenceGenerator(name = "seq_saving_goals_gen", sequenceName = "SEQ_SAVING_GOALS", allocationSize = 1)
    @Column(name = "GOAL_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    @Column(name = "ITEM_NAME", nullable = false, length = 100)
    private String goalName;

    @Column(name = "ITEM_PRICE", nullable = false)
    private long targetAmount;

    @Builder.Default
    @Column(name = "SAVED_AMOUNT", nullable = false)
    private long savedAmount = 0;

    @Builder.Default
    @Column(name = "STATUS", nullable = false, length = 20)
    private String status = "IN_PROGRESS";
}