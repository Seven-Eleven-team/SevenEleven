<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>문의작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/support-console.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
    <main class="qnaForm-main">
        <div class="qnaForm-box">
            <input class="qnaForm-title" type="text" placeholder="제목">
            <textarea class="qnaForm-content" name="content" placeholder="문의 내용을 입력해주세요"></textarea>
            <div class="qnaForm-btns">
                <button class="qnaForm-btn-prev" type="button"> 이전으로 </button>
                <button class="qnaForm-btn-submit"> 작성완료 </button>
            </div>
        </div>
    </main>
<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
</body>
</html>