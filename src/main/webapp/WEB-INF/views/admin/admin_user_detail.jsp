<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 상세 | 지출메이트</title>
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
                <span class="admin-kicker">USER DETAIL</span>
                <h1>회원 상세</h1>
            </div>
            <div class="admin-head-actions">
                <a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin/users">회원 목록</a>
                <a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin">처음 화면</a>
            </div>
        </div>
        <div class="admin-card detail-card">
            <div class="admin-card-head">
                <h2>기본 정보</h2>
                <span class="admin-card-sub">비밀번호는 관리자 화면에 노출하지 않음</span>
            </div>
            <dl class="admin-detail-grid">
                <div><dt>회원 ID</dt><dd>1</dd></div>
                <div><dt>로그인 ID</dt><dd>admin</dd></div>
                <div><dt>닉네임</dt><dd>관리자</dd></div>
                <div><dt>성별</dt><dd>FEMALE</dd></div>
                <div><dt>생년월일</dt><dd>2000-01-01</dd></div>
                <div><dt>가입 방식</dt><dd>LOCAL</dd></div>
                <div><dt>2차 인증 여부</dt><dd>N</dd></div>
                <div><dt>멘토 톤</dt><dd>MILD</dd></div>
                <div><dt>권한</dt><dd><span class="admin-badge badge-blue">ADMIN</span></dd></div>
                <div><dt>계정 상태</dt><dd><span class="admin-badge badge-green">ACTIVE</span></dd></div>
                <div><dt>알림 수신 여부</dt><dd>Y</dd></div>
            </dl>
        </div>
        <div class="admin-bottom-actions">
            <a class="admin-btn ghost admin-link" href="${pageContext.request.contextPath}/admin/users">목록으로</a>
            <a class="admin-btn admin-link" href="${pageContext.request.contextPath}/admin/users/status?userId=1">상태변경</a>
        </div>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/pages/admin-dashboard.js"></script>
</body>
</html>
