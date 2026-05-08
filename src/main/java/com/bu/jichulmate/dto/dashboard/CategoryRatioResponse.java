package com.bu.jichulmate.dto.dashboard;

import lombok.Data;

@Data
public class CategoryRatioResponse {
    private String categoryName;
    private long totalAmount;
    private int percentage;
}