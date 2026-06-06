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
    private String role;
    private String accountStatus;
    private String isNotiEnabled;

    // User 엔티티를 안전한 DTO로 변환하는 마법의 메서드 (비밀번호 원천 차단!)
    public static AdminUserResponse fromEntity(User user) {
        return AdminUserResponse.builder()
                .userId(user.getUserId())
                .loginId(user.getLoginId())
                .nickname(user.getNickname())
                .gender(user.getGender())
                .birthDate(user.getBirthDate())
                .provider(user.getProvider())
                .role(user.getRole())
                .accountStatus(user.getAccountStatus())
                .isNotiEnabled(user.getIsNotiEnabled())
                .build();
    }
}