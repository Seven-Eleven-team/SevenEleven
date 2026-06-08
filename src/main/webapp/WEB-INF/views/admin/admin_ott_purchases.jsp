<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTT 구매 승인 | 지출메이트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-console.css">
</head>
<body class="admin-body">
<header class="admin-topbar">
    <a class="admin-brand" href="${pageContext.request.contextPath}/admin">지출메이트</a>
</header>

<main class="admin-page admin-enter">
    <section class="admin-panel">
        <div class="admin-page-head"><div><span class="admin-kicker">OTT PURCHASES</span><h1>OTT 구매 승인</h1></div><a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin">처음 화면</a></div>
        <nav class="admin-folder-tabs" aria-label="OTT 관리 하위 메뉴">
            <a class="admin-mini-folder admin-link" href="${pageContext.request.contextPath}/admin/ott/sellers"><span class="admin-mini-folder-icon" aria-hidden="true"></span><span>판매자 승인</span></a>
            <a class="admin-mini-folder is-active admin-link" href="${pageContext.request.contextPath}/admin/ott/purchases"><span class="admin-mini-folder-icon" aria-hidden="true"></span><span>구매 승인</span></a>
        </nav>
        <div class="admin-card">
            <div class="admin-card-head"><h2>구매 요청 관리</h2><span class="admin-card-sub">SUBSCRIPTIONS 기준</span></div>
            <div class="admin-table-wrap"><table class="admin-table"><thead><tr><th>구독 ID</th><th>회원 ID</th><th>파티 ID</th><th>월 금액</th><th>총 금액</th><th>기간</th><th>상태</th><th>요청일</th><th>관리</th></tr></thead><tbody>
                <tr><td>1</td><td>5</td><td>10</td><td>4,000</td><td>12,000</td><td>3개월</td><td><span class="admin-badge badge-yellow">ACTIVE</span></td><td>2026-06-02</td><td><a class="admin-btn admin-link" href="${pageContext.request.contextPath}/admin/ott/purchases/detail?subId=1">상세</a></td></tr>
                <tr><td>2</td><td>6</td><td>11</td><td>5,500</td><td>33,000</td><td>6개월</td><td><span class="admin-badge badge-green">ACTIVE</span></td><td>2026-06-01</td><td><a class="admin-btn admin-link" href="${pageContext.request.contextPath}/admin/ott/purchases/detail?subId=2">상세</a></td></tr>
            </tbody></table></div>
        </div>
        <a class="admin-logout admin-link" href="${pageContext.request.contextPath}/logout">로그아웃</a>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/pages/admin-dashboard.js"></script>
</body>
</html>
