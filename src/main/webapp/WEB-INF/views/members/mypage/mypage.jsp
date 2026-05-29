<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

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
            to   { opacity: 1; transform: translateY(0); }
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

        #accountHelp {
            font-size: 14.5px;
            margin-top: 8px;
            font-weight: 500;
            min-height: 24px;
            padding-left: 4px;
        }
        .error-text { color: #ef4444; font-size: 14.5px; margin-top: 8px; font-weight: 500; }

        .add-account-btn, .change-account-btn {
            background-color: #4f46e5; color: white; border: none;
            padding: 15px; border-radius: 12px; font-weight: 700;
            cursor: pointer; width: 100%; font-size: 16.5px;
            transition: all 0.3s;
        }
        .add-account-btn:hover:not(:disabled), .change-account-btn:hover {
            background-color: #4338ca; transform: translateY(-3px);
        }
        .add-account-btn:disabled {
            background-color: #9ca3af;
            cursor: not-allowed;
            transform: none;
        }

        .account-info {
            background: #f8fafc;
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 24px;
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
    </style>
</head>
<body class="mypage-body">

    <%-- Header + Sidebar --%>
    <%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

    <div class="mypage-container">
        <main class="dashboard">

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

                <!-- 입금 계좌 -->
                <div class="alert-side">
                    <h3 class="card-title-center">입금 계좌</h3>
                    <div class="single-account-box">
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
                                <button class="change-account-btn" onclick="openEditAccountModal()">
                                    계좌 변경하기
                                </button>
                            </div>
                        </c:if>

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

    <!-- ==================== 계좌 등록/수정 모달 ==================== -->
    <div id="accountModalOverlay" class="account-modal-overlay">
        <div class="account-modal-content">
            <span class="close-modal" onclick="closeAccountModal()">×</span>
            <h2 id="modalTitle">새 계좌 등록</h2>

            <form id="accountForm" action="${pageContext.request.contextPath}/mypage/accounts" method="post" onsubmit="return validateAccountForm()">
                <input type="hidden" name="mode" id="mode" value="register">
                <input type="hidden" name="accountId" id="accountId" value="">

                <div id="currentAccountInfo" class="account-info" style="display: none;">
                    <p style="margin-bottom: 8px; font-weight: 600; color: #374151;">현재 대표 계좌</p>
                    <div class="account-top">
                        <div class="main-bank-logo" id="currentBankLogo">?</div>
                        <div class="main-bank-info">
                            <strong id="currentBankName"></strong>
                            <span id="currentAccountNumber"></span>
                        </div>
                    </div>
                </div>

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
                    <label for="accountNumber">계좌번호</label>
                    <input type="text" name="accountNumber" id="accountNumber"
                           placeholder="숫자만 입력하세요" maxlength="30" required
                           oninput="handleAccountInput(this)">
                    <div id="accountHelp"></div>
                    <div id="accountError" class="error-text"></div>
                </div>

                <div class="form-group" style="margin: 15px 0;">
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                        <input type="checkbox" name="primary" id="primary" value="true" checked>
                        <strong>이 계좌를 대표 계좌로 설정</strong>
                    </label>
                </div>

                <button type="submit" id="submitBtn" class="add-account-btn">계좌 등록하기</button>
            </form>
        </div>
    </div>

    <!-- 기타 모달 -->
    <div id="modalOverlay" class="modal-overlay">...</div>
    <div id="cancelModalOverlay" class="cancel-modal-overlay">...</div>

    <%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

    <script>
    // ==================== 계좌 관련 스크립트 ====================
    const bankRules = {
        "국민은행": { min: 10, max: 14 },
        "신한은행": { min: 11, max: 12 },
        "우리은행": { min: 13, max: 13 },
        "하나은행": { min: 10, max: 14 },
        "농협은행": { min: 11, max: 13 },
        "카카오뱅크": { min: 13, max: 13 },
        "토스뱅크": { min: 12, max: 12 }
    };

    const bankNameMap = {
        "국민": "국민은행", "신한": "신한은행", "우리": "우리은행",
        "하나": "하나은행", "농협": "농협은행", "카카오": "카카오뱅크", "토스": "토스뱅크"
    };

    function getDigitsOnly(str) {
        return str.replace(/[^0-9]/g, '');
    }

    function handleAccountInput(input) {
        const rawValue = input.value;
        for (let key in bankNameMap) {
            if (rawValue.includes(key)) {
                document.getElementById('bankName').value = bankNameMap[key];
                break;
            }
        }
        input.value = getDigitsOnly(rawValue);
        updateAccountHelp();
    }

    function updateAccountHelp() {
        const bankName = document.getElementById('bankName').value;
        const digits = getDigitsOnly(document.getElementById('accountNumber').value);
        const helpEl = document.getElementById('accountHelp');

        if (!bankName) { helpEl.textContent = ''; return; }

        const rule = bankRules[bankName];
        if (!rule) return;

        const range = rule.min === rule.max ? `${rule.min}자리` : `${rule.min}~${rule.max}자리`;

        if (digits.length >= rule.min && digits.length <= rule.max) {
            helpEl.innerHTML = '✓ 올바른 자리수입니다.';
            helpEl.style.color = '#10b981';
        } else {
            helpEl.innerHTML = `<strong>${bankName} 계좌번호는 ${range}입니다.</strong>`;
            helpEl.style.color = '#3b82f6';
        }
    }

    function validateAccountForm() {
        const bankName = document.getElementById('bankName').value;
        const digits = getDigitsOnly(document.getElementById('accountNumber').value);
        const errorEl = document.getElementById('accountError');

        errorEl.textContent = '';

        if (!bankName) { errorEl.textContent = '은행을 선택해주세요.'; return false; }
        if (digits.length === 0) { errorEl.textContent = '계좌번호를 입력해주세요.'; return false; }

        const rule = bankRules[bankName];
        if (rule && (digits.length < rule.min || digits.length > rule.max)) {
            const range = rule.min === rule.max ? `${rule.min}자리` : `${rule.min}~${rule.max}자리`;
            errorEl.textContent = `${bankName} 계좌번호는 ${range}입니다.`;
            return false;
        }

        document.getElementById('accountNumber').value = digits;
        return true;
    }

    function openAccountModal() {
        document.getElementById('modalTitle').textContent = '새 계좌 등록';
        document.getElementById('mode').value = 'register';
        document.getElementById('accountId').value = '';
        document.getElementById('currentAccountInfo').style.display = 'none';
        document.getElementById('submitBtn').textContent = '계좌 등록하기';
        document.getElementById('primary').checked = true;
        resetForm();
        document.getElementById('accountModalOverlay').style.display = 'flex';
    }

    function openEditAccountModal() {
        document.getElementById('modalTitle').textContent = '계좌 정보 수정';
        document.getElementById('mode').value = 'edit';
        document.getElementById('submitBtn').textContent = '계좌 수정하기';
        document.getElementById('currentAccountInfo').style.display = 'block';
        document.getElementById('primary').checked = true;

        <c:if test="${not empty accounts}">
            <c:set var="acc" value="${accounts[0]}" />
            document.getElementById('currentBankName').textContent = "${acc.bankName}";
            document.getElementById('currentAccountNumber').textContent = "${acc.accountNumber}";
            document.getElementById('currentBankLogo').textContent = "${acc.bankName != null ? acc.bankName.substring(0,1) : '?'}";
            document.getElementById('accountId').value = "${acc.id}";
        </c:if>

        resetForm();
        document.getElementById('accountModalOverlay').style.display = 'flex';
    }

    function resetForm() {
        document.getElementById('bankName').value = '';
        document.getElementById('accountNumber').value = '';
        document.getElementById('accountError').textContent = '';
        document.getElementById('accountHelp').textContent = '';
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
