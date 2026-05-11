package com.bu.jichulmate.util;

import com.bu.jichulmate.exception.ErrorCode;
import com.bu.jichulmate.exception.UnauthorizedException;
import jakarta.servlet.http.HttpSession;

public class SessionUtils {

    private static final String SESSION_USER_ID   = "LOGIN_USER_ID";
    private static final String SESSION_USER_ROLE = "LOGIN_USER_ROLE";

    private SessionUtils() {}

    /** 세션에서 로그인 사용자 PK 반환 (없으면 예외) */
    public static Long getLoginUserId(HttpSession session) {
        Object userId = session.getAttribute(SESSION_USER_ID);
        if (userId == null) {
            throw new UnauthorizedException(ErrorCode.LOGIN_REQUIRED);
        }
        return (Long) userId;
    }

    /** 로그인 여부 확인 */
    public static boolean isLoggedIn(HttpSession session) {
        return session.getAttribute(SESSION_USER_ID) != null;
    }

    /** 관리자 여부 확인 */
    public static boolean isAdmin(HttpSession session) {
        return "ADMIN".equals(session.getAttribute(SESSION_USER_ROLE));
    }

    /** 로그인 세션 저장 */
    public static void setLoginUser(HttpSession session, Long userId, String role) {
        session.setAttribute(SESSION_USER_ID, userId);
        session.setAttribute(SESSION_USER_ROLE, role);
    }

    /** 세션 초기화 */
    public static void clearSession(HttpSession session) {
        session.invalidate();
    }
}
