





<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="menu" value="mypage"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 대시보드</title>
    <link rel="stylesheet" href="/css/mypage.css?v=2">
    <style>
    /* =========================
       계좌 카드 UI (안정 버전)
    ========================= */

    .alert-side {
        width: 100%;
        max-width: 360px;

        background: #fff;
        border: 1px solid #e6e6e6;
        border-radius: 16px;

        padding: 20px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.06);

        box-sizing: border-box;
    }

    /* 제목 */
    .card-title-center {
        font-size: 18px;
        font-weight: 800;
        text-align: center;
        margin-bottom: 18px;
        color: #222;
    }

    /* 내부 */
    .single-account-box {
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    /* 카드 */
    .account-info-card {
        background: #f9fafc;
        border: 1px solid #eee;
        border-radius: 12px;

        padding: 16px;

        display: flex;
        flex-direction: column;
        gap: 12px;

        min-height: 100px; /* ⭐ 높이 흔들림 방지 */
        box-sizing: border-box;
    }

    /* 상단 */
    .account-top {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    /* 은행 원형 로고 */
    .main-bank-logo {
        width: 42px;
        height: 42px;

        border-radius: 50%;
        background: #1e2d4d;
        color: #fff;

        display: flex;
        align-items: center;
        justify-content: center;

        font-weight: 800;
        font-size: 16px;

        flex-shrink: 0;
    }

    /* 은행 정보 */
    .main-bank-info {
        display: flex;
        flex-direction: column;

        flex: 1;
        min-width: 0; /* ⭐ 텍스트 깨짐 방지 핵심 */
    }

    .main-bank-info strong {
        font-size: 15px;
        font-weight: 800;
        color: #222;
    }

    /* 계좌번호 */
    .main-bank-info span {
        font-size: 13px;
        color: #666;
        margin-top: 2px;

        white-space: nowrap;      /* ⭐ 한 줄 유지 */
        overflow: hidden;         /* 넘치면 숨김 */
        text-overflow: ellipsis;  /* ... 처리 */

        display: block;
    }

    /* 안내 문구 */
    .account-notice {
        font-size: 12px;
        color: #888;
        line-height: 1.4;
    }

    /* 버튼 공통 */
    .change-account-btn,
    .add-account-btn {
        width: 100%;
        padding: 10px 12px;

        border-radius: 10px;
        border: none;

        font-size: 14px;
        font-weight: 700;

        cursor: pointer;
    }

    /* 변경 버튼 */
    .change-account-btn {
        background: #1e2d4d;
        color: #fff;
    }

    .change-account-btn:hover {
        opacity: 0.9;
    }

    /* 추가 버튼 */
    .add-account-btn {
        background: #ff4d4d;
        color: #fff;
    }

    .add-account-btn:hover {
        opacity: 0.9;
    }

    /* 없을 때 */
    .no-account {
        text-align: center;
        font-size: 14px;
        color: #777;
        margin-bottom: 10px;
    }
        .footer { width: 100%; background: #243864; color: white; padding: 40px 0; margin-top: 60px; }
        body.mypage { padding-top: 78px; min-height: 100vh; display: flex; flex-direction: column; }
        .mypage-container { flex: 1; }
        body.mypage .auth-link { display: none !important; }
        body.mypage .header-action-area { position: absolute !important; right: 36px !important; }
        body.mypage .user-profile-link { display: flex !important; }

        body.mypage nav.sidebar {
            position: fixed; top: 78px; left: -260px; width: 250px; height: calc(100vh - 78px);
            background: white; border-right: 1px solid #ddd; transition: all 0.3s ease; z-index: 9998; padding-top: 20px;
        }
        body.mypage nav.sidebar.open { left: 0; }
        body.mypage nav.sidebar ul { list-style: none; padding: 0; margin: 0; }
        body.mypage nav.sidebar li { width: 100%; }
        body.mypage nav.sidebar li a {
            display: flex; align-items: center; height: 54px; padding: 0 24px;
            color: #222; text-decoration: none; font-size: 16px; font-weight: 500;
        }
        body.mypage nav.sidebar li a:hover { background: #f5f5f5; }

        body.mypage .site-header {
            position: fixed !important; top: 0 !important; left: 0 !important; width: 100% !important; height: 78px !important;
            background: #243864 !important; display: flex !important; align-items: center !important; justify-content: center !important; z-index: 9999 !important;
        }
        body.mypage .hamburger-btn {
            position: absolute !important; left: 36px !important; width: 42px !important; height: 42px !important;
            border: none !important; border-radius: 12px !important; background: rgba(255,255,255,0.15) !important; color: white !important; font-size: 22px !important;
        }
        body.mypage .user-profile-link { width: 46px !important; height: 46px !important; border-radius: 50% !important; background: white !important; display: flex !important; align-items: center !important; justify-content: center !important; text-decoration: none !important; }
        body.mypage .user-avatar { color: #243864 !important; font-weight: 700 !important; }

        .mypage-sidebar {
            width: 250px !important; min-width: 250px !important; height: auto !important; align-self: stretch !important;
            background: #ffffff !important; border: 1px solid #dddddd !important; border-radius: 20px !important; padding: 0 !important; display: flex !important; align-items: center !important;
        }
        .mypage-sidebar ul { display: flex !important; flex-direction: column !important; justify-content: center !important; list-style: none !important; padding: 0 !important; margin: 0 !important; width: 100% !important; }
        .mypage-sidebar li a { display: flex !important; justify-content: center !important; align-items: center !important; width: 100% !important; height: 55px !important; padding: 0 !important; font-size: 16px !important; color: #111111 !important; }
        .mypage-sidebar li a:hover { background: #fafafa !important; color: #ff4d4d !important; }
        .mypage-sidebar li.active a { color: #ff4d4d !important; font-weight: 700 !important; }

        .account-modal-overlay {
            display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.55); z-index: 5000; justify-content: center; align-items: center; backdrop-filter: blur(5px);
        }
        .account-modal-content {
            background: white; padding: 40px; border-radius: 24px; width: 100%; max-width: 500px;
            position: relative; box-shadow: 0 20px 40px rgba(0,0,0,0.2); animation: modalPop 0.3s ease;
        }
        @keyframes modalPop { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        .close-modal { position: absolute; top: 20px; right: 20px; font-size: 24px; cursor: pointer; color: #aaa; }
        .account-modal-content h2 { text-align: center; margin-bottom: 25px; font-size: 22px; color: #333; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #555; }
        .form-group select, .form-group input {
            width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 10px; font-size: 15px;
        }
        .current-account-card {
            background: #f8fafc; padding: 15px; border-radius: 12px; margin-bottom: 20px;
            border: 1px solid #e2e8f0; font-size: 14px; color: #666;
        }
        .error-text { color: #ef4444; font-size: 13px; margin-top: 5px; }
        #accountHelp { font-size: 13px; margin-top: 5px; min-height: 18px; }

        .cancel-modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.3); z-index: 2000; justify-content: center; align-items: center; }
        .cancel-modal-content { background: white; padding: 50px 80px; border-radius: 15px; position: relative; text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .cancel-modal-content p { font-size: 24px; font-weight: bold; color: #333; }
        .cancel-close-x { position: absolute; top: 15px; right: 20px; font-size: 20px; cursor: pointer; }
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 2000; justify-content: center; align-items: center; }
        .modal-content { background: white; padding: 40px; border-radius: 20px; text-align: center; position: relative; width: 400px; }
        .close-btn { position: absolute; top: 15px; right: 20px; cursor: pointer; font-size: 20px; }
        .leave-btn { background: #ef4444; color: white; border: none; padding: 12px 30px; border-radius: 10px; cursor: pointer; font-weight: bold; }

        .card-header-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .card-title { margin: 0; }

        /* 전체보기 링크 스타일 */
        .more-link { font-size: 14px; color: #243864; text-decoration: none; font-weight: 600; cursor: pointer; order: 2; }
        .more-link:hover { text-decoration: underline; color: #ff4d4d; }

        /* 해지하기 기본 색상을 전체보기 색상(#243864)과 100% 동일하게 일치 */
        .cancel-link {
            font-size: 14px;
            color: #243864;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
        }
        /* 마우스 호버 시 효과도 전체보기와 일치 (빨간색 변환 + 밑줄 생성) */
        .cancel-link:hover {
            text-decoration: underline;
            color: #ff4d4d;
        }
    </style>
</head>
<body class="mypage">
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
<div class="mypage-container">
    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <main class="dashboard" style="flex: 1;">
        <section class="profile-combined-card">
            <div class="info-side">
                <h3 class="card-title-center">내 정보</h3>
                <div class="info-body">
                    <div class="profile-section">
                        <div class="profile-img-box">
                            <img src="/images/profile.jpg" alt="프로필">
                        </div>
                        <button class="edit-info-btn" onclick="location.href='${pageContext.request.contextPath}/mypage/editprofile'">
                            내 정보 수정
                        </button>
                    </div>

                    <div class="text-area">
                        <div class="info-row">
                            <span>닉네임</span>
                            <strong>${not empty summary.nickname ? summary.nickname : '-'}</strong>
                        </div>
                        <div class="info-row">
                            <span>생년월일</span>
                            <strong>${not empty summary.birthDate ? summary.birthDate : '-'} (${not empty summary.gender ? summary.gender : '-'})</strong>
                        </div>
                        <div class="info-row">
                            <span>이메일</span>
                            <strong>${not empty summary.email ? summary.email : '-'}</strong>
                        </div>
                        <div class="withdraw-container">
                            <a href="#" class="withdraw-link" onclick="openModal(); return false;">회원 탈퇴</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="alert-side">
                <h3 class="card-title-center">입금 계좌</h3>
                <div class="single-account-box">
                    <c:choose>
                        <c:when test="${not empty accounts}">
                            <c:set var="primaryAcc" value="${accounts[0]}"/>
                            <div class="account-info-card">
                                <div class="account-top">
                                    <div class="main-bank-logo">
                                        ${not empty primaryAcc.bankName ? fn:substring(primaryAcc.bankName, 0, 1) : '?'}
                                    </div>
                                    <div class="main-bank-info">
                                        <strong>${primaryAcc.bankName}</strong>
                                        <span>${primaryAcc.accountNumber}</span>
                                    </div>
                                </div>
                                <p class="account-notice">구독 환불 및 정산 시 사용되는 대표 계좌입니다.</p>
                                <button class="change-account-btn" onclick="openEditAccountModal()">
                                    계좌 변경하기
                                </button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="no-account">등록된 계좌가 없습니다.</p>
                            <button class="add-account-btn" onclick="openAccountModal()">
                                + 새 계좌 등록하기
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>

        <div class="bottom-row">
            <section class="card sub-card">
                <div class="card-header-group">
                    <h3 class="card-title">내 구독</h3>
                    <a href="/mypage/subscriptions" class="more-link">전체보기</a>
                </div>
                <div class="sub-list">
                    <div class="sub-item">
                        <div class="sub-icon gpt"></div>
                        <div class="sub-info">
                            <strong>Chat GPT</strong>
                            <div class="sub-meta"><span>월 32,000원</span><span>결제일 65d</span></div>
                        </div>
                        <span class="cancel-link" onclick="openCancelModal()">해지하기</span>
                    </div>
                    <div class="sub-item">
                        <div class="sub-icon netflix"></div>
                        <div class="sub-info">
                            <strong>Netflix</strong>
                            <div class="sub-meta"><span>월 17,000원</span><span>결제일 12d</span></div>
                        </div>
                        <span class="cancel-link" onclick="openCancelModal()">해지하기</span>
                    </div>
                    <div class="sub-item">
                        <div class="sub-icon youtube"></div>
                        <div class="sub-info">
                            <strong>YouTube Premium</strong>
                            <div class="sub-meta"><span>월 14,900원</span><span>결제일 5d</span></div>
                        </div>
                        <span class="cancel-link" onclick="openCancelModal()">해지하기</span>
                    </div>
                </div>
            </section>

            <section class="card goal-card">
                <div class="card-header-group">
                    <h3 class="card-title">내 개인 소비 목표</h3>
                    <a href="/mypage/goals" class="more-link">전체보기</a>
                </div>
                <div class="main-goal">
                    <p class="main-goal-title">🔥 가장 중요한 목표</p>
                    <p>1억 모으기</p>
                    <div class="progress-bg"><div class="progress-bar" data-value="80">0%</div></div>
                </div>
                <div class="goal-item">
                    <p>집 사기</p>
                    <div class="progress-bg"><div class="progress-bar" data-value="50">0%</div></div>
                </div>
                <div class="goal-item">
                    <p>차 사기</p>
                    <div class="progress-bg"><div class="progress-bar" data-value="20">0%</div></div>
                </div>
            </section>
        </div>
    </main>
</div>

<div id="accountModalOverlay" class="account-modal-overlay">
    <div class="account-modal-content">
        <span class="close-modal" onclick="closeAccountModal()">&times;</span>
        <h2 id="accountModalTitle">새 계좌 등록</h2>

        <form id="accountForm" action="${pageContext.request.contextPath}/mypage/accounts" method="post" onsubmit="return validateAccountForm()">
            <input type="hidden" name="mode" id="mode" value="register">
            <input type="hidden" name="accountId" id="accountId" value="">

            <div id="currentAccountInfo" class="current-account-card" style="display:none;">
                <strong>현재 대표 계좌:</strong> <span id="currentAccText"></span>
            </div>

            <div class="form-group">
                <label>은행 선택</label>
                <select name="bankName" id="bankName" required onchange="updateAccountHelp()">
                    <option value="">-- 은행을 선택해주세요 --</option>
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
                <label>계좌번호</label>
                <input type="text" name="accountNumber" id="accountNumber" placeholder="숫자만 입력하세요 (예: 국민 123...)" required oninput="handleAccountInput(this)">
                <div id="accountHelp"></div>
                <div id="accountError" class="error-text"></div>
            </div>

            <div class="form-group">
                <label style="display:flex; align-items:center; gap:8px; cursor:pointer;">
                    <input type="checkbox" name="primary" id="primary" value="true" checked> 이 계좌를 대표 계좌로 설정
                </label>
            </div>

            <button type="submit" id="accountSubmitBtn" class="change-account-btn" style="width:100%; padding:15px; border-radius:10px; border:none; background:#4f46e5; color:white; font-weight:bold; cursor:pointer;">
                계좌 등록하기
            </button>
        </form>
    </div>
</div>

<div id="modalOverlay" class="modal-overlay">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2 style="margin-bottom: 10px;">회원 탈퇴</h2>
        <p>정말로 탈퇴하시겠습니까?<br>회원 탈퇴시 내 정보는 30일 동안 저장 되었다 삭제됩니다.</p>
        <button class="leave-btn">탈퇴하기</button>
    </div>
</div>

<div id="cancelModalOverlay" class="cancel-modal-overlay">
    <div class="cancel-modal-content">
        <span class="cancel-close-x" onclick="closeCancelModal()">&times;</span>
        <p>직접 해지 하셔야합니다.</p>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

<script>
    const bankRules = {
        "국민은행": { min: 10, max: 14 }, "신한은행": { min: 11, max: 12 },
        "우리은행": { min: 13, max: 13 }, "하나은행": { min: 10, max: 14 },
        "농협은행": { min: 11, max: 13 }, "카카오뱅크": { min: 13, max: 13 },
        "토스뱅크": { min: 12, max: 12 }
    };

    const bankNameMap = {
        "국민": "국민은행", "신한": "신한은행",
        "우리": "우리은행", "하나": "하나은행",
        "농협": "농협은행", "카카오": "카카오뱅크",
        "토스": "토스뱅크"
    };

    function handleAccountInput(input) {
        const rawValue = input.value;
        for (const key in bankNameMap) {
            if (rawValue.includes(key)) {
                document.getElementById('bankName').value = bankNameMap[key];
                break;
            }
        }
        input.value = rawValue.replace(/[^0-9]/g, '');
        updateAccountHelp();
    }

    function updateAccountHelp() {
        const bankName = document.getElementById('bankName').value;
        const digits = document.getElementById('accountNumber').value;
        const helpEl = document.getElementById('accountHelp');
        if (!bankName) { helpEl.textContent = ''; return; }
        const rule = bankRules[bankName];
        const range = rule.min === rule.max ? `${rule.min}자리` : `${rule.min}~${rule.max}자리`;
        if (digits.length >= rule.min && digits.length <= rule.max) {
            helpEl.innerHTML = '✓ 올바른 자리수입니다.';
            helpEl.style.color = '#10b981';
        } else {
            helpEl.innerHTML = `<strong style="color:#3b82f6;">${bankName} 계좌번호는 ${range}입니다.</strong>`;
            helpEl.style.color = '#3b82f6';
        }
    }

    function validateAccountForm() {
        const bankName = document.getElementById('bankName').value;
        const digits = document.getElementById('accountNumber').value;
        const errorEl = document.getElementById('accountError');
        errorEl.textContent = '';
        if (!bankName) { errorEl.textContent = '은행을 선택해주세요.'; return false; }
        const rule = bankRules[bankName];
        if (rule && (digits.length < rule.min || digits.length > rule.max)) {
            errorEl.textContent = '계좌번호 자리수가 맞지 않습니다.';
            return false;
        }
        return true;
    }

    function openAccountModal() {
        document.getElementById('accountModalTitle').textContent = '새 계좌 등록';
        document.getElementById('mode').value = 'register';
        document.getElementById('accountId').value = '';
        document.getElementById('currentAccountInfo').style.display = 'none';
        document.getElementById('accountSubmitBtn').textContent = '계좌 등록하기';
        resetAccountForm();
        document.getElementById('accountModalOverlay').style.display = 'flex';
    }

    function openEditAccountModal() {
        document.getElementById('accountModalTitle').textContent = '계좌 정보 수정';
        document.getElementById('mode').value = 'edit';
        document.getElementById('accountSubmitBtn').textContent = '계좌 수정하기';
        document.getElementById('currentAccountInfo').style.display = 'block';

        <c:if test="${not empty accounts}">
            <c:set var="acc" value="${accounts[0]}"/>
            document.getElementById('currentAccText').textContent = "${acc.bankName} ${acc.accountNumber}";
            document.getElementById('accountId').value = "${acc.id}";
        </c:if>

        resetAccountForm();
        document.getElementById('accountModalOverlay').style.display = 'flex';
    }

    function closeAccountModal() {
        document.getElementById('accountModalOverlay').style.display = 'none';
    }

    function resetAccountForm() {
        document.getElementById('bankName').value = '';
        document.getElementById('accountNumber').value = '';
        document.getElementById('accountError').textContent = '';
        document.getElementById('accountHelp').textContent = '';
    }

    function openModal() { document.getElementById('modalOverlay').style.display = 'flex'; }
    function closeModal() { document.getElementById('modalOverlay').style.display = 'none'; }
    function openCancelModal() { document.getElementById('cancelModalOverlay').style.display = 'flex'; }
    function closeCancelModal() { document.getElementById('cancelModalOverlay').style.display = 'none'; }

    window.onclick = function(event) {
        if (event.target == document.getElementById('modalOverlay')) document.getElementById('modalOverlay').style.display = 'none';
        if (event.target == document.getElementById('cancelModalOverlay')) document.getElementById('cancelModalOverlay').style.display = 'none';
        if (event.target == document.getElementById('accountModalOverlay')) closeAccountModal();
    }

    window.onload = function() {
        const progressBars = document.querySelectorAll('.progress-bar');
        progressBars.forEach((progressBar) => {
            const targetValue = parseInt(progressBar.getAttribute('data-value')) || 0;
            setTimeout(() => {
                progressBar.style.width = targetValue + '%';
                if (targetValue <= 30) progressBar.style.backgroundColor = '#ff8a80';
                else if (targetValue <= 70) progressBar.style.backgroundColor = '#fde047';
                else progressBar.style.backgroundColor = '#a3e635';
                let count = 0;
                if (targetValue > 0) {
                    const interval = setInterval(() => {
                        if (count >= targetValue) { clearInterval(interval); progressBar.innerText = targetValue + '%'; }
                        else { progressBar.innerText = count + '%'; count++; }
                    }, 1500 / targetValue);
                } else { progressBar.innerText = '0%'; }
            }, 200);
        });
    };

    const hamburgerBtn = document.querySelector('.hamburger-btn');
    const sidebar = document.querySelector('nav.sidebar');
    if (hamburgerBtn && sidebar) {
        hamburgerBtn.addEventListener('click', function () {
            sidebar.classList.toggle('open');
        });
    }
</script>
</body>
</html>