package com.bu.jichulmate.config;

import com.bu.jichulmate.util.SessionUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Slf4j
@Component
public class AdminCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);

        // 관리자가 아니면 무조건 튕겨냅니다 (403 Forbidden)
        if (!SessionUtils.isAdmin(session)) {
            log.warn("[보안 경고] 관리자 권한이 없는 사용자의 접근 시도: {}", request.getRequestURI());

            // API 요청인 경우 JSON 에러를, 일반 페이지 요청인 경우 에러 페이지를 띄우도록 처리 가능합니다.
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "관리자 권한이 필요합니다.");
            return false; // 컨트롤러로 넘어가지 못하게 여기서 차단!
        }

        return true; // 관리자가 맞으면 무사 통과!
    }
}