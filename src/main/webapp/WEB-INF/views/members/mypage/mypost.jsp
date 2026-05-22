<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menu" value="mypost"/>

<!DOCTYPE html>
<html lang="ko">

<head>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <title>지출메이트 - 내 게시글 보기</title>

    <!-- 공통 마이페이지 CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypost.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <!-- 게시글 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypost.css?v=3">

<style>
 /* 1. 마이페이지 공통 레이아웃 틀 고정 (사이드바 + 메인 정렬) */
        .mypage-container {
            display: flex !important;
            flex-direction: row !important;
            align-items: stretch !important;
            gap: 26px !important;
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 0;
        }

        /* 2. 공통 사이드바 크기 및 위아래 중앙 가로막 정렬 스타일링 */
        .mypage-sidebar {
            width: 250px !important;
            min-width: 250px !important;
            height: auto !important;
            align-self: stretch !important;
            background: #ffffff !important;
            border: 1px solid #dddddd !important;
            border-radius: 20px !important;
            padding: 0 !important;
            display: flex !important;
            align-items: center !important;
        }
        .mypage-sidebar ul {
            display: flex !important;
            flex-direction: column !important;
            justify-content: center !important;
            list-style: none !important;
            padding: 0 !important;
            margin: 0 !important;
            width: 100% !important;
        }
        .mypage-sidebar li {
            width: 100% !important;
            display: block !important;
        }
        .mypage-sidebar li a {
            display: flex !important;
            justify-content: center !important;
            align-items: center !important;
            width: 100% !important;
            height: 55px !important;
            padding: 0 !important;
            line-height: 1 !important;
            text-align: center !important;
            font-size: 16px !important;
            font-weight: 500 !important;
            color: #111111 !important;
            transition: all 0.2s ease !important;
        }
        .mypage-sidebar li a:hover {
            background: #fafafa !important;
            color: #ff4d4d !important;
        }
        .mypage-sidebar li.active a {
            color: #ff4d4d !important;
            font-weight: 700 !important;
        }

</style>
</head>

<body class="mypage-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="container">

    <!-- ✅ 다른 페이지들과 완전히 동일한 사이드바 include -->
    <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>

    <!-- 메인 -->
    <main class="mypost-main" style="flex: 1;">

        <h1 class="page-title">
            내 게시글 보기
        </h1>

        <section class="mypost-card">

            <div class="post-table">

                <!-- 헤더 -->
                <div class="table-header">

                    <div class="col-no">순번</div>
                    <div class="col-title">제목</div>
                    <div class="col-date">게시판</div>
                    <div class="col-view">조회수</div>
                    <div class="col-status">관리</div>

                </div>

                <!-- row 1 -->
                <div class="table-row">

                    <div class="col-no">1</div>
                    <div class="col-title">안녕하세요</div>
                    <div class="col-date">자유</div>
                    <div class="col-view">3</div>

                    <div class="row-right">
                        <button type="button" class="status-btn">수정</button>
                        <button type="button" class="delete-btn">삭제</button>
                    </div>

                </div>

                <!-- row 2 -->
                <div class="table-row">

                    <div class="col-no">2</div>
                    <div class="col-title">반갑습니다</div>
                    <div class="col-date">비밀</div>
                    <div class="col-view">5</div>

                    <div class="row-right">
                        <button type="button" class="status-btn">수정</button>
                        <button type="button" class="delete-btn">삭제</button>
                    </div>

                </div>

                <!-- empty -->
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>

            </div>

            <div class="pagination">
                1
            </div>

        </section>

    </main>

</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

</body>
</html>