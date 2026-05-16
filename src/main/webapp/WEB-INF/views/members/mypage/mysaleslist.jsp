<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <title>지출메이트 - 내 판매 목록 리스트</title>

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

            <div class="sales-list-content">

                <!-- 판매 목록 1 -->
                <div class="sale-item">

                    <div class="item-left-group">

                        <div class="item-name">

                            유튜브 프리미엄

                        </div>

                        <div class="item-logo-area">

                            <img src="${pageContext.request.contextPath}/images/youtube_premium_logo.png"
                                 alt="유튜브 로고">

                        </div>

                        <div class="item-desc-text">

                            판매상태 : 판매중
                            <br>
                            가격 : 7,800원

                        </div>

                    </div>

                    <div class="item-right-stat">

                        3명 구매

                    </div>

                </div>

                <!-- 판매 목록 2 -->
                <div class="sale-item">

                    <div class="item-left-group">

                        <div class="item-name">

                            넷플릭스

                        </div>

                        <div class="item-logo-area">

                            <img src="${pageContext.request.contextPath}/images/netflix_logo.png"
                                 alt="넷플릭스 로고">

                        </div>

                        <div class="item-desc-text">

                            판매상태 : 판매완료
                            <br>
                            가격 : 4,500원

                        </div>

                    </div>

                    <div class="item-right-stat">

                        4명 구매

                    </div>

                </div>

            </div>

            <!-- 페이지네이션 -->
            <div class="pagination-area">

                1

            </div>

        </div>

    </main>

</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

</body>
</html>