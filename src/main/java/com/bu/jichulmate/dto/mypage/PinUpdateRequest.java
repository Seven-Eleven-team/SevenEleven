package com.bu.jichulmate.dto.mypage;

import jakarta.validation.constraints.*;
import lombok.*;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
public class PinUpdateRequest {

    @NotBlank(message = "현재 PIN을 입력해주세요.")
    private String currentPin;

    @NotBlank(message = "새 PIN을 입력해주세요.")
    @Pattern(regexp = "^[0-9]{4,6}$", message = "PIN은 4~6자리 숫자여야 합니다.")
    private String newPin;

    @NotBlank(message = "PIN 확인을 입력해주세요.")
    private String confirmPin;
}