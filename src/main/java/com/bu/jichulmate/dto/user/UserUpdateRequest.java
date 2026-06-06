package com.bu.jichulmate.dto.user;

import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDate;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class UserUpdateRequest {

    // [수정] @NotBlank 제거 (세션에서 ID를 가져오므로 필수가 아님)
    private String loginId;

    @Email(message = "올바른 이메일 형식이 아닙니다.")
    private String newEmail;

    // null일 때는 통과, 빈 문자열("")일 때만 검사함 (JS에서 null 처리 필요)
    @Size(min = 2, max = 5, message = "닉네임은 2~5자여야 합니다.")
    private String nickname;

    @NotBlank(message = "현재 비밀번호를 입력해주세요.")
    private String currentPassword;

    // [수정] 최소 길이를 8자 -> 4자로 변경
    @Size(min = 4, message = "비밀번호는 최소 4자 이상이어야 합니다.")
    private String newPassword;

    private String confirmPassword;

    private String gender;
    private LocalDate birthDate;

    @NotBlank(message = "AI 멘토 성향을 선택해주세요.")
    private String mentorTone;
}
