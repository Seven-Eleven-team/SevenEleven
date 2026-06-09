<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="menu" value="sales"/>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 판매 목록</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mysales.css">

    <style>
        body.mypage .hamburger-btn{
            display:flex !important;
            flex-direction:column !important;
            justify-content:center !important;
            align-items:center !important;
            gap:4px !important;
        }

        body.mypage .hamburger-btn span{
            display:block !important;
            width:22px !important;
            height:2px !important;
            background:white !important;
            border-radius:999px !important;
        }

        .footer {
            width: 100%;
            background: #243864;
            color: white;
            padding: 40px 0;
            margin-top: 60px;
        }

        body.mypage {
            padding-top: 78px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .mypage-container {
            flex: 1;
        }

        body.mypage .auth-link {
            display: none !important;
        }

        body.mypage .header-action-area {
            position: absolute !important;
            right: 36px !important;
        }

        body.mypage .user-profile-link {
            display: flex !important;
        }

        body.mypage nav.sidebar {
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

        body.mypage nav.sidebar.open {
            left: 0;
        }

        body.mypage nav.sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        body.mypage nav.sidebar li {
            width: 100%;
        }

        body.mypage nav.sidebar li a {
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

        body.mypage nav.sidebar li a:hover {
            background: rgba(255, 255, 255, 0.12);
        }

        .sidebar-logout {
            position: absolute;
            bottom: 20px;
            left: 0;
            width: 100%;
        }

        .sidebar-logout a {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 0 24px;
            height: 54px;
            color: white;
            text-decoration: none;
        }

        .sidebar-logout a:hover {
            background: rgba(255, 255, 255, 0.12);
        }

        body.mypage .sidebar-overlay,
        body.mypage .sidebar-drawer,
        body.mypage .sidebar-menu,
        body.mypage .mobile-sidebar {
            display: none !important;
        }

        body.mypage .site-header {
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

        body.mypage .site-logo {
            color: white !important;
            font-size: 28px !important;
            font-weight: 800 !important;
            margin: 0 !important;
        }

        body.mypage .hamburger-btn {
            position: absolute !important;
            left: 36px !important;
            width: 42px !important;
            height: 42px !important;
            border: none !important;
            border-radius: 0 !important;
            background: transparent !important;
            color: white !important;
            font-size: 22px !important;
        }

        body.mypage .auth-link {
            color: white !important;
            text-decoration: none !important;
        }

        body.mypage .user-profile-link {
            width: 46px !important;
            height: 46px !important;
            border-radius: 50% !important;
            background: white !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            text-decoration: none !important;
        }

        body.mypage .user-avatar {
            color: #243864 !important;
            font-weight: 700 !important;
        }
    </style>
</head>

<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <main class="dashboard">

        <h2 class="page-title">내 판매 목록</h2>

        <section class="sales-card">

            <c:if test="${not isSeller}">
                <div class="empty-box">
                    <h1>판매자 등록을 먼저 해주세요!</h1>

                    <button class="primary-btn"
                            onclick="location.href='${pageContext.request.contextPath}/mypage/sales/register-identity'">
                        판매자 등록하기
                    </button>
                </div>
            </c:if>

            <c:if test="${isSeller and empty salesList}">
                <div class="empty-box">
                    <h1>등록된 판매글이 없습니다.</h1>

                    <button class="primary-btn"
                            onclick="location.href='${pageContext.request.contextPath}/party/form'">
                        판매글 등록하기
                    </button>
                </div>
            </c:if>

            <c:if test="${isSeller and not empty salesList}">

                <table class="sales-table">

                    <thead>
                    <tr>
                        <th>순번</th>
                        <th>서비스명</th>
                        <th>공유 ID</th>
                        <th>월 가격</th>
                        <th>상태</th>
                        <th>등록일</th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody>

                    <c:forEach var="s" items="${salesList}" varStatus="st">

                        <tr>
                            <td>${st.count}</td>
                            <td>${s.serviceName}</td>
                            <td>${s.shareId}</td>
                            <td>${s.monthlyPrice}원</td>

                            <td>
                                <c:choose>
                                    <c:when test="${s.status eq 'APPROVED'}">
                                        <span class="status-active">승인됨</span>
                                    </c:when>

                                    <c:when test="${s.status eq 'WAITING'}">
                                        <span class="status-stop">승인대기</span>
                                    </c:when>

                                    <c:when test="${s.status eq 'FULL'}">
                                        <span class="status-stop">모집완료</span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="status-stop">${s.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${s.createdAt}</td>

                            <td>
                                <button class="delete-btn"
                                        onclick="alert('판매글 삭제 기능은 별도 API 연결이 필요합니다.');">
                                    삭제
                                </button>
                            </td>
                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

                <div class="pagination">
                    1
                </div>

            </c:if>

        </section>

    </main>

</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

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