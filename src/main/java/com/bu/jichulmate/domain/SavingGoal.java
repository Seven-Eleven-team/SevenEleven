package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "SAVING_GOALS")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class SavingGoal {


    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "goal_seq")
    @SequenceGenerator(name = "goal_seq", sequenceName = "GOAL_SEQ", allocationSize = 1)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false)
    private String goalName; // getGoalName() 매칭

    @Column(nullable = false)
    private long targetAmount; // getTargetAmount() 매칭

    @Column(nullable = false)
    private long savedAmount; // getSavedAmount() 매칭

    @Column(nullable = false)
    private boolean deleted = false;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
}
