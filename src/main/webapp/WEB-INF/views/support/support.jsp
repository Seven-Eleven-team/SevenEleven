<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
    <title>고객센터</title>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/support-hub.css?v=1">
</head>
<body>

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<main class="support-main">
    <div class="support-box">
        <h2>1:1 문의 시 빠르게 도와드립니다!</h2>

        <div class="support-cards">
            <div class="support-card">
                <a href="${pageContext.request.contextPath}/support/qna" data-auth-required="true">
                    <i class="bi bi-chat-left-dots"></i>
                    <p>1:1 문의</p>
                </a>
            </div>

            <div class="support-card">
                <a href="${pageContext.request.contextPath}/support/qna/write" data-auth-required="true">
                    <i class="bi bi-megaphone"></i>
                    <p>문의 글 작성</p>
                </a>
            </div>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/modal/authModal.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

</body>
</html>