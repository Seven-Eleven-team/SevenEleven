package com.bu.jichulmate.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public enum ErrorCode {

    INVALID_INPUT(HttpStatus.BAD_REQUEST, "E001", "입력값이 유효하지 않습니다."),
    ACCESS_DENIED(HttpStatus.FORBIDDEN, "E002", "접근 권한이 없습니다."),
    INTERNAL_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "E003", "서버 내부 오류가 발생했습니다."),

    LOGIN_REQUIRED(HttpStatus.UNAUTHORIZED, "A001", "로그인이 필요합니다."),
    INVALID_CREDENTIALS(HttpStatus.UNAUTHORIZED, "A002", "아이디 또는 비밀번호가 일치하지 않습니다."),

    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "U001", "존재하지 않는 회원입니다."),
    DUPLICATE_LOGIN_ID(HttpStatus.CONFLICT, "U002", "이미 사용 중인 아이디입니다."),
    DUPLICATE_NICKNAME(HttpStatus.CONFLICT, "U003", "이미 사용 중인 닉네임입니다."),
    PASSWORD_MISMATCH(HttpStatus.BAD_REQUEST, "U004", "비밀번호가 일치하지 않습니다."),

    ACCOUNT_NOT_FOUND(HttpStatus.NOT_FOUND, "AC001", "존재하지 않는 계좌입니다."),
    ACCOUNT_LIMIT_EXCEEDED(HttpStatus.BAD_REQUEST, "AC002", "계좌는 최대 5개까지 등록할 수 있습니다."),
    ACCOUNT_DUPLICATE(HttpStatus.CONFLICT, "AC003", "이미 존재하거나, 유효하지 않는 계좌입니다."),
    ACCOUNT_MIN_REQUIRED(HttpStatus.BAD_REQUEST, "AC004", "최소 1개 계좌가 필요합니다."),

    SUBSCRIPTION_NOT_FOUND(HttpStatus.NOT_FOUND, "S001", "존재하지 않는 구독입니다."),
    PARTY_NOT_FOUND(HttpStatus.NOT_FOUND, "P001", "존재하지 않는 파티입니다."),
    BOARD_NOT_FOUND(HttpStatus.NOT_FOUND, "B001", "존재하지 않는 게시글입니다."),
    INQUIRY_NOT_FOUND(HttpStatus.NOT_FOUND, "IN001", "존재하지 않는 문의입니다."),
    REPORT_NOT_FOUND(HttpStatus.NOT_FOUND, "R001", "존재하지 않는 신고입니다."),
    NOTIFICATION_NOT_FOUND(HttpStatus.NOT_FOUND, "N001", "존재하지 않는 알림입니다."),
    GOAL_NOT_FOUND(HttpStatus.NOT_FOUND, "G001", "존재하지 않는 목표입니다.");

    private final HttpStatus httpStatus;
    private final String code;
    private final String message;

    ErrorCode(HttpStatus httpStatus, String code, String message) {
        this.httpStatus = httpStatus;
        this.code = code;
        this.message = message;
    }
}
