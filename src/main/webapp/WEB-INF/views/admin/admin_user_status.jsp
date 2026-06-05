<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 상태 처리 | 지출메이트</title>
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
        <div class="admin-page-head">
            <div>
                <span class="admin-kicker">ACCOUNT STATUS</span>
                <h1>회원 정지 / 탈퇴 처리</h1>
            </div>
            <a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin/users">회원 목록</a>
        </div>
        <div class="admin-split">
            <article class="admin-card">
                <div class="admin-card-head">
                    <h2>대상 회원</h2>
                    <span class="admin-card-sub">USERS.ACCOUNT_STATUS 변경</span>
                </div>
                <dl class="admin-detail-grid one-column">
                    <div><dt>회원 ID</dt><dd>2</dd></div>
                    <div><dt>로그인 ID</dt><dd>user01</dd></div>
                    <div><dt>닉네임</dt><dd>소비러</dd></div>
                    <div><dt>현재 상태</dt><dd><span class="admin-badge badge-green">ACTIVE</span></dd></div>
                </dl>
            </article>
            <form class="admin-card admin-form" action="${pageContext.request.contextPath}/admin/users/status" method="post">
                <div class="admin-card-head">
                    <h2>상태 변경</h2>
                    <span class="admin-card-sub">저장 컬럼 기준: ACCOUNT_STATUS</span>
                </div>
                <input type="hidden" name="userId" value="2">
                <label>
                    <span>변경 상태</span>
                    <select name="accountStatus">
                        <option value="ACTIVE">ACTIVE</option>
                        <option value="SUSPENDED">SUSPENDED</option>
                        <option value="WITHDRAWN">WITHDRAWN</option>
                    </select>
                </label>
                <button type="submit" class="admin-btn full">상태 저장</button>
            </form>
        </div>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/pages/admin-dashboard.js"></script>
</body>
</html>
