<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>본인 인증</title>
    <style>
        body { background: #e8e8e8; min-height: 100vh; display: flex; flex-direction: column; }
        .site-header { opacity: 1 !important; transform: translateY(0) !important; background: rgba(25, 59, 96, 0.96) !important; }
        .footer { height: 90px !important; min-height: 90px !important; }
        .page-wrap { padding: 2.5rem 1.5rem; max-width: 850px; width: 100%; margin: 0 auto; padding-top: calc(74px + 3rem); flex: 1; display: flex; flex-direction: column; }
        .breadcrumb { font-size: 13px; color: #666; margin-bottom: 1.2rem; }
        .card { background: #f0f0f0; border-radius: 16px; padding: 4rem 3.5rem; box-shadow: 0 4px 14px rgba(0,0,0,0.06); width: 100%; box-sizing: border-box; min-height: 450px; display: flex; flex-direction: column; justify-content: space-between; }
        .card-title { text-align: center; font-size: 26px; font-weight: 600; margin-bottom: 0.8rem; color: #1a1a1a; }
        .card-sub { text-align: center; font-size: 15px; color: #666; margin-bottom: 3rem; }
        .pw-wrap { display: flex; flex-direction: column; align-items: center; gap: 1.2rem; flex: 1; justify-content: center; }
        .pw-input-row { display: flex; align-items: center; gap: 15px; width: 100%; max-width: 450px; border-bottom: 2px solid #bbb; padding-bottom: 8px; }
        .pw-input-row input { flex: 1; background: transparent; border: none; outline: none; font-size: 16px; color: #333; padding: 6px 0; }
        .pw-input-row input::placeholder { color: #aaa; }
        .btn-sm { background: #1e3a5f; color: #fff; border: none; border-radius: 20px; padding: 8px 20px; font-size: 14px; cursor: pointer; white-space: nowrap; }
        .msg-err { font-size: 14px; color: #e24b4a; display: none; margin-top: 6px; }
        .msg-err.on { display: block; }
        .msg-ok { font-size: 14px; color: #1d6fbf; display: none; margin-top: 6px; }
        .msg-ok.on { display: block; }
        .btn-confirm { background: #1e3a5f; color: #fff; border: none; border-radius: 30px; padding: 12px 60px; font-size: 15px; cursor: pointer; display: none; margin-top: 1.5rem; }
        .btn-confirm.on { display: block; }
        .btn-row { display: flex; justify-content: center; gap: 1.2rem; margin-top: 2.5rem; }
        .btn-outline { background: #fff; border: 1px solid #ccc; border-radius: 30px; padding: 12px 50px; font-size: 15px; cursor: pointer; color: #333; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="page-wrap">
    <p class="breadcrumb">판매자 등록</p>

    <div class="card">
        <div>
            <h2 class="card-title">본인 인증</h2>
            <p class="card-sub">본인 확인을 위해 비밀번호를 입력해주세요.</p>
        </div>

        <div class="pw-wrap">
            <div class="pw-input-row">
                <input type="password" id="password" placeholder="비밀번호를 입력해주세요.">
                <button class="btn-sm" onclick="verifyPw()">확인</button>
            </div>
            <span class="msg-err" id="pw-err">비밀번호를 잘못 입력하셨습니다.</span>
            <span class="msg-ok" id="pw-ok">인증되었습니다!</span>
            <button class="btn-confirm" id="btn-confirm" onclick="goProfile()">인증 확인</button>
        </div>

        <div class="btn-row">
            <button onclick="history.back()" class="btn-outline">이전으로</button>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>
    const ctx = '${pageContext.request.contextPath}';

    function verifyPw() {
        const password = document.getElementById('password').value;
        if (!password) { alert('비밀번호를 입력해주세요.'); return; }

        fetch(ctx + '/api/party/sellers/verify-password', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({password: password})
        }).then(res => res.text()).then(text => {
            if (text.includes('인증되었습니다')) {
                document.getElementById('pw-err').classList.remove('on');
                document.getElementById('pw-ok').classList.add('on');
                document.getElementById('btn-confirm').classList.add('on');
            } else {
                document.getElementById('pw-ok').classList.remove('on');
                document.getElementById('btn-confirm').classList.remove('on');
                document.getElementById('pw-err').classList.add('on');
            }
        });
    }

    function goProfile() {
        location.href = ctx + '/party/seller-profile';
    }
</script>
</body>
</html>