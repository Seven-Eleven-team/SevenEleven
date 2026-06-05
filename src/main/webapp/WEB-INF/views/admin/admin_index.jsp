<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 | 지출메이트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-console.css">
</head>
<body class="admin-body">
<header class="admin-topbar">
    <a class="admin-brand" href="${pageContext.request.contextPath}/admin">지출메이트</a>
</header>

<main class="admin-main-board admin-enter">
    <section class="admin-folder-board" aria-label="관리자 기능 선택">
        <a class="admin-folder-card admin-link" href="${pageContext.request.contextPath}/admin/users">
            <span class="admin-folder-icon" aria-hidden="true"></span>
            <span class="admin-folder-title">회원 관리</span>
        </a>
        <a class="admin-folder-card admin-link" href="${pageContext.request.contextPath}/admin/terms">
            <span class="admin-folder-icon" aria-hidden="true"></span>
            <span class="admin-folder-title">약관 관리</span>
        </a>
        <a class="admin-folder-card admin-link" href="${pageContext.request.contextPath}/admin/ott/sellers">
            <span class="admin-folder-icon" aria-hidden="true"></span>
            <span class="admin-folder-title">OTT 관리</span>
        </a>
        <a class="admin-folder-card admin-link" href="${pageContext.request.contextPath}/admin/support">
            <span class="admin-folder-icon" aria-hidden="true"></span>
            <span class="admin-folder-title">고객센터</span>
        </a>
        <a class="admin-folder-card admin-link" href="${pageContext.request.contextPath}/admin/notifications">
            <span class="admin-folder-icon" aria-hidden="true"></span>
            <span class="admin-folder-title">이메일 알림</span>
        </a>
        <a class="admin-folder-logout admin-link" href="${pageContext.request.contextPath}/logout">로그아웃</a>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/pages/admin-dashboard.js"></script>
</body>
</html>
