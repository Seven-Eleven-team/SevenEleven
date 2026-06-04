<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="menu" value="alarm"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 알림</title>

    <!-- 공통 및 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myalarm.css">

    <style>
        /* 풋터 및 기본 배경 */
        .footer { width: 100%; background: #243864; color: white; padding: 40px 0; margin-top: 60px; }
        body.mypage { padding-top: 78px; min-height: 100vh; display: flex; flex-direction: column; background: #f5f5f5; }

        /* 레이아웃 틀 고정 (사이드바 + 메인) */
        .mypage-container {
            display: flex !important;
            flex-direction: row !important;
            align-items: stretch !important;
            gap: 26px !important;
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 0;
            flex: 1;
        }

        /* 헤더 고정 스타일 */
        body.mypage .site-header {
            position: fixed !important; top: 0 !important; left: 0 !important;
            width: 100% !important; height: 78px !important;
            background: #243864 !important; display: flex !important;
            align-items: center !important; justify-content: center !important; z-index: 9999 !important;
        }

        /* 사이드바 스타일 */
        .mypage-sidebar {
            width: 250px !important; min-width: 250px !important; height: auto !important;
            background: #ffffff !important; border: 1px solid #dddddd !important;
            border-radius: 20px !important; padding: 0 !important; display: flex !important;
            align-items: center !important;
        }

        /* 메인 영역 */
        .alarm-main { flex: 1; }

        /* 제목과 알림 설정을 한 줄로 배치 */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .page-title {
            font-size: 24px;
            font-weight: 800;
            color: #333;
            margin-bottom: 0;
        }

        /* 이메일 알림 스위치 스타일 */
        .email-setting {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 15px;
            color: #666;
            font-weight: 500;
        }
        .switch {
            position: relative;
            display: inline-block;
            width: 44px;
            height: 22px;
        }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider {
            position: absolute; cursor: pointer;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc; transition: .4s;
            border-radius: 34px;
        }
        .slider:before {
            position: absolute; content: "";
            height: 16px; width: 16px; left: 3px; bottom: 3px;
            background-color: white; transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider { background-color: #645495; }
        input:checked + .slider:before { transform: translateX(22px); }

        /* 알림 리스트 스타일 (네모 박스 제거) */
        .alarm-table {
            background: transparent;
            border: none;
            box-shadow: none;
        }
        .alarm-row {
            display: flex;
            align-items: center;
            background: white;
            border-bottom: 1px solid #f5f5f5;
            padding: 20px 0;
            transition: background 0.2s;
            cursor: default;
        }
        .alarm-row:hover { background: #fafafa; }

        .alarm-left {
            display: flex;
            align-items: center;
            gap: 15px;
            width: 100%;
            padding: 0 10px;
        }
        .alarm-icon {
            font-size: 20px;
            width: 30px;
            text-align: center;
        }
        .alarm-text {
            font-size: 15px;
            color: #444;
            line-height: 1.5;
        }
        .danger-text {
            color: #ff4d4d;
            font-weight: 700;
        }

        /* 데이터 없을 때 */
        .empty-msg { text-align: center; padding: 60px 0; color: #999; font-size: 15px; }

        /* 페이지네이션 스타일 */
        .pagination { display: flex; justify-content: center; margin-top: 20px; gap: 5px; }
        .page-link { padding: 8px 12px; border: 1px solid #ddd; border-radius: 5px;
                    text-decoration: none; color: #333; font-size: 14px; }
        .page-link.active { background: #645495; color: white; border-color: #645495; }
    </style>
</head>
<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">
    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <main class="alarm-main">
        <!-- 제목과 설정을 한 줄로 배치한 헤더 -->
        <div class="page-header">
            <h1 class="page-title">알림</h1>
            <div class="email-setting">
                <span>📧 이메일 알림</span>
                <label class="switch">
                    <input type="checkbox" checked>
                    <span class="slider"></span>
                </label>
            </div>
        </div>

        <section class="alarm-card">
            <div class="alarm-table">
                <!-- DB 데이터 출력 루프 -->
                <c:choose>
                    <c:when test="${not empty notifications and not empty notifications.content}">
                        <c:forEach var="noti" items="${notifications.content}">
                            <div class="alarm-row">
                                <div class="alarm-left">
                                    <span class="alarm-icon">
                                        <c:choose>
                                            <c:when test="${noti.type == 'EMAIL'}">📧</c:when>
                                            <c:when test="${noti.type == 'PUSH'}">🔔</c:when>
                                            <c:otherwise>📌</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span class="alarm-text">
                                        ${noti.content}
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- ✅ 예시 데이터 삭제: 데이터가 없을 때 이 메시지만 출력됨 -->
                        <div class="empty-msg">도착한 알림이 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 페이지네이션 (Page 객체 기반) -->
            <c:if test="${not empty notifications and notifications.totalPages > 0}">
                <div class="pagination">
                    <c:forEach begin="0" end="${notifications.totalPages - 1}" var="i">
                        <a href="?page=${i + 1}" class="page-link ${notifications.number == i ? 'active' : ''}">${i + 1}</a>
                    </c:forEach>
                </div>
            </c:if>
        </section>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const hamburgerBtn = document.querySelector('.hamburger-btn');
        const sidebar = document.querySelector('nav.sidebar');
        if (hamburgerBtn && sidebar) {
            hamburgerBtn.addEventListener('click', function () {
                sidebar.classList.toggle('open');
            });
        }
    });
</script>
</body>
</html>
