<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTT 판매자 상세 | 지출메이트</title>
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
        <div class="admin-page-head"><div><span class="admin-kicker">SELLER DETAIL</span><h1>판매자 확인 / 승인</h1></div><a class="admin-text-link admin-link" href="${pageContext.request.contextPath}/admin/ott/sellers">판매자 목록</a></div>
        <div class="admin-split">
            <article class="admin-card">
                <div class="admin-card-head"><h2>판매자 정보</h2><span class="admin-card-sub">PARTY_SELLERS</span></div>
                <dl class="admin-detail-grid one-column">
                    <div><dt>판매자 ID</dt><dd>1</dd></div><div><dt>회원 ID</dt><dd>3</dd></div><div><dt>이름</dt><dd>김판매</dd></div><div><dt>생년월일</dt><dd>1999-01-01</dd></div><div><dt>전화번호</dt><dd>010-0000-0000</dd></div><div><dt>주소</dt><dd>서울시 예시구</dd></div><div><dt>은행명</dt><dd>국민은행</dd></div><div><dt>계좌번호</dt><dd>123-456-789</dd></div><div><dt>경험 여부</dt><dd>Y</dd></div><div><dt>승인 여부</dt><dd><span class="admin-badge badge-yellow">N</span></dd></div>
                </dl>
            </article>
            <form class="admin-card admin-form" action="${pageContext.request.contextPath}/admin/ott/sellers/approve" method="post">
                <div class="admin-card-head"><h2>승인 여부 관리</h2><span class="admin-card-sub">IS_APPROVED 값 변경</span></div>
                <input type="hidden" name="sellerId" value="1">
                <label><span>승인 여부</span><select name="isApproved"><option value="Y">Y</option><option value="N">N</option></select></label>
                <button class="admin-btn full" type="submit">처리 저장</button>
            </form>
        </div>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/pages/admin-dashboard.js"></script>
</body>
</html>
