<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>고객센터</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/support-hub.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
    <!-- 본문 내용 -->
    <main class="support-main">
        <div class="support-box">
            <h2> 1:1 문의 시 빠르게 도와드립니다! </h2>
            <div class="support-cards">
                <div class="support-card">
                    <a href="#">
                        <i class="bi bi-chat-left-dots"></i>
                        <p> 1:1 문의 </p>
                    </a>
                </div>
                <div class="support-card">
                    <a href="#">
                        <i class="bi bi-megaphone"></i>
                        <p> 문의 글 작성 </p>
                    </a>
                </div>
            </div>
        </div>

    </main>
    <%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
</body>
</html>
