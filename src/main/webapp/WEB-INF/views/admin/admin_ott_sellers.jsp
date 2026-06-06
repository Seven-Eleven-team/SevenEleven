<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTT 판매자 관리 | 지출메이트</title>
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
        <div class="admin-page-head">
            <div>
                <span class="admin-kicker">OTT MANAGEMENT</span>
                <h1>OTT 관리</h1>
            </div>
            <a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin">처음 화면</a>
        </div>
        <nav class="admin-folder-tabs" aria-label="OTT 관리 하위 메뉴">
            <a class="admin-mini-folder is-active admin-link" href="${pageContext.request.contextPath}/admin/ott/sellers"><span class="admin-mini-folder-icon" aria-hidden="true"></span><span>판매자 승인</span></a>
            <a class="admin-mini-folder admin-link" href="${pageContext.request.contextPath}/admin/ott/purchases"><span class="admin-mini-folder-icon" aria-hidden="true"></span><span>구매 승인</span></a>
        </nav>
        <div class="admin-card">
            <div class="admin-card-head"><h2>판매자 계정 관리</h2><span class="admin-card-sub">PARTY_SELLERS 기준</span></div>
            <div class="admin-table-wrap">
                <table class="admin-table">
                    <thead><tr><th>판매자 ID</th><th>회원 ID</th><th>이름</th><th>전화번호</th><th>은행</th><th>경험 여부</th><th>승인 여부</th><th>등록일</th><th>관리</th></tr></thead>
                    <tbody>
                    <tr><td>1</td><td>3</td><td>김판매</td><td>010-0000-0000</td><td>국민은행</td><td>Y</td><td><span class="admin-badge badge-yellow">N</span></td><td>2026-06-02</td><td><a class="admin-btn admin-link" href="${pageContext.request.contextPath}/admin/ott/sellers/detail?sellerId=1">확인</a></td></tr>
                    <tr><td>2</td><td>4</td><td>이공유</td><td>010-1111-1111</td><td>신한은행</td><td>N</td><td><span class="admin-badge badge-green">Y</span></td><td>2026-06-01</td><td><a class="admin-btn admin-link" href="${pageContext.request.contextPath}/admin/ott/sellers/detail?sellerId=2">확인</a></td></tr>
                    </tbody>
                </table>
            </div>
        </div>
        <a class="admin-logout admin-link" href="${pageContext.request.contextPath}/logout">로그아웃</a>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/pages/admin-dashboard.js"></script>
</body>
</html>
