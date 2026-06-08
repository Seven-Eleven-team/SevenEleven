<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>본인 인증</title>

    <style>
        body {
            background: #e8e8e8;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .site-header {
            opacity: 1 !important;
            transform: translateY(0) !important;
            background: rgba(25, 59, 96, 0.96) !important;
        }

        .footer {
            height: auto !important;
        }

        .page-wrap {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
            padding: 120px 1.5rem 4rem;
            box-sizing: border-box;
        }

        .card {
            background: #f0f0f0;
            border-radius: 18px;
            padding: 4rem 4.5rem;
            width: 100%;
            max-width: 800px;
            box-sizing: border-box;
        }

        .breadcrumb {
            font-size: 15px;
            color: #666;
            margin-bottom: 1.6rem;
        }

        .card-title {
            text-align: center;
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #1a1a1a;
        }

        .card-sub {
            text-align: center;
            font-size: 17px;
            color: #666;
            margin-bottom: 3rem;
        }

        .pw-wrap {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1.3rem;
        }

        .pw-input-row {
            display: flex;
            align-items: center;
            gap: 14px;
            width: 100%;
            max-width: 580px;
            border-bottom: 1px solid #aaa;
            padding-bottom: 12px;
        }

        .pw-input-row input {
            flex: 1;
            background: transparent;
            border: none;
            outline: none;
            font-size: 18px;
            color: #333;
            padding: 10px 0;
        }

        .pw-input-row input::placeholder {
            color: #aaa;
            font-size: 16px;
        }

        .btn-sm {
            background: #1e3a5f;
            color: #fff;
            border: none;
            border-radius: 24px;
            padding: 8px 22px;
            font-size: 14px;
            cursor: pointer;
            white-space: nowrap;
        }

        .msg-err {
            font-size: 14px;
            color: #e24b4a;
            display: none;
            margin-top: 3px;
        }

        .msg-err.on {
            display: block;
        }

        .btn-row {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2.8rem;
        }

        .btn-outline {
            background: #fff;
            border: 1px solid #ccc;
            border-radius: 32px;
            padding: 13px 56px;
            font-size: 17px;
            cursor: pointer;
            color: #333;
        }

        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.45);
            z-index: 9999;
            align-items: center;
            justify-content: center;
        }

        .modal-overlay.on {
            display: flex;
        }

        .modal-box {
            background: #fff;
            border-radius: 16px;
            padding: 2.2rem 2.7rem;
            text-align: center;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.18);
            max-width: 390px;
            width: 90%;
        }

        .modal-title {
            font-size: 20px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 1.7rem;
        }

        .modal-desc {
            font-size: 15px;
            color: #555;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .modal-question {
            font-size: 15px;
            color: #333;
            font-weight: 500;
            margin-bottom: 1.1rem;
        }

        .modal-btns {
            display: flex;
            gap: 0.9rem;
            justify-content: center;
        }

        .modal-btn-yes {
            background: #1e3a5f;
            color: #fff;
            border: none;
            border-radius: 22px;
            padding: 9px 30px;
            font-size: 15px;
            cursor: pointer;
        }

        .modal-btn-no {
            background: #fff;
            color: #555;
            border: 1px solid #ccc;
            border-radius: 22px;
            padding: 9px 30px;
            font-size: 15px;
            cursor: pointer;
        }

        @media (max-width: 640px) {
            .page-wrap {
                align-items: flex-start;
                padding: 140px 1rem 2.5rem;
            }

            .card {
                padding: 2.5rem 1.7rem;
                max-width: 100%;
                border-radius: 16px;
            }

            .breadcrumb {
                font-size: 14px;
            }

            .card-title {
                font-size: 25px;
            }

            .card-sub {
                font-size: 14px;
                margin-bottom: 2.2rem;
            }

            .pw-input-row {
                max-width: 100%;
                gap: 10px;
            }

            .pw-input-row input {
                font-size: 16px;
            }

            .pw-input-row input::placeholder {
                font-size: 14px;
            }

            .btn-sm {
                padding: 7px 17px;
                font-size: 13px;
            }

            .btn-outline {
                padding: 12px 42px;
                font-size: 15px;
            }

            .modal-btns {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="modal-overlay" id="success-modal">
    <div class="modal-box">
        <div class="modal-title">인증되었습니다 !</div>

        <div class="modal-btns">
            <button class="modal-btn-no" onclick="closeSuccessModal()">이전으로</button>
            <button class="modal-btn-yes" onclick="goProfile()">인증 확인</button>
        </div>
    </div>
</div>

<div class="modal-overlay" id="no-history-modal">
    <div class="modal-box">
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
    <div class="card">
        <p class="breadcrumb">판매자 등록</p>

        <h2 class="card-title">본인 인증</h2>
        <p class="card-sub">본인 확인을 위해 비밀번호를 입력해주세요.</p>

        <div class="pw-wrap">
            <div class="pw-input-row">
                <input type="password" id="password" placeholder="비밀번호를 입력해주세요.">
                <button class="btn-sm" onclick="verifyPw()">확인</button>
            </div>

            <span class="msg-err" id="pw-err">비밀번호를 잘못 입력하셨습니다.</span>
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
        const errMsg = document.getElementById('pw-err');
        const successModal = document.getElementById('success-modal');

        if (!password) {
            alert('비밀번호를 입력해주세요.');
            return;
        }

        fetch(ctx + '/api/party/sellers/verify-password', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({password: password})
        })
            .then(res => res.text())
            .then(text => {
                if (text.includes('인증되었습니다')) {
                    errMsg.classList.remove('on');
                    successModal.classList.add('on');
                } else {
                    successModal.classList.remove('on');
                    errMsg.classList.add('on');
                }
            })
            .catch(function() {
                successModal.classList.remove('on');
                errMsg.classList.add('on');
            });
    }

    function closeSuccessModal() {
        document.getElementById('success-modal').classList.remove('on');
    }

    function goProfile() {
        fetch(ctx + '/api/party/sellers/' + userId)
            .then(function(res) {
                document.getElementById('success-modal').classList.remove('on');

                if (res.ok) {
                    location.href = ctx + '/party/seller-profile';
                } else {
                    document.getElementById('no-history-modal').classList.add('on');
                }
            })
            .catch(function() {
                document.getElementById('success-modal').classList.remove('on');
                document.getElementById('no-history-modal').classList.add('on');
            });
    }

    function goRegister() {
        location.href = ctx + '/party/seller-register';
    }

    function goMain() {
        location.href = ctx + '/';
    }

    document.body.classList.add('is-header-ready');
</script>
</body>
</html>