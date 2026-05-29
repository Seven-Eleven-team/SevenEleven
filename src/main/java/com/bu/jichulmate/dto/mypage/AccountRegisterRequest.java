package com.bu.jichulmate.dto.mypage;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AccountRegisterRequest {

    @NotBlank(message = "은행을 선택해주세요.")
    private String bankName;

    @NotBlank(message = "계좌번호를 입력해주세요.")
    @Pattern(regexp = "^[0-9\\-]{10,30}$", message = "올바른 계좌번호 형식이 아닙니다.")
    private String accountNumber;

    @Builder.Default
    private boolean isPrimary = false;
}