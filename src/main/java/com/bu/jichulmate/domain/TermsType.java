package com.bu.jichulmate.domain;

import java.util.Arrays;

public enum TermsType {

    SERVICE("지출메이트 서비스 이용약관", true, 1),
    PRIVACY("개인정보 수집 및 이용 동의", true, 2),
    POLICY("AI 분석 및 구독 파티 면책 정책 동의", true, 3),
    MARKETING("마케팅 정보 수신 동의", false, 4);

    private final String title;
    private final boolean requiredByDefault;
    private final int displayOrder;

    TermsType(String title, boolean requiredByDefault, int displayOrder) {
        this.title = title;
        this.requiredByDefault = requiredByDefault;
        this.displayOrder = displayOrder;
    }

    public String getTitle() {
        return title;
    }

    public boolean isRequiredByDefault() {
        return requiredByDefault;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public static TermsType from(String value) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException("약관 종류가 비어 있습니다.");
        }

        return Arrays.stream(values())
                .filter(type -> type.name().equalsIgnoreCase(value.trim()))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("지원하지 않는 약관 종류입니다: " + value));
    }
}
