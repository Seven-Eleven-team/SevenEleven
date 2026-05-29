<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menu" value="myalarm"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>지출메이트 - 알림</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/alarm.css">

    <style>
        .alarm-main {
            padding: 30px;
        }
        .alarm-container {
            border: 3px solid #3b82f6;
            border-radius: 16px;
            padding: 30px;
            min-height: 520px;
            background: white;
        }
        .alarm-title {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 25px;
            color: #1f2937;
        }
        .alarm-item {
            padding: 16px 0;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        .alarm-item:last-child {
            border-bottom: none;
        }
        .highlight-alarm {
            background: #f0f9ff;
            border-left: 5px solid #3b82f6;
            padding-left: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
        }
        .alarm-icon {
            font-size: 22px;
            width: 30px;
        }
        .alarm-text {
            font-size: 15.5px;
            line-height: 1.65;
            flex: 1;
        }
        .danger-text {
            color: #ef4444;
            font-weight: 700;
        }
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #9ca3af;
        }
        .pagination {
            text-align: center;
            margin-top: 40px;
            font-size: 15px;
        }
        .pagination span {
            display: inline-block;
            width: 34px;
            height: 34px;
            line-height: 34px;
            margin: 0 5px;
            border-radius: 50%;
            cursor: pointer;
        }
        .pagination .active {
            background: #3b82f6;
            color: white;
        }
    </style>
</head>
<body class="mypage-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">
    <%@ include file="/WEB-INF/views/common/layout/sidebar.jspf" %>

    <main class="alarm-main">
        <h1 class="page-title">알림</h1>

        <div class="alarm-container">
            <div class="alarm-title">📢 최근 알림</div>

            <c:choose>
                <c:when test="${not empty alarms}">
                    <c:forEach var="alarm" items="${alarms}" varStatus="status">
                        <div class="alarm-item ${alarm.important ? 'highlight-alarm' : ''}">
                            <span class="alarm-icon">${alarm.icon}</span>
                            <span class="alarm-text">
                                ${alarm.message}
                                <c:if test="${alarm.daysLeft > 0}">
                                    <strong class="danger-text">${alarm.daysLeft}일</strong> 남았습니다.
                                </c:if>
                            </span>
                            <span class="alarm-date">
                                <fmt:formatDate value="${alarm.createdAt}" pattern="MM.dd"/>
                            </span>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div style="font-size: 60px; margin-bottom: 16px;">📭</div>
                        <p>새로운 알림이 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <span class="active">1</span>
            <span>2</span>
            <span>3</span>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

</body>
</html>