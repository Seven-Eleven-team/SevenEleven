package com.bu.jichulmate.dto.admin;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PartyApprovalRequest {
    private boolean approved;
    private String rejectReason; // 변수명 통일
}