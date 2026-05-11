package com.bu.jichulmate.dto.user;

import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDate;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
public class UserUpdateRequest {

    // MY-01: 아이디 변경 추가
    @Size(min = 4, max = 20, message = "아이디는 4~20자여야 합니다.")
    private String loginId;

    @NotBlank(message = "닉네임을 입력해주세요.")
    @Size(min = 2, max = 5, message = "닉네임은 2~5자여야 합니다.")
    private String nickname;

    @Email(message = "올바른 이메일 형식이 아닙니다.")
    @NotBlank(message = "이메일을 입력해주세요.")
    private String email;

    private String currentPassword;

    @Size(min = 8, message = "비밀번호는 최소 8자 이상이어야 합니다.")
    private String newPassword;

    private String confirmPassword;

    @Pattern(regexp = "^(M|F)?$", message = "성별 값이 올바르지 않습니다.")
    private String gender;

    private LocalDate birthDate;
}