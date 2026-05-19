package com.bu.jichulmate.util;

import com.bu.jichulmate.exception.ErrorCode;
import com.bu.jichulmate.exception.UnauthorizedException;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;

@Component
public class SessionUtils {

    public static final String SESSION_USER = "loginUser";

    public static final String SESSION_USER_ID = "LOGIN_USER_ID";
    public static final String SESSION_USER_ROLE = "LOGIN_USER_ROLE";
    private static final String LEGACY_USER_ID = "loginUserId";
    private static final String LEGACY_USER_ROLE = "role";

    private SessionUtils() {
    }

    public static Long getLoginUserId(HttpSession session) {
        if (session == null) {
            throw new UnauthorizedException(ErrorCode.LOGIN_REQUIRED);
        }

        Object userId = session.getAttribute(SESSION_USER_ID);

        if (userId == null) {
            userId = session.getAttribute(LEGACY_USER_ID);
        }

        if (userId == null) {
            throw new UnauthorizedException(ErrorCode.LOGIN_REQUIRED);
        }

        if (userId instanceof Long) {
            return (Long) userId;
        }

        if (userId instanceof Integer) {
            return ((Integer) userId).longValue();
        }

        if (userId instanceof String) {
            try {
                return Long.parseLong((String) userId);
            } catch (NumberFormatException e) {
                throw new UnauthorizedException(ErrorCode.LOGIN_REQUIRED);
            }
        }

        throw new UnauthorizedException(ErrorCode.LOGIN_REQUIRED);
    }

    /**
     * 로그인 여부 확인
     */
    public static boolean isLoggedIn(HttpSession session) {
        if (session == null) {
            return false;
        }

        return session.getAttribute(SESSION_USER_ID) != null
                || session.getAttribute(LEGACY_USER_ID) != null
                || session.getAttribute(SESSION_USER) != null;
    }

    /**
     * 관리자 여부 확인
     */
    public static boolean isAdmin(HttpSession session) {
        if (session == null) {
            return false;
        }

        Object role = session.getAttribute(SESSION_USER_ROLE);

        if (role == null) {
            role = session.getAttribute(LEGACY_USER_ROLE);
        }

        return "ADMIN".equals(String.valueOf(role));
    }

    /**
     * 로그인 세션 저장
     */
    public static void setLoginUser(HttpSession session, Long userId, String role) {
        if (session == null) {
            return;
        }

        session.setAttribute(SESSION_USER_ID, userId);
        session.setAttribute(SESSION_USER_ROLE, role);

        /*
         * 기존 JSP/JS/컨트롤러 호환용 세션 키도 같이 저장
         */
        session.setAttribute(LEGACY_USER_ID, userId);
        session.setAttribute(LEGACY_USER_ROLE, role);
    }

    /**
     * 로그인 사용자 객체까지 같이 저장
     */
    public static void setLoginUser(HttpSession session, Object loginUser, Long userId, String loginId, String nickname, String role) {
        if (session == null) {
            return;
        }

        session.setAttribute(SESSION_USER, loginUser);

        session.setAttribute(SESSION_USER_ID, userId);
        session.setAttribute(SESSION_USER_ROLE, role);

        session.setAttribute(LEGACY_USER_ID, userId);
        session.setAttribute("loginId", loginId);
        session.setAttribute("nickname", nickname);
        session.setAttribute(LEGACY_USER_ROLE, role);
    }

    /**
     * 세션 초기화
     */
    public static void clearSession(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
    }
}