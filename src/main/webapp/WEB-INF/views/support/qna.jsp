<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>문의목록</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
    <main class="qna-main">
        <table class="qna-table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td><a href="#">문의내용</a></td>
                    <td>user</td>
                    <td>2026.05.08</td>
                    <td>처리중</td>
                </tr>
            </tbody>
        </table>
    </main>
<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
</body>
</html>