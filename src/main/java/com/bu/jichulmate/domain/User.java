package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "USERS")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "userSeq")
    @SequenceGenerator(
            name = "userSeq",
            sequenceName = "SEQ_USERS",
            allocationSize = 1
    )
    @Column(name = "USER_ID")
    private Long userId;

    // 이메일을 LOGIN_ID로 저장
    @Column(name = "LOGIN_ID", nullable = false, unique = true)
    private String loginId;

    @Column(name = "NICKNAME", nullable = false)
    private String nickname;

    @Column(name = "PASSWORD", nullable = false)
    private String password;

    @Column(name = "GENDER")
    private String gender;

    @Column(name = "BIRTH_DATE")
    private LocalDate birthDate;

    @Column(name = "MENTOR_TONE")
    private String mentorTone = "MILD";

    @Column(name = "ROLE")
    private String role = "USER";
}