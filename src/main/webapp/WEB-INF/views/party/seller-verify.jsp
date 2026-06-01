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
        .footer { height: auto !important; }
        .page-wrap { padding: 2rem 1.5rem 3rem; max-width: 900px; width: 100%; margin: 0 auto; padding-top: calc(74px + 2rem); flex: 1; box-sizing: border-box; }
        .breadcrumb { font-size: 12px; color: #666; margin-bottom: 1rem; }
        .card { background: #f0f0f0; border-radius: 12px; padding: 1.5rem 2rem; }
        .card-title { text-align: center; font-size: 20px; font-weight: 500; margin-bottom: 0.5rem; color: #1a1a1a; }
        .card-sub { text-align: center; font-size: 13px; color: #666; margin-bottom: 1.5rem; }
        .pw-wrap { display: flex; flex-direction: column; align-items: center; gap: 1rem; }
        .pw-input-row { display: flex; align-items: center; gap: 10px; width: 100%; max-width: 400px; border-bottom: 1px solid #bbb; padding-bottom: 6px; }
        .pw-input-row input { flex: 1; background: transparent; border: none; outline: none; font-size: 14px; color: #333; padding: 4px 0; }
        .pw-input-row input::placeholder { color: #aaa; font-size: 13px; }
        .btn-sm { background: #1e3a5f; color: #fff; border: none; border-radius: 20px; padding: 4px 12px; font-size: 12px; cursor: pointer; white-space: nowrap; }
        .msg-err { font-size: 11px; color: #e24b4a; display: none; margin-top: 3px; }
        .msg-err.on { display: block; }
        .msg-ok { font-size: 11px; color: #1d6fbf; display: none; margin-top: 3px; }
        .msg-ok.on { display: block; }
        .btn-confirm { background: #1e3a5f; color: #fff; border: none; border-radius: 30px; padding: 10px 40px; font-size: 15px; cursor: pointer; display: none; margin-top: 1.5rem; }
        .btn-confirm.on { display: block; }
        .btn-row { display: flex; justify-content: center; gap: 1rem; margin-top: 2rem; }
        .btn-outline { background: #fff; border: 1px solid #ccc; border-radius: 30px; padding: 10px 40px; font-size: 15px; cursor: pointer; color: #333; }

        /* 팝업 모달 */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.45); z-index: 9999; align-items: center; justify-content: center; }
        .modal-overlay.on { display: flex; }
        .modal-box { background: #fff; border-radius: 16px; padding: 2rem 2.5rem; text-align: center; box-shadow: 0 8px 24px rgba(0,0,0,0.18); max-width: 360px; width: 90%; }
        .modal-icon { font-size: 40px; margin-bottom: 0.8rem; }
        .modal-title { font-size: 18px; font-weight: 700; color: #1a1a1a; margin-bottom: 0.5rem; }
        .modal-desc { font-size: 14px; color: #555; margin-bottom: 1.5rem; line-height: 1.6; }
        .modal-question { font-size: 14px; color: #333; font-weight: 500; margin-bottom: 1rem; }
        .modal-btns { display: flex; gap: 0.8rem; justify-content: center; }
        .modal-btn-yes { background: #1e3a5f; color: #fff; border: none; border-radius: 20px; padding: 8px 28px; font-size: 14px; cursor: pointer; }
        .modal-btn-no { background: #fff; color: #555; border: 1px solid #ccc; border-radius: 20px; padding: 8px 28px; font-size: 14px; cursor: pointer; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<%-- 판매자 이력 없음 팝업 --%>
<div class="modal-overlay" id="no-history-modal">
    <div class="modal-box">
        <div class="modal-icon">⚠️</div>
        <div class="modal-title">판매 등록 이력이 없습니다</div>
        <div class="modal-desc">아직 판매자로 등록된 이력이 없어요.</div>
        <div class="modal-question">판매자 등록을 하러 가시겠습니까?</div>
        <div class="modal-btns">
            <button class="modal-btn-yes" onclick="goRegister()">예</button>
            <button class="modal-btn-no" onclick="goMain()">아니요</button>
        </div>
    </div>
</div>

<div class="page-wrap">
    <p class="breadcrumb">판매자 등록</p>

    <div class="card">
        <h2 class="card-title">본인 인증</h2>
        <p class="card-sub">본인 확인을 위해 비밀번호를 입력해주세요.</p>

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
    const userId = '${sessionScope.LOGIN_USER_ID}';

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
        // 판매자 등록 이력 확인
        fetch(ctx + '/api/party/sellers/' + userId)
            .then(function(res) {
                if (res.ok) {
                    // 판매자 등록 이력 있음 → 프로필로 이동
                    location.href = ctx + '/party/seller-profile';
                } else {
                    // 판매자 등록 이력 없음 → 팝업
                    document.getElementById('no-history-modal').classList.add('on');
                }
            })
            .catch(function() {
                document.getElementById('no-history-modal').classList.add('on');
            });
    }

    function goRegister() {
        location.href = ctx + '/party/seller-register';
    }

    function goMain() {
        location.href = ctx + '/';
    }
</script>
</body>
</html>