package com.bu.jichulmate.dto.admin;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserStatusUpdateRequest {
    private String status; // 변경할 상태값 (ACTIVE, SUSPENDED, WITHDRAWN 등)
}