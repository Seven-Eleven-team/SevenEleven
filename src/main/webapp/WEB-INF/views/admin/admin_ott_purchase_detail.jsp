<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTT 구매 상세 | 지출메이트</title>
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
        <div class="admin-page-head"><div><span class="admin-kicker">PURCHASE DETAIL</span><h1>구매 승인 / 미처리</h1></div><a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin/ott/purchases">구매 목록</a></div>
        <div class="admin-split">
            <article class="admin-card"><div class="admin-card-head"><h2>구매 정보</h2><span class="admin-card-sub">SUBSCRIPTIONS</span></div><dl class="admin-detail-grid one-column">
                <div><dt>구독 ID</dt><dd>1</dd></div><div><dt>회원 ID</dt><dd>5</dd></div><div><dt>파티 ID</dt><dd>10</dd></div><div><dt>월 금액</dt><dd>4,000</dd></div><div><dt>총 금액</dt><dd>12,000</dd></div><div><dt>이용 기간</dt><dd>3개월</dd></div><div><dt>시작일</dt><dd>2026-06-02</dd></div><div><dt>종료일</dt><dd>2026-09-02</dd></div><div><dt>다음 결제일</dt><dd>2026-07-02</dd></div><div><dt>상태</dt><dd><span class="admin-badge badge-yellow">ACTIVE</span></dd></div>
            </dl></article>
            <form class="admin-card admin-form" action="${pageContext.request.contextPath}/admin/ott/purchases/status" method="post">
                <div class="admin-card-head"><h2>구매 상태 처리</h2><span class="admin-card-sub">STATUS 값 변경</span></div>
                <input type="hidden" name="subId" value="1">
                <label><span>상태</span><select name="status"><option value="ACTIVE">ACTIVE</option><option value="CANCELLED">CANCELLED</option><option value="EXPIRED">EXPIRED</option></select></label>
                <button class="admin-btn full" type="submit">상태 저장</button>
            </form>
        </div>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/pages/admin-dashboard.js"></script>
</body>
</html>
