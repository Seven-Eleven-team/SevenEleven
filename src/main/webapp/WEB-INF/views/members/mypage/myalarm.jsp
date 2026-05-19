<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="menu" value="myalarm"/>
<!DOCTYPE html>
<html lang="ko">

<head>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <title>지출메이트 - 알림</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/alarm.css">

</head>

<body class="mypage-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <%@ include file="/WEB-INF/views/common/layout/sidebar.jspf" %>

    <!-- 메인 -->
    <main class="alarm-main">

        <h1 class="page-title">
            알림
        </h1>

        <section class="alarm-card">

            <!-- 상단 이메일 설정 -->
            <div class="alarm-top-bar">

                <div class="email-alarm-setting">

                    <span class="email-title">
                        📧 이메일 알림
                    </span>

                    <label class="switch">

                        <input type="checkbox"
                               checked>

                        <span class="slider"></span>

                    </label>

                </div>

            </div>

            <!-- 알림 목록 -->
            <div class="alarm-table">

                <!-- 알림 1 -->
                <div class="alarm-row warning">

                    <div class="alarm-left">

                        <span class="alarm-icon">
                            🔔
                        </span>

                        <span class="alarm-text">

                            유튜브 자동 결제까지

                            <strong class="danger-text">
                                3일
                            </strong>

                            남았습니다.

                        </span>

                    </div>

                </div>

                <!-- 알림 2 -->
                <div class="alarm-row">

                    <div class="alarm-left">

                        <span class="alarm-icon">
                            💳
                        </span>

                        <span class="alarm-text">

                            넷플릭스 결제가 완료되었습니다.

                        </span>

                    </div>

                </div>

                <!-- 알림 3 -->
                <div class="alarm-row">

                    <div class="alarm-left">

                        <span class="alarm-icon">
                            📌
                        </span>

                        <span class="alarm-text">

                            새로운 공지사항이 등록되었습니다.

                        </span>

                    </div>

                </div>

                <!-- 빈 줄 -->
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>

            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">

                1

            </div>

        </section>

    </main>

</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

</body>
</html>