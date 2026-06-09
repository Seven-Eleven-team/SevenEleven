<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="menu" value="mysales"/>
<!DOCTYPE html>
<html lang="ko">

<head>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <title>지출메이트 - 내 판매 목록 리스트</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/sales.css">

</head>

<body class="mypage-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <%@ include file="/WEB-INF/views/common/layout/sidebar.jspf" %>

    <main class="dashboard">

            <div class="page-header">
                <h1 class="page-title">내 판매 목록</h1>
            </div>

            <section class="sales-card">
                <c:choose>
                    <%-- 1. 판매자 등록을 하지 않은 경우 (empty-box 표시) --%>
                    <c:when test="${not isSeller}">
                        <div class="empty-box">
                            <h1>판매자 등록을 먼저 해주세요!</h1>
                            <button type="button" class="primary-btn" onclick="location.href='${pageContext.request.contextPath}/mypage/sales/register-identity'">
                                판매자 등록하기
                            </button>
                        </div>
                    </c:when>

                    <%-- 2. 판매자 등록이 완료된 경우 (판매 리스트 표시) --%>
                    <c:otherwise>
                        <div class="sales-list-content">
                            <div class="sale-item">
                                <div class="item-left-group">
                                    <div class="item-logo-area">
                                        <img src="${pageContext.request.contextPath}/images/youtube_premium_logo.png" alt="유튜브 로고">
                                    </div>
                                    <div class="item-info">
                                        <div class="item-name">유튜브 프리미엄</div>
                                        <div class="item-desc-text">
                                            <span class="status-badge selling">판매중</span>
                                            <span class="price-text">7,800원</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="item-right-stat">
                                    <span class="buyer-count">3명 구매</span>
                                </div>
                            </div>
                            </div>

                        <div class="pagination">
                            <a href="#" class="page-link active">1</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

        </main>

</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

</body>
</html>