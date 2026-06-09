<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="menu" value="sales"/>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <title>지출메이트 - 내 판매 목록 리스트</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/sales.css">

    <style>
        body.mypage-body {
            padding-top: 78px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: #f7f8fb;
        }

        body.mypage-body .site-header {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 100% !important;
            height: 78px !important;
            background: rgba(25, 59, 96, 0.96) !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            z-index: 9999 !important;
        }

        body.mypage-body .site-logo {
            color: white !important;
            font-size: 28px !important;
            font-weight: 800 !important;
            margin: 0 !important;
        }

        body.mypage-body .auth-link {
            display: none !important;
        }

        body.mypage-body .header-action-area {
            position: absolute !important;
            right: 36px !important;
        }

        body.mypage-body .user-profile-link {
            width: 46px !important;
            height: 46px !important;
            border-radius: 50% !important;
            background: white !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            text-decoration: none !important;
        }

        body.mypage-body .user-avatar {
            color: #243864 !important;
            font-weight: 700 !important;
        }

        body.mypage-body .hamburger-btn {
            position: absolute !important;
            left: 36px !important;
            width: 42px !important;
            height: 42px !important;
            border: none !important;
            border-radius: 0 !important;
            background: transparent !important;
            color: white !important;
            font-size: 22px !important;
            display: flex !important;
            flex-direction: column !important;
            justify-content: center !important;
            align-items: center !important;
            gap: 4px !important;
        }

        body.mypage-body .hamburger-btn span {
            display: block !important;
            width: 22px !important;
            height: 2px !important;
            background: white !important;
            border-radius: 999px !important;
        }

        body.mypage-body nav.sidebar {
            position: fixed;
            top: 78px;
            left: -260px;
            width: 250px;
            height: calc(100vh - 78px);
            background: #243864;
            border-right: none;
            transition: all 0.3s ease;
            z-index: 9998;
            padding-top: 20px;
        }

        body.mypage-body nav.sidebar.open {
            left: 0;
        }

        body.mypage-body nav.sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        body.mypage-body nav.sidebar li {
            width: 100%;
        }

        body.mypage-body nav.sidebar li a {
            display: flex;
            align-items: center;
            height: 54px;
            padding: 0 24px;
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            transition: 0.2s;
        }

        body.mypage-body nav.sidebar li a:hover {
            background: rgba(255, 255, 255, 0.12);
        }

        .mypage-container {
            display: flex;
            gap: 26px;
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
            padding: 40px 0;
            flex: 1;
        }

        .mypage-sidebar {
            width: 250px;
            min-width: 250px;
            background: #ffffff;
            border: 1px solid #dddddd;
            border-radius: 20px;
            display: flex;
            align-items: center;
        }

        .mypage-sidebar ul {
            display: flex;
            flex-direction: column;
            justify-content: center;
            list-style: none;
            padding: 0;
            margin: 0;
            width: 100%;
        }

        .mypage-sidebar li {
            width: 100%;
        }

        .mypage-sidebar li a {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: 55px;
            padding: 0;
            text-align: center;
            font-size: 16px;
            font-weight: 500;
            color: #111111;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .mypage-sidebar li a:hover {
            background: #fafafa;
            color: #ff4d4d;
        }

        .mypage-sidebar li.active a {
            color: #ff4d4d;
            font-weight: 700;
        }

        .dashboard {
            flex: 1;
            min-width: 0;
        }

        .page-header {
            margin-bottom: 24px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 800;
            color: #111111;
            margin: 0;
        }

        .sales-card {
            background: #ffffff;
            border-radius: 22px;
            padding: 32px;
            border: 1px solid #e5e5e5;
            min-height: 420px;
        }

        .empty-box {
            min-height: 320px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 22px;
            text-align: center;
        }

        .empty-box h1 {
            font-size: 26px;
            font-weight: 800;
            color: #222222;
            margin: 0;
        }

        .primary-btn {
            min-width: 160px;
            height: 48px;
            border: none;
            border-radius: 14px;
            background: #243864;
            color: white;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
        }

        .primary-btn:hover {
            opacity: 0.92;
        }

        .sales-list-content {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .sale-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 22px 24px;
            border: 1px solid #eeeeee;
            border-radius: 18px;
            background: #ffffff;
            transition: 0.2s;
        }

        .sale-item:hover {
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.06);
            transform: translateY(-1px);
        }

        .item-left-group {
            display: flex;
            align-items: center;
            gap: 18px;
            min-width: 0;
        }

        .item-logo-area {
            width: 58px;
            height: 58px;
            border-radius: 18px;
            background: #f4f6fa;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
        }

        .item-logo-area img {
            max-width: 44px;
            max-height: 44px;
            object-fit: contain;
        }

        .item-info {
            display: flex;
            flex-direction: column;
            gap: 8px;
            min-width: 0;
        }

        .item-name {
            font-size: 18px;
            font-weight: 800;
            color: #111111;
        }

        .item-desc-text {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
            font-size: 14px;
            color: #666666;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 68px;
            height: 28px;
            padding: 0 10px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 700;
        }

        .status-badge.selling {
            background: #e9f8ef;
            color: #1f9d55;
        }

        .status-badge.waiting {
            background: #fff4df;
            color: #d48600;
        }

        .status-badge.full {
            background: #eeeeee;
            color: #666666;
        }

        .status-badge.rejected {
            background: #ffe8e8;
            color: #e53935;
        }

        .price-text {
            font-weight: 700;
            color: #222222;
        }

        .item-right-stat {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-shrink: 0;
        }

        .buyer-count {
            font-size: 14px;
            font-weight: 700;
            color: #555555;
        }

        .detail-btn {
            height: 34px;
            padding: 0 14px;
            border: 1px solid #243864;
            border-radius: 10px;
            background: white;
            color: #243864;
            font-weight: 700;
            cursor: pointer;
        }

        .detail-btn:hover {
            background: #243864;
            color: white;
        }

        .pagination {
            margin-top: 28px;
            display: flex;
            justify-content: center;
        }

        .page-link {
            width: 34px;
            height: 34px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            text-decoration: none;
            color: #333333;
            font-weight: 700;
            border: 1px solid #dddddd;
        }

        .page-link.active {
            background: #243864;
            color: white;
            border-color: #243864;
        }

        .footer {
            width: 100%;
            background: #243864;
            color: white;
            padding: 40px 0;
            margin-top: 60px;
        }
    </style>
</head>

<body class="mypage-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <main class="dashboard">

        <div class="page-header">
            <h1 class="page-title">내 판매 목록</h1>
        </div>

        <section class="sales-card">

            <c:choose>

                <c:when test="${not isSeller}">
                    <div class="empty-box">
                        <h1>판매자 등록을 먼저 해주세요!</h1>

                        <button type="button"
                                class="primary-btn"
                                onclick="location.href='${pageContext.request.contextPath}/mypage/sales/register-identity'">
                            판매자 등록하기
                        </button>
                    </div>
                </c:when>

                <c:when test="${isSeller and empty salesList}">
                    <div class="empty-box">
                        <h1>등록된 판매글이 없습니다.</h1>

                        <button type="button"
                                class="primary-btn"
                                onclick="location.href='${pageContext.request.contextPath}/party/form'">
                            판매글 등록하기
                        </button>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="sales-list-content">

                        <c:forEach var="s" items="${salesList}">

                            <div class="sale-item">

                                <div class="item-left-group">

                                    <div class="item-logo-area">
                                        <c:choose>
                                            <c:when test="${s.serviceName eq '유튜브 프리미엄'}">
                                                <img src="${pageContext.request.contextPath}/images/youtube_premium_logo.png"
                                                     alt="유튜브 프리미엄 로고">
                                            </c:when>

                                            <c:when test="${s.serviceName eq '넷플릭스'}">
                                                <img src="${pageContext.request.contextPath}/images/netflix.png"
                                                     alt="넷플릭스 로고">
                                            </c:when>

                                            <c:when test="${s.serviceName eq '티빙'}">
                                                <img src="${pageContext.request.contextPath}/images/tving.png"
                                                     alt="티빙 로고">
                                            </c:when>

                                            <c:when test="${s.serviceName eq '웨이브'}">
                                                <img src="${pageContext.request.contextPath}/images/wavve.png"
                                                     alt="웨이브 로고">
                                            </c:when>

                                            <c:when test="${s.serviceName eq '왓챠'}">
                                                <img src="${pageContext.request.contextPath}/images/watcha.png"
                                                     alt="왓챠 로고">
                                            </c:when>

                                            <c:otherwise>
                                                <span style="font-weight:800; color:#243864;">
                                                        ${s.serviceName}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="item-info">
                                        <div class="item-name">${s.serviceName}</div>

                                        <div class="item-desc-text">
                                            <c:choose>
                                                <c:when test="${s.status eq 'APPROVED'}">
                                                    <span class="status-badge selling">판매중</span>
                                                </c:when>

                                                <c:when test="${s.status eq 'WAITING'}">
                                                    <span class="status-badge waiting">승인대기</span>
                                                </c:when>

                                                <c:when test="${s.status eq 'FULL'}">
                                                    <span class="status-badge full">모집완료</span>
                                                </c:when>

                                                <c:when test="${s.status eq 'REJECTED'}">
                                                    <span class="status-badge rejected">반려</span>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="status-badge full">${s.status}</span>
                                                </c:otherwise>
                                            </c:choose>

                                            <span class="price-text">${s.monthlyPrice}원</span>
                                            <span>${s.saleMonths}개월 판매</span>
                                            <span>공유 ID: ${s.shareId}</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="item-right-stat">
                                    <span class="buyer-count">
                                        등록일: ${s.createdAt}
                                    </span>

                                    <button type="button"
                                            class="detail-btn"
                                            onclick="location.href='${pageContext.request.contextPath}/party/detail/${s.id}'">
                                        상세보기
                                    </button>
                                </div>

                            </div>

                        </c:forEach>

                    </div>

                    <div class="pagination">
                        <a href="#" class="page-link active">1</a>
                    </div>
                </c:otherwise>

            </c:choose>

        </section>

    </main>

</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>
    const hamburgerBtn = document.querySelector('.hamburger-btn');
    const sidebar = document.querySelector('nav.sidebar');

    if (hamburgerBtn && sidebar) {
        hamburgerBtn.addEventListener('click', function () {
            sidebar.classList.toggle('open');
        });
    }
</script>

</body>
</html>