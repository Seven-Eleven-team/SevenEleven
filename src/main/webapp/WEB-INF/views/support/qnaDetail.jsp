<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>문의상세</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
    <main class="qnaDetail-main">
        <h2>문의제목</h2>
        <p>작성자</p>
        <p>작성일</p>
        <p>상태</p>
        <p>내용</p>
        <div class="qnaDetail-answer">
            <!-- 관리자 답변 -->
        </div>
    </main>
<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
</body>
</html>