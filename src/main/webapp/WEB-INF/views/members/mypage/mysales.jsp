<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="menu" value="mysales"/>
<!DOCTYPE html>
<html lang="ko">

<head>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <title>지출메이트 - 내 판매 목록</title>

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

        <div class="sales-header-title">

            내 판매 목록

        </div>

        <div class="sales-main-box">

            <div class="sales-empty-center">

                <h1 class="empty-msg">

                    판매자 등록을 먼저 해주세요!

                </h1>

                <button class="register-btn"
                        onclick="location.href='${pageContext.request.contextPath}/mysaleslist'">

                    판매자 등록하기

                </button>

            </div>

        </div>

    </main>

</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

</body>
</html>