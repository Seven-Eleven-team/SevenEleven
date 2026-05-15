package com.bu.jichulmate.dto.mypage;

import jakarta.validation.constraints.*;
import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class AccountUpdateRequest {
    @NotBlank(message = "은행명을 입력해주세요.")
    private String bankName;
    @NotBlank(message = "계좌번호를 입력해주세요.")
    @Pattern(regexp = "^[0-9\\-]{10,20}$", message = "올바른 계좌번호 형식이 아닙니다.")
    private String accountNumber;
    @NotBlank(message = "예금주를 입력해주세요.")
    private String accountHolder;
    private boolean primary = false;
}
