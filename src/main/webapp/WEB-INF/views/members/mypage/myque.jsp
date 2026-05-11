<%-- 경로: src/main/webapp/WEB-INF/views/members/mypage/myque.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 문의</title>
    <%-- CSS 경로 동기화 및 contextPath 적용 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myquestion.css">
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
            <li class="active">
                <a href="${pageContext.request.contextPath}/members/mypage/myque">내 문의</a>
            </li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myreport">내 신고 목록</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myalarm">알림</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mysale">내 판매 목록</a></li>
        </ul>
    </aside>

    <main class="question-main">
        <h1 class="page-title">내 문의</h1>

        <section class="question-card">
            <div class="table-header">
                <div class="col-no">순번</div>
                <div class="col-title">제목</div>
                <div class="col-answer">답변여부</div>
                <div class="col-date">문의시각</div>
                <div class="col-manage"></div>
            </div>

            <c:choose>
                <c:when test="${not empty questionList}">
                    <c:forEach var="que" items="${questionList}" varStatus="status">
                        <div class="table-row">
                            <div class="col-no">${status.count}.</div>
                            <div class="col-title" onclick="location.href='${pageContext.request.contextPath}/support/qna/detail?id=${que.id}'" style="cursor:pointer;">
                                <c:out value="${que.title}" />
                            </div>
                            <%-- 답변 상태에 따른 클래스 분기 --%>
                            <div class="col-answer ${que.answered ? 'complete' : ''}">
                                ${que.answered ? '답변 완료' : '답변 전'}
                            </div>
                            <div class="col-date">${que.regDate}</div>
                            <div class="col-manage">
                                <button class="delete-btn" onclick="if(confirm('문의를 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/support/qna/delete?id=${que.id}'">삭제하기</button>
                            </div>
                        </div>
                    </c:forEach>

                    <%-- 시안처럼 최소 10줄을 맞추기 위한 빈 줄 처리 --%>
                    <c:if test="${questionList.size() < 10}">
                        <c:forEach begin="1" end="${10 - questionList.size()}">
                            <div class="empty-line"></div>
                        </c:forEach>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <%-- 데이터가 없을 때 --%>
                    <div class="table-row" style="justify-content: center; color: #999;">문의하신 내역이 없습니다.</div>
                    <c:forEach begin="1" end="9">
                        <div class="empty-line"></div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <div class="pagination">
                <c:choose>
                    <c:when test="${not empty totalPages && totalPages > 0}">
                        <c:forEach var="p" begin="1" end="${totalPages}">
                            <span class="page-num ${p == currentPage ? 'active' : ''}"
                                  onclick="location.href='${pageContext.request.contextPath}/members/mypage/myque?page=${p}'"
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