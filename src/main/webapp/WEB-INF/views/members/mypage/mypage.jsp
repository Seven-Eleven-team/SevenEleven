<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menu" value="mypage"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>지출메이트 - 마이페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <style>
        .cancel-modal-overlay, .account-modal-overlay {
            display: none;
            position: fixed; top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.55);
            z-index: 3000;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(8px);
        }

        .account-modal-content {
            background: white;
            padding: 45px 40px 35px;
            border-radius: 20px;
            width: 100%;
            max-width: 520px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.18);
            position: relative;
            animation: modalPop 0.3s ease;
        }

        @keyframes modalPop {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .close-modal {
            position: absolute; top: 20px; right: 25px;
            font-size: 28px; cursor: pointer; color: #aaaaaa;
            transition: color 0.2s;
        }
        .close-modal:hover { color: #555; }

        .account-modal-content h2 {
            text-align: center; margin-bottom: 32px;
            font-size: 26px; font-weight: 700; color: #1f2937;
        }

        .form-group { margin-bottom: 24px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; color: #374151; }

        select, input[type="text"] {
            width: 100%; padding: 14px 16px; border: 1.5px solid #e5e7eb;
            border-radius: 12px; font-size: 16px; transition: all 0.2s;
        }
        select:focus, input[type="text"]:focus {
            outline: none; border-color: #4f46e5;
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        #accountHelp { font-size: 14.5px; color: #4f46e5; margin-top: 6px; font-weight: 500; min-height: 22px; }
        .error-text { color: #ef4444; font-size: 14.5px; margin-top: 8px; font-weight: 500; }

        .add-account-btn, .change-account-btn {
            background-color: #4f46e5; color: white; border: none;
            padding: 15px; border-radius: 12px; font-weight: 700;
            cursor: pointer; width: 100%; font-size: 16.5px;
            transition: all 0.3s;
        }
        .add-account-btn:hover, .change-account-btn:hover {
            background-color: #4338ca; transform: translateY(-3px);
        }

        .account-info {
            background: #f8fafc;
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 16px;
        }
        .account-top {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .main-bank-logo {
            width: 48px; height: 48px;
            background: #4f46e5;
            color: white;
            font-size: 22px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }
        .account-notice {
            margin-top: 12px;
            font-size: 14.5px;
            color: #555;
        }

        .alert-message { padding: 14px 20px; border-radius: 12px; margin: 15px 0; text-align: center; font-weight: 500; }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body class="mypage-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">
    <%@ include file="/WEB-INF/views/common/layout/sidebar.jspf" %>

    <main class="dashboard">
        <!-- 성공 / 실패 메시지 -->
        <c:if test="${not empty successMessage}">
            <div class="alert-message success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert-message error">${errorMessage}</div>
        </c:if>

        <section class="profile-combined-card">

            <!-- 내 정보 -->
            <div class="info-side">
                <h3 class="card-title-center">내 정보</h3>
                <div class="info-body">
                    <div class="profile-section">
                        <div class="profile-img-box">
                            <img src="${pageContext.request.contextPath}/images/profile.jpg" alt="프로필">
                        </div>
                        <button class="edit-info-btn" onclick="location.href='${pageContext.request.contextPath}/mypage/profile'">
                            내 정보 수정
                        </button>
                    </div>
                    <div class="text-area">
                        <div class="info-row"><span>닉네임</span><strong>${summary.nickname}</strong></div>
                        <div class="info-row"><span>생년월일</span><strong>${summary.birthDate} (${summary.gender})</strong></div>
                        <div class="info-row"><span>이메일</span><strong>${summary.email}</strong></div>
                        <div class="withdraw-container">
                            <a href="#" class="withdraw-link" onclick="openModal(); return false;">회원 탈퇴</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== 입금 계좌 영역 ==================== -->
            <div class="alert-side">
                <h3 class="card-title-center">입금 계좌</h3>
                <div class="single-account-box">

                    <!-- 계좌 등록된 경우 -->
                    <c:if test="${not empty accounts}">
                        <c:set var="primaryAcc" value="${accounts[0]}" />
                        <div class="account-info">
                            <div class="account-top">
                                <div class="main-bank-logo">
                                    ${primaryAcc.bankName != null ? primaryAcc.bankName.substring(0,1) : '?'}
                                </div>
                                <div class="main-bank-info">
                                    <strong>${primaryAcc.bankName}</strong>
                                    <span>${primaryAcc.accountNumber}</span>
                                </div>
                            </div>
                            <div class="account-notice">
                                구독 환불 및 정산 시 사용되는 대표 계좌입니다.
                            </div>
                            <button class="change-account-btn"
                                    onclick="location.href='${pageContext.request.contextPath}/mypage/accounts'">
                                계좌 변경하기
                            </button>
                        </div>
                    </c:if>

                    <!-- 계좌 없는 경우 -->
                    <c:if test="${empty accounts}">
                        <p style="text-align:center; padding:60px 20px; color:#888; font-size:15.5px;">
                            등록된 계좌가 없습니다.
                        </p>
                        <button class="add-account-btn" onclick="openAccountModal()">
                            + 새 계좌 등록하기
                        </button>
                    </c:if>
                </div>
            </div>
        </section>

        <div class="bottom-row">
            <section class="card sub-card">...</section>
            <section class="card goal-card">...</section>
        </div>
    </main>
</div>

<!-- ==================== 계좌 등록 모달 ==================== -->
<div id="accountModalOverlay" class="account-modal-overlay">
    <div class="account-modal-content">
        <span class="close-modal" onclick="closeAccountModal()">&times;</span>
        <h2>새 계좌 등록</h2>

        <form id="accountForm" action="${pageContext.request.contextPath}/mypage/accounts" method="post" onsubmit="return validateAccountForm()">

            <div class="form-group">
                <label for="bankName">은행 선택</label>
                <select name="bankName" id="bankName" required onchange="updateAccountHelp()">
                    <option value="">-- 은행 선택 --</option>
                    <option value="국민은행">국민은행</option>
                    <option value="신한은행">신한은행</option>
                    <option value="우리은행">우리은행</option>
                    <option value="하나은행">하나은행</option>
                    <option value="농협은행">농협은행</option>
                    <option value="카카오뱅크">카카오뱅크</option>
                    <option value="토스뱅크">토스뱅크</option>
                </select>
            </div>

            <div class="form-group">
                <label for="accountNumber">계좌번호
                    <span style="font-size:13px; color:#666;">(숫자만 입력)</span>
                </label>
                <input type="text" name="accountNumber" id="accountNumber"
                       placeholder="예: 94580201227691"
                       maxlength="30" required oninput="handleAccountInput(this)">
                <div id="accountHelp"></div>
                <div id="accountError" class="error-text"></div>
            </div>

            <div class="form-group">
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                    <input type="checkbox" name="isPrimary" value="true">
                    <span>이 계좌를 대표 계좌로 설정</span>
                </label>
            </div>

            <button type="submit" class="add-account-btn">계좌 등록하기</button>
        </form>
    </div>
</div>

<!-- 기존 모달들 -->
<div id="modalOverlay" class="modal-overlay">...</div>
<div id="cancelModalOverlay" class="cancel-modal-overlay">...</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>
// ==================== 은행 자동 감지 ====================
const bankNameMap = {
    "국민": "국민은행", "국민은행": "국민은행",
    "신한": "신한은행", "신한은행": "신한은행",
    "우리": "우리은행", "우리은행": "우리은행",
    "하나": "하나은행", "하나은행": "하나은행",
    "농협": "농협은행", "농협은행": "농협은행",
    "카카오": "카카오뱅크", "카카오뱅크": "카카오뱅크",
    "토스": "토스뱅크", "토스뱅크": "토스뱅크"
};

const bankRules = {
    "국민은행": [12, 14],
    "신한은행": [11, 12],
    "우리은행": [13],
    "하나은행": [12, 14],
    "농협은행": [11, 13],
    "카카오뱅크": [13],
    "토스뱅크": [12]
};

function getDigitsOnly(str) {
    return str.replace(/[^0-9]/g, '');
}

function handleAccountInput(input) {
    let value = input.value.trim();
    const errorEl = document.getElementById('accountError');
    errorEl.textContent = '';

    let detectedBank = null;
    let accountPart = value;

    for (let key in bankNameMap) {
        if (value.startsWith(key)) {
            detectedBank = bankNameMap[key];
            accountPart = value.substring(key.length).trim();
            break;
        }
    }

    const digits = getDigitsOnly(accountPart);
    input.value = digits;

    if (detectedBank) {
        document.getElementById('bankName').value = detectedBank;
    }
    updateAccountHelp();
}

function updateAccountHelp() {
    const bankName = document.getElementById('bankName').value;
    const accountInput = document.getElementById('accountNumber').value.trim();
    const digits = getDigitsOnly(accountInput);
    const helpEl = document.getElementById('accountHelp');

    if (!bankName) {
        helpEl.textContent = '';
        return;
    }

    const allowed = bankRules[bankName];
    if (allowed && allowed.includes(digits.length) && digits.length >= 10) {
        helpEl.textContent = '';
    } else {
        helpEl.innerHTML = `<strong>${bankName} 계좌번호는 ${allowed.join('~')}자리</strong> 입니다.`;
    }
}

function validateAccountForm() {
    const bankName = document.getElementById('bankName').value;
    let accountInput = document.getElementById('accountNumber').value.trim();
    const errorEl = document.getElementById('accountError');

    const digitsOnly = getDigitsOnly(accountInput);

    if (!bankName) {
        errorEl.textContent = '은행을 선택해주세요.';
        return false;
    }
    if (digitsOnly.length === 0) {
        errorEl.textContent = '계좌번호를 입력해주세요.';
        return false;
    }

    const allowed = bankRules[bankName];
    if (allowed && !allowed.includes(digitsOnly.length)) {
        errorEl.textContent = `${bankName} 계좌번호는 ${allowed.join('~')}자리입니다.`;
        return false;
    }

    document.getElementById('accountNumber').value = digitsOnly;
    return true;
}

function openAccountModal() {
    document.getElementById('accountModalOverlay').style.display = 'flex';
    setTimeout(() => {
        document.getElementById('accountForm').reset();
        document.getElementById('accountHelp').textContent = '';
        document.getElementById('accountError').textContent = '';
    }, 100);
}

function closeAccountModal() {
    document.getElementById('accountModalOverlay').style.display = 'none';
}

function openModal() { document.getElementById('modalOverlay').style.display = 'flex'; }
function closeModal() { document.getElementById('modalOverlay').style.display = 'none'; }
function openCancelModal() { document.getElementById('cancelModalOverlay').style.display = 'flex'; }
function closeCancelModal() { document.getElementById('cancelModalOverlay').style.display = 'none'; }

window.onclick = function(event) {
    if (event.target.id === 'accountModalOverlay') closeAccountModal();
    if (event.target.id === 'modalOverlay') closeModal();
    if (event.target.id === 'cancelModalOverlay') closeCancelModal();
};
</script>
</body>
</html>