<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ 관리 | 지출메이트</title>
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
        <div class="admin-page-head"><div><span class="admin-kicker">FAQ</span><h1>FAQ 관리</h1></div><a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin">처음 화면</a></div>
        <nav class="admin-folder-tabs" aria-label="고객센터 하위 메뉴"><a class="admin-mini-folder admin-link" href="${pageContext.request.contextPath}/admin/inquiries"><span class="admin-mini-folder-icon" aria-hidden="true"></span><span>문의 관리</span></a><a class="admin-mini-folder is-active admin-link" href="${pageContext.request.contextPath}/admin/faq"><span class="admin-mini-folder-icon" aria-hidden="true"></span><span>FAQ 관리</span></a></nav>
        <div class="admin-card"><div class="admin-card-head"><h2>FAQ 목록</h2><button class="admin-btn" type="button">FAQ 등록</button></div><div class="admin-table-wrap"><table class="admin-table"><thead><tr><th>FAQ ID</th><th>카테고리</th><th>질문</th><th>정렬</th><th>사용 여부</th><th>등록일</th><th>관리</th></tr></thead><tbody>
            <tr><td>1</td><td>계정</td><td>비밀번호를 잊어버렸어요.</td><td>1</td><td><span class="admin-badge badge-green">Y</span></td><td>2026-06-01</td><td><button class="admin-btn ghost" type="button">수정</button></td></tr>
            <tr><td>2</td><td>구독</td><td>OTT 구매는 어떻게 진행되나요?</td><td>2</td><td><span class="admin-badge badge-green">Y</span></td><td>2026-06-01</td><td><button class="admin-btn ghost" type="button">수정</button></td></tr>
        </tbody></table></div></div>
        <a class="admin-logout admin-link" href="${pageContext.request.contextPath}/logout">로그아웃</a>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/pages/admin-dashboard.js"></script>
</body>
</html>
