<%-- 경로: src/main/webapp/WEB-INF/views/members/mypage/mypost.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 게시글 보기</title>
    <%-- CSS 경로 동기화 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypost.css">
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
            <li class="active">
                <a href="${pageContext.request.contextPath}/members/mypage/mypost">내 게시글 보기</a>
            </li>
            <%-- [수정] 내 문의 링크를 myque.jsp 경로로 변경 --%>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myque">내 문의</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myreport">내 신고 목록</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myalarm">알림</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mysale">내 판매 목록</a></li>
        </ul>
    </aside>

    <main class="mypost-main">
        <h1 class="page-title">내 게시글 보기</h1>

        <div class="mypost-card">
            <div class="post-table">
                <div class="table-header">
                    <span class="col-no">순번</span>
                    <span class="col-title">제목</span>
                    <span class="col-date">게시판</span>
                    <span class="col-view">조회수</span>
                    <span class="col-status">관리</span>
                </div>

                <c:choose>
                    <c:when test="${not empty postList}">
                        <c:forEach var="post" items="${postList}" varStatus="status">
                            <div class="table-row">
                                <span class="col-no">${status.count}.</span>
                                <span class="col-title" onclick="location.href='${pageContext.request.contextPath}/board/detail?id=${post.id}'" style="cursor:pointer;">
                                    <c:out value="${post.title}" />
                                </span>
                                <span class="col-date">${post.boardName}</span>
                                <span class="col-view">${post.viewCount}</span>
                                <div class="row-right">
                                    <span class="status-btn" onclick="location.href='${pageContext.request.contextPath}/board/edit?id=${post.id}'" style="cursor:pointer;">수정</span>
                                    <span class="delete-btn" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/board/delete?id=${post.id}'" style="cursor:pointer;">삭제하기</span>
                                </div>
                            </div>
                        </c:forEach>

                        <%-- 10줄을 채우기 위한 빈 로직 --%>
                        <c:if test="${postList.size() < 10}">
                            <c:forEach begin="1" end="${10 - postList.size()}">
                                <div class="table-row"></div>
                            </c:forEach>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="table-row" style="justify-content: center; color: #999;">작성한 게시글이 없습니다.</div>
                        <c:forEach begin="1" end="9">
                            <div class="table-row"></div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="pagination">
                <c:choose>
                    <c:when test="${not empty totalPages && totalPages > 0}">
                        <c:forEach var="p" begin="1" end="${totalPages}">
                            <span class="page-num ${p == currentPage ? 'active' : ''}"
                                  onclick="location.href='${pageContext.request.contextPath}/members/mypage/mypost?page=${p}'"
                                  style="cursor:pointer; margin: 0 5px;">${p}</span>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <span class="page-num active">1</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>

</body>
</html>