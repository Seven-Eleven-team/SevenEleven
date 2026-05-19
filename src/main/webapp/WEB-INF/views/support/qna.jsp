<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>고객센터</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f5f5f5;
        }

        .container {
            width: 900px;
            margin: 50px auto;
            background: white;
            padding: 50px;
            border-radius: 15px;
            text-align: center;
            position: relative;
        }

        .title {
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 50px;
        }

        .menu {
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .item {
            cursor: pointer;
            transition: 0.2s;
        }

        .item:hover {
            transform: scale(1.1);
        }

        .item img {
            width: 120px;
        }

        .item p {
            margin-top: 15px;
            font-weight: bold;
            font-size: 18px;
        }

        /* 🤖 오른쪽 아래 버튼 */
        .chatbot {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 70px;
            height: 70px;
            cursor: pointer;
        }

        .chatbot img {
            width: 100%;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">1:1 문의 시 빠르게 도와드립니다!</div>

    <div class="menu">

        <!-- 1:1 문의 -->
        <div class="item" onclick="location.href='/support/qna/write'">
            <img src="/img/Inquiry.png">
            <p>1:1 문의</p>
        </div>

        <!-- 문의 글 작성 -->
        <div class="item" onclick="location.href='/support/qna/write'">
            <img src="/img/FaQ.png">
            <p>문의 글 작성</p>
        </div>

    </div>
</div>

<!-- 🔥 오른쪽 하단 아이콘 2개 -->
<div class="floating-icons">

    <!-- 🤖 챗봇 -->
    <div class="icon">
        <img src="/img/AI.png">
    </div>

    <!-- 💬 1:1 문의 -->
    <div class="icon">
        <img src="/img/Inquiry.png">
    </div>

</div>
</body>
</html>