<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알림 상세 | 지출메이트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-console.css">
</head>
<body class="admin-body">
<header class="admin-topbar">
    <a class="admin-brand" href="${pageContext.request.contextPath}/admin">지출메이트</a>
</header>

<main class="admin-page admin-enter">
    <section class="admin-panel compact">
        <div class="admin-page-head"><div><span class="admin-kicker">NOTIFICATION DETAIL</span><h1>알림 상세 / 실패 사유</h1></div><a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin/notifications">알림 목록</a></div>
        <div class="admin-card detail-card"><div class="admin-card-head"><h2>알림 상세</h2><span class="admin-card-sub">NOTIFICATION_LOGS</span></div><dl class="admin-detail-grid">
            <div><dt>로그 ID</dt><dd>2</dd></div><div><dt>회원 ID</dt><dd>3</dd></div><div><dt>알림 종류</dt><dd>ACCOUNT</dd></div><div><dt>성공 여부</dt><dd><span class="admin-badge badge-red">N</span></dd></div><div><dt>실패 사유</dt><dd>SMTP_TIMEOUT</dd></div><div><dt>발송 일시</dt><dd>2026-06-02 09:10</dd></div><div class="wide-item"><dt>알림 내용</dt><dd>계정 상태 변경 안내 메일 발송에 실패했습니다.</dd></div>
        </dl></div>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/pages/admin-dashboard.js"></script>
</body>
</html>
