<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>지출메이트 - 내 게시글 보기</title>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypost.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="container">

    <%@ include file="/WEB-INF/views/common/layout/sidebar.jspf" %>

    <!-- 메인 -->
    <main class="mypost-main">

        <!-- 페이지 제목 -->
        <h1 class="page-title">
            내 게시글 보기
        </h1>

        <div class="mypost-card">

            <!-- 테이블 -->
            <div class="post-table">

                <!-- 헤더 -->
                <div class="table-header">

                    <span class="col-no">
                        순번
                    </span>

                    <span class="col-title">
                        제목
                    </span>

                    <span class="col-date">
                        게시판
                    </span>

                    <span class="col-view">
                        조회수
                    </span>

                    <span class="col-status">
                        관리
                    </span>

                </div>

                <!-- 게시글 -->
                <div class="table-row">

                    <span class="col-no">
                        1.
                    </span>

                    <span class="col-title">
                        안녕하세요
                    </span>

                    <span class="col-date">
                        자유
                    </span>

                    <span class="col-view">
                        3
                    </span>

                    <div class="row-right">

                        <span class="status-btn">
                            수정
                        </span>

                        <span class="delete-btn">
                            삭제하기
                        </span>

                    </div>

                </div>

                <!-- 게시글 -->
                <div class="table-row">

                    <span class="col-no">
                        2.
                    </span>

                    <span class="col-title">
                        안녕하세요
                    </span>

                    <span class="col-date">
                        비밀
                    </span>

                    <span class="col-view">
                        5
                    </span>

                    <div class="row-right">

                        <span class="status-btn">
                            수정
                        </span>

                        <span class="delete-btn">
                            삭제하기
                        </span>

                    </div>

                </div>

                <!-- 빈 줄 -->
                <div class="table-row"></div>
                <div class="table-row"></div>
                <div class="table-row"></div>
                <div class="table-row"></div>
                <div class="table-row"></div>
                <div class="table-row"></div>
                <div class="table-row"></div>
                <div class="table-row"></div>

            </div>

            <!-- 페이지 -->
            <div class="pagination">

                1

            </div>

        </div>

    </main>

</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

</body>
</html>