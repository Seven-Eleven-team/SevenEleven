<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 알림</title>

    <link rel="stylesheet" href="/css/mypage.css">
    <link rel="stylesheet" href="/css/myalarm.css">
</head>
<body>

<c:set var="menu" value="alarm"/>


<div class="container container">

    <aside class="sidebar">
            <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
        </aside>

    <main class="alarm-main">

        <h1 class="page-title">알림</h1>

        <section class="alarm-card">

            <div class="alarm-top-bar">
                <div class="email-alarm-setting">
                    <span class="email-title">📧 이메일 알림</span>
                    <label class="switch">
                        <input type="checkbox" checked>
                        <span class="slider"></span>
                    </label>
                </div>
            </div>

            <div class="alarm-table">

                <div class="alarm-row warning">
                    <div class="alarm-left">
                        <span class="alarm-icon">🔔</span>
                        <span class="alarm-text">
                            유튜브 자동 결제까지
                            <strong class="danger-text">3일</strong>
                            남았습니다.
                        </span>
                    </div>
                </div>

                <div class="alarm-row">
                    <div class="alarm-left">
                        <span class="alarm-icon">💳</span>
                        <span class="alarm-text">넷플릭스 결제가 완료되었습니다.</span>
                    </div>
                </div>

                <div class="alarm-row">
                    <div class="alarm-left">
                        <span class="alarm-icon">📌</span>
                        <span class="alarm-text">새로운 공지사항이 등록되었습니다.</span>
                    </div>
                </div>

                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>

            </div>

            <div class="pagination">
                1
            </div>

        </section>

    </main>

</div>

</body>
</html>