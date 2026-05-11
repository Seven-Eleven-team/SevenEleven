package com.bu.jichulmate.dto.expense;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Getter
@NoArgsConstructor
public class ExpenseUpdateRequest {

    @NotNull(message = "카테고리는 필수 선택입니다.")
    private Long categoryId;

    @NotNull(message = "금액은 필수 입력입니다.")
    @Min(value = 0, message = "금액은 0원 이상이어야 합니다.")
    private Long amount;

    @NotNull(message = "지출 날짜는 필수 선택입니다.")
    private LocalDate expenseDate;

    private String isFixed;
}