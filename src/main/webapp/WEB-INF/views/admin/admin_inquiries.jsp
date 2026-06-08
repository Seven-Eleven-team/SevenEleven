<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의 관리 | 지출메이트</title>
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
        <div class="admin-page-head"><div><span class="admin-kicker">INQUIRIES</span><h1>문의 관리</h1></div><a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin">처음 화면</a></div>
        <nav class="admin-folder-tabs" aria-label="고객센터 하위 메뉴"><a class="admin-mini-folder is-active admin-link" href="${pageContext.request.contextPath}/admin/inquiries"><span class="admin-mini-folder-icon" aria-hidden="true"></span><span>문의 관리</span></a><a class="admin-mini-folder admin-link" href="${pageContext.request.contextPath}/admin/faq"><span class="admin-mini-folder-icon" aria-hidden="true"></span><span>FAQ 관리</span></a></nav>
        <div class="admin-card"><div class="admin-card-head"><h2>문의 목록</h2><span class="admin-card-sub">INQUIRIES 기준</span></div><div class="admin-table-wrap"><table class="admin-table"><thead><tr><th>문의 ID</th><th>회원 ID</th><th>제목</th><th>상태</th><th>작성일</th><th>수정일</th><th>답변</th></tr></thead><tbody>
            <tr><td>1</td><td>2</td><td>구독 결제 문의</td><td><span class="admin-badge badge-yellow">WAITING</span></td><td>2026-06-02</td><td>-</td><td><button class="admin-btn" type="button">답변 작성</button></td></tr>
            <tr><td>2</td><td>3</td><td>계정 문의</td><td><span class="admin-badge badge-green">DONE</span></td><td>2026-06-01</td><td>2026-06-02</td><td><button class="admin-btn ghost" type="button">답변 확인</button></td></tr>
        </tbody></table></div></div>
        <a class="admin-logout admin-link" href="${pageContext.request.contextPath}/logout">로그아웃</a>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/pages/admin-dashboard.js"></script>
</body>
</html>
