<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 관리 | 지출메이트</title>
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
                <span class="admin-kicker">USER MANAGEMENT</span>
                <h1>회원 관리</h1>
            </div>
            <a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin">처음 화면</a>
        </div>
        <nav class="admin-folder-tabs" aria-label="회원 관리 하위 메뉴">
            <a class="admin-mini-folder is-active admin-link" href="${pageContext.request.contextPath}/admin/users">
                <span class="admin-mini-folder-icon" aria-hidden="true"></span>
                <span>회원 관리</span>
            </a>
            <a class="admin-mini-folder admin-link" href="${pageContext.request.contextPath}/admin/audit">
                <span class="admin-mini-folder-icon" aria-hidden="true"></span>
                <span>활동 로그 조회</span>
            </a>
        </nav>
        <div class="admin-card">
            <div class="admin-card-head">
                <h2>회원 목록</h2>
                <span class="admin-card-sub">USERS 테이블 기준 정보</span>
            </div>
            <div class="admin-table-wrap">
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th>회원 ID</th>
                        <th>로그인 ID</th>
                        <th>닉네임</th>
                        <th>권한</th>
                        <th>계정 상태</th>
                        <th>알림 수신</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>admin</td>
                        <td>관리자</td>
                        <td><span class="admin-badge badge-blue">ADMIN</span></td>
                        <td><span class="admin-badge badge-green">ACTIVE</span></td>
                        <td>Y</td>
                        <td class="admin-actions">
                            <a class="admin-btn admin-link" href="${pageContext.request.contextPath}/admin/users/detail?userId=1">상세보기</a>
                            <a class="admin-btn ghost admin-link" href="${pageContext.request.contextPath}/admin/users/status?userId=1">상태변경</a>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>user01</td>
                        <td>소비러</td>
                        <td><span class="admin-badge badge-gray">USER</span></td>
                        <td><span class="admin-badge badge-green">ACTIVE</span></td>
                        <td>Y</td>
                        <td class="admin-actions">
                            <a class="admin-btn admin-link" href="${pageContext.request.contextPath}/admin/users/detail?userId=2">상세보기</a>
                            <a class="admin-btn ghost admin-link" href="${pageContext.request.contextPath}/admin/users/status?userId=2">상태변경</a>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>seller01</td>
                        <td>구독공유</td>
                        <td><span class="admin-badge badge-gray">USER</span></td>
                        <td><span class="admin-badge badge-yellow">SUSPENDED</span></td>
                        <td>N</td>
                        <td class="admin-actions">
                            <a class="admin-btn admin-link" href="${pageContext.request.contextPath}/admin/users/detail?userId=3">상세보기</a>
                            <a class="admin-btn ghost admin-link" href="${pageContext.request.contextPath}/admin/users/status?userId=3">상태변경</a>
                        </td>
                    </tr>
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
