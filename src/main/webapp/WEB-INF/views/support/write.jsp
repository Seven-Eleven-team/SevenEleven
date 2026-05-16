<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>문의 작성</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f5f5f5;
        }

        .container {
            width: 800px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 10px;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 20px;
        }

        .btn {
            padding: 10px 20px;
            background: #1c355e;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="container">

    <h2>문의 글 작성</h2>

    <form action="/support/qna" method="post">

        <label>제목</label>
        <input type="text" name="title" required>

        <label>내용</label>
        <textarea name="content" rows="10" required></textarea>

        <button type="submit" class="btn">작성완료</button>

    </form>

</div>

</body>
</html>