<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>문의작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/support-console.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
<main class="qnaForm-main">
    <div class="qnaForm-box">
        <form action="${pageContext.request.contextPath}/support/qna" method="post">
            <input class="qnaForm-title" type="text" name="title" placeholder="제목">
            <textarea class="qnaForm-content" name="content" placeholder="문의 내용을 입력해주세요"></textarea>
            <div class="qnaForm-btns">
                <button class="qnaForm-btn-prev" type="button" onclick="history.back()">이전으로</button>
                <button class="qnaForm-btn-submit" type="submit" onclick="return validateForm()">작성완료</button>
            </div>
        </form>
    </div>
</main>
<%@ include file="/WEB-INF/views/common/layout/floatingBtn.jspf" %>
<%@ include file="/WEB-INF/views/common/modal/faqModal.jspf" %>
<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>
<script src="${pageContext.request.contextPath}/js/pages/faq.js"></script>
<script>
    function validateForm() {
    const title = document.querySelector('.qnaForm-title').value.trim();
    const content = document.querySelector('.qnaForm-content').value.trim();

    if (title === '') { alert('제목을 입력해주세요.'); return false; }
    if (content === '') { alert('내용을 입력해주세요.'); return false; }

    alert('작성이 완료되었습니다.');
    return true;
}
</script>
</body>
</html>