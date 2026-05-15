package com.bu.jichulmate.dto.mypage;

import jakarta.validation.constraints.*;
import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class AccountRegisterRequest {

    @NotBlank(message = "은행명을 입력해주세요.")
    private String bankName;

    @NotBlank(message = "계좌번호를 입력해주세요.")
    @Pattern(regexp = "^[0-9\\-]{10,20}$", message = "올바른 계좌번호 형식이 아닙니다.")
    private String accountNumber;

    // ★ DB에서 accountHolder(예금주) 컬럼이 삭제되었으므로 제거했습니다!

    private boolean isPrimary = false; // 프론트엔드 요청용 (true/false)
}