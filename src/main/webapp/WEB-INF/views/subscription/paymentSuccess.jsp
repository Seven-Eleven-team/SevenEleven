<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결제 완료</title>

    <link rel="stylesheet"
          as="style"
          crossorigin
          href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/subscription.css">

    <style>
        body {
            font-family: Pretendard, sans-serif;
            background: #f5f5f5;
            margin: 0;
        }

        .success-page {
            min-height: calc(100vh - 220px);
            padding: 120px 20px 80px;
            box-sizing: border-box;
        }

        .success-box {
            width: 700px;
            max-width: 100%;
            margin: 0 auto;
            background: white;
            padding: 50px;
            text-align: center;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
            box-sizing: border-box;
        }

        .success-box h1 {
            color: #1e2b50;
            margin-bottom: 16px;
        }

        .success-box p {
            color: #555;
            font-size: 16px;
        }

        .success-btn {
            margin-top: 30px;
            width: 200px;
            height: 50px;
            border: none;
            border-radius: 10px;
            background: #1e2b50;
            color: white;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
        }

        .success-btn:hover {
            background: #15203d;
        }
    </style>
</head>

<body>

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<main class="success-page">
    <div class="success-box">
        <h1>결제가 완료되었습니다.</h1>
        <p>구독 서비스가 정상 등록되었습니다.</p>

        <button class="success-btn"
                onclick="location.href='${pageContext.request.contextPath}/subscription/ott'">
            확인
        </button>
    </div>
</main>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/layout/floatingBtn.jspf" %>

<script src="${pageContext.request.contextPath}/js/nav-wave.js"></script>

</body>
</html>