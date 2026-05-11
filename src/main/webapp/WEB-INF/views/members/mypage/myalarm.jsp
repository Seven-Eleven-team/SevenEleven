<%-- 경로: src/main/webapp/WEB-INF/views/members/mypage/myalarm.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 알림</title>
    <%-- CSS 경로 contextPath 적용 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myalarm.css">
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
            <li class="active">
                <a href="${pageContext.request.contextPath}/members/mypage/myalarm">알림</a>
            </li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mysale">내 판매 목록</a></li>
        </ul>
    </aside>

    <main class="alarm-main">
        <h1 class="page-title">알림</h1>

        <section class="alarm-card">
            <div class="alarm-table">

                <c:choose>
                    <c:when test="${not empty alarmList}">
                        <c:forEach var="alarm" items="${alarmList}">
                            <%-- 알림 타입이 결제 알림(PAYMENT)일 경우 warning 클래스 추가 --%>
                            <div class="alarm-row ${alarm.type == 'PAYMENT' ? 'warning' : ''}">
                                <div class="alarm-left">
                                    <span class="alarm-icon">🔔</span>
                                    <span class="alarm-text">
                                        <c:out value="${alarm.message}" escapeXml="false" />
                                        <%--
                                          서버에서 alarm.message를 보낼 때
                                          "유튜브 자동 결제까지 <strong class='danger-text'>3일</strong> 남았습니다."
                                          와 같이 HTML을 포함해서 보낼 경우 escapeXml="false"를 사용합니다.
                                        --%>
                                    </span>
                                </div>
                            </div>
                        </c:forEach>

                        <%-- 최소 10줄 디자인 유지를 위한 빈 줄 처리 --%>
                        <c:if test="${alarmList.size() < 10}">
                            <c:forEach begin="1" end="${10 - alarmList.size()}">
                                <div class="empty-line"></div>
                            </c:forEach>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <%-- 알림이 없을 때 --%>
                        <div class="alarm-row" style="justify-content: center; color: #999;">새로운 알림이 없습니다.</div>
                        <c:forEach begin="1" end="9">
                            <div class="empty-line"></div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

            </div>

            <div class="pagination">
                <c:choose>
                    <c:when test="${not empty totalPages && totalPages > 0}">
                        <c:forEach var="p" begin="1" end="${totalPages}">
                            <span class="page-num ${p == currentPage ? 'active' : ''}"
                                  onclick="location.href='${pageContext.request.contextPath}/members/mypage/myalarm?page=${p}'"
                                  style="cursor:pointer; margin: 0 5px;">${p}</span>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        1
                    </c:otherwise>
                </c:choose>
            </div>

        </section>
    </main>
</div>

</body>
</html>