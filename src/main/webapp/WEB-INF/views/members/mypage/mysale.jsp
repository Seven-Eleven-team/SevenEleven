<%-- 경로: src/main/webapp/WEB-INF/views/members/mypage/mysale.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 판매 목록</title>
    <%-- CSS 경로 contextPath 적용 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mysales.css">
</head>
<body>

<header class="top-nav">
    <div class="menu-icon">☰</div>
    <div class="logo" onclick="location.href='${pageContext.request.contextPath}/index'" style="cursor:pointer;">지출메이트</div>
    <div class="my-page">마이페이지</div>
</header>

<div class="container">
    <aside class="sidebar">
        <ul>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mypage">대시보드</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mysub">내 구독 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mypost">내 게시글 보기</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myque">내 문의</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myreport">내 신고 목록</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myalarm">알림</a></li>
            <li class="active-red">
                <a href="${pageContext.request.contextPath}/members/mypage/mysale">내 판매 목록</a>
            </li>
        </ul>
    </aside>

    <main class="dashboard">
        <div class="sales-header-title">내 판매 목록</div>
        <div class="sales-main-box">

            <c:choose>
                <%-- CASE 1: 판매자 등록 전 (isSeller가 false이거나 비어있을 때) --%>
                <c:when test="${empty isSeller || !isSeller}">
                    <div class="sales-empty-center">
                        <h1 class="empty-msg">판매자 등록을 먼저 해주세요!</h1>
                        <%-- 등록 시나리오에 따라 이동할 경로 설정 --%>
                        <button class="register-btn" onclick="location.href='${pageContext.request.contextPath}/members/mypage/registerSeller'">판매자 등록하기</button>
                    </div>
                </c:when>

                <%-- CASE 2: 판매자 등록 후 (리스트 출력) --%>
                <c:otherwise>
                    <div class="sales-list-content">
                        <c:choose>
                            <c:when test="${not empty saleList}">
                                <c:forEach var="sale" items="${saleList}">
                                    <div class="sale-item">
                                        <div class="item-left-group">
                                            <div class="item-name">${sale.itemName}</div>
                                            <div class="item-logo-area">
                                                <img src="${pageContext.request.contextPath}/images/${sale.logoImage}" alt="로고">
                                            </div>
                                            <div class="item-desc-text">
                                                판매상태 : ${sale.status}<br>
                                                가격 : ${sale.price}원
                                            </div>
                                        </div>
                                        <div class="item-right-stat">${sale.buyerCount}명 구매</div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p style="text-align: center; color: #999; padding-top: 50px;">등록된 판매 아이템이 없습니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <%-- 페이지네이션 --%>
                    <div class="pagination-area">
                        <c:if test="${not empty totalPages && totalPages > 0}">
                            <c:forEach var="p" begin="1" end="${totalPages}">
                                <span class="page-num ${p == currentPage ? 'active' : ''}"
                                      onclick="location.href='${pageContext.request.contextPath}/members/mypage/mysale?page=${p}'"
                                      style="cursor:pointer; margin: 0 5px;">${p}</span>
                            </c:forEach>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </main>
</div>

</body>
</html>