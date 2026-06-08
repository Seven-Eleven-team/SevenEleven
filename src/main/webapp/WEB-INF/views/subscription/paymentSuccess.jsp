<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 완료</title>

<style>

body{
    font-family: Pretendard, sans-serif;
    background:#f5f5f5;
}

.success-box{

    width:700px;

    margin:100px auto;

    background:white;

    padding:50px;

    text-align:center;

    border-radius:20px;

    box-shadow:0 5px 20px rgba(0,0,0,0.15);
}

.success-box h1{
    color:#1e2b50;
}

.success-btn{

    margin-top:30px;

    width:200px;
    height:50px;

    border:none;

    border-radius:10px;

    background:#1e2b50;

    color:white;

    cursor:pointer;
}

</style>

</head>
<body>

<div class="success-box">

    <h1>결제가 완료되었습니다.</h1>

    <p>구독 서비스가 정상 등록되었습니다.</p>

    <button class="success-btn"
            onclick="location.href='/subscription/ott'">

        확인

    </button>

</div>

</body>
</html>