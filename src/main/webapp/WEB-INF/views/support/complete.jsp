<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>문의 완료</title>
    <style>
        body {
            text-align: center;
            margin-top: 100px;
            font-family: Arial;
        }

        .box {
            background: white;
            padding: 50px;
            border-radius: 10px;
            display: inline-block;
        }

        button {
            margin-top: 20px;
            padding: 10px 20px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="box">
    <h2>문의가 정상적으로 접수되었습니다 😊</h2>
    <button onclick="location.href='/support/qna'">목록으로 가기</button>
</div>

</body>
</html>