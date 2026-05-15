package com.bu.jichulmate.dto.user;

import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDate;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
public class UserUpdateRequest {

    // 아이디이자 이메일 역할을 하는 필드
    @NotBlank(message = "이메일(아이디)을 입력해주세요.")
    @Email(message = "올바른 이메일 형식이 아닙니다.")
    @Size(min = 4, max = 50, message = "아이디는 4~50자여야 합니다.")
    private String loginId;

    @NotBlank(message = "닉네임을 입력해주세요.")
    @Size(min = 2, max = 5, message = "닉네임은 2~5자여야 합니다.")
    private String nickname;

    private String currentPassword;

    @Size(min = 8, message = "비밀번호는 최소 8자 이상이어야 합니다.")
    private String newPassword;

    private String confirmPassword;

    @Pattern(regexp = "^(M|F)?$", message = "성별 값이 올바르지 않습니다.")
    private String gender;

    private LocalDate birthDate;
}