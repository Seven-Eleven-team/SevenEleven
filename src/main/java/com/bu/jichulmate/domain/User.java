package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "USERS")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "userSeq")
    @SequenceGenerator(name = "userSeq", sequenceName = "SEQ_USERS", allocationSize = 1)
    @Column(name = "USER_ID")
    private Long userId;

    @Column(name = "LOGIN_ID", nullable = false, unique = true)
    private String loginId;

    @Column(name = "EMAIL", nullable = false)
    private String email;

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

    @Column(name = "PROFILE_IMAGE")
    private String profileImage;

    @Column(name = "EMAIL_NOTIFY")
    private boolean emailNotify = true;

    @Column(name = "PIN")
    private String pin;
}
