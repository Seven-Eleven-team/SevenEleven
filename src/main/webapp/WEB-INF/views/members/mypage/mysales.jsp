<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <title>지출메이트 - 내 판매 목록</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/sales.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="container">

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