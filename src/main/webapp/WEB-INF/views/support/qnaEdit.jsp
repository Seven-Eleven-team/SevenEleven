<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>문의수정</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
<main class="qnaEdit-main">
    <input class="qnaEdit-title" type="text" placeholder="제목">
    <textarea class="qnaEdit-content" name="content" placeholder="문의 내용을 입력해주세요"></textarea>
    <div class="qnaEdit-btns">
        <button class="qnaEdit-btn-prev"> 이전으로 </button>
        <button class="qnaEdit-btn-submit"> 수정완료 </button>
    </div>
</main>
<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
</body>
</html>