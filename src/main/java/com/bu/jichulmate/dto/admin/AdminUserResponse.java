package com.bu.jichulmate.dto.admin;

import com.bu.jichulmate.domain.User;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;

@Getter
@Builder
public class AdminUserResponse {
    private Long userId;
    private String loginId;
    private String nickname;
    private String gender;
    private LocalDate birthDate;
    private String provider;

    private String is2faEnabled;
    private String mentorTone;

    private String role;
    private String accountStatus;
    private String isNotiEnabled;

    // User 엔티티를 안전한 DTO로 변환
    public static AdminUserResponse fromEntity(User user) {
        return AdminUserResponse.builder()
                .userId(user.getUserId())
                .loginId(user.getLoginId())
                .nickname(user.getNickname())
                .gender(user.getGender())
                .birthDate(user.getBirthDate())
                .provider(user.getProvider())


                .is2faEnabled(user.getIs2faEnabled())
                .mentorTone(user.getMentorTone())

                .role(user.getRole())
                .accountStatus(user.getAccountStatus())
                .isNotiEnabled(user.getIsNotiEnabled())
                .build();
    }
}