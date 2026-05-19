<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menu" value="mypage"/>

<!DOCTYPE html>
<html lang="ko">

<head>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <title>지출메이트 - 마이페이지</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <style>

        /* 해지 안내 팝업 */
        .cancel-modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.3);
            z-index: 2000;
            justify-content: center;
            align-items: center;
        }

        .cancel-modal-content {
            background: white;
            padding: 50px 80px;
            border-radius: 15px;
            position: relative;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .cancel-modal-content p {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
            color: #333;
        }

        .cancel-close-x {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            color: #333;
        }

    </style>

</head>

<body class="mypage-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <%@ include file="/WEB-INF/views/common/layout/sidebar.jspf" %>

    <main class="dashboard">

        <section class="profile-combined-card">

            <div class="info-side">

                <h3 class="card-title-center">내 정보</h3>

                <div class="info-body">

                    <div class="profile-section">

                        <div class="profile-img-box">

                            <img src="${pageContext.request.contextPath}/images/profile.jpg"
                                 alt="프로필">

                        </div>

                        <button class="edit-info-btn"
                                onclick="location.href='${pageContext.request.contextPath}/members/mypage/myedit'">

                            내 정보 수정

                        </button>

                    </div>

                    <div class="text-area">

                        <div class="info-row">
                            <span>닉네임</span>
                            <strong>똥꼬발랄</strong>
                        </div>

                        <div class="info-row">
                            <span>생년월일</span>
                            <strong>2003.03.26(여)</strong>
                        </div>

                        <div class="info-row">
                            <span>이메일</span>
                            <strong>ymd3123@naver.com</strong>
                        </div>

                        <div class="withdraw-container">

                            <a href="#"
                               class="withdraw-link"
                               onclick="openModal(); return false;">

                                회원 탈퇴

                            </a>

                        </div>

                    </div>

                </div>

            </div>

            <!-- 입금 계좌 -->
            <div class="alert-side">

                <h3 class="card-title-center">입금 계좌</h3>

                <div class="single-account-box">

                    <div class="account-top">

                        <div class="main-bank-logo">
                            신
                        </div>

                        <div class="main-bank-info">

                            <strong>신한은행</strong>

                            <span>110-482-938201</span>

                        </div>

                    </div>

                    <div class="account-notice">

                        구독 환불 및 정산 시 사용되는 대표 계좌입니다.

                    </div>

                    <button class="change-account-btn"
                            onclick="location.href='${pageContext.request.contextPath}/members/mypage/accounts'">

                        계좌 변경하기

                    </button>

                </div>

            </div>

        </section>

        <!-- 하단 -->
        <div class="bottom-row">

            <!-- 내 구독 -->
            <section class="card sub-card">

                <h3 class="card-title">내 구독</h3>

                <div class="sub-list">

                    <div class="sub-item">

                        <div class="sub-icon gpt"></div>

                        <div class="sub-info">

                            <strong>Chat GPT</strong>

                            <div class="sub-meta">

                                <span>월 결제 금액 32,000원</span>

                                <span>다음 결제일 65d</span>

                            </div>

                        </div>

                        <span class="cancel-link"
                              onclick="openCancelModal()">

                            해지하기

                        </span>

                    </div>

                    <div class="sub-item">

                        <div class="sub-icon netflix"></div>

                        <div class="sub-info">

                            <strong>Netflix</strong>

                            <div class="sub-meta">

                                <span>월 결제 금액 17,000원</span>

                                <span>다음 결제일 12d</span>

                            </div>

                        </div>

                        <span class="cancel-link"
                              onclick="openCancelModal()">

                            해지하기

                        </span>

                    </div>

                    <div class="sub-item">

                        <div class="sub-icon youtube"></div>

                        <div class="sub-info">

                            <strong>YouTube Premium</strong>

                            <div class="sub-meta">

                                <span>월 결제 금액 14,900원</span>

                                <span>다음 결제일 5d</span>

                            </div>

                        </div>

                        <span class="cancel-link"
                              onclick="openCancelModal()">

                            해지하기

                        </span>

                    </div>

                </div>

            </section>

            <!-- 목표 -->
            <section class="card goal-card">

                <h3 class="card-title">내 개인 소비 목표</h3>

                <div class="goal-list">

                    <div class="goal-item">

                        <p>1억모으기</p>

                        <div class="progress-bg">

                            <div class="progress-bar" data-value="80">
                                0%
                            </div>

                        </div>

                    </div>

                    <div class="goal-item">

                        <p>집 사기</p>

                        <div class="progress-bg">

                            <div class="progress-bar" data-value="50">
                                0%
                            </div>

                        </div>

                    </div>

                    <div class="goal-item">

                        <p>차 사기</p>

                        <div class="progress-bg">

                            <div class="progress-bar" data-value="20">
                                0%
                            </div>

                        </div>

                    </div>

                    <div class="goal-item">

                        <p>모임 돈 모으기</p>

                        <div class="progress-bg">

                            <div class="progress-bar" data-value="30">
                                0%
                            </div>

                        </div>

                    </div>

                </div>

            </section>

        </div>

    </main>

</div>

<!-- 회원 탈퇴 -->
<div id="modalOverlay" class="modal-overlay">

    <div class="modal-content">

        <span class="close-btn"
              onclick="closeModal()">

            &times;

        </span>

        <h2 style="margin-bottom: 10px;">
            회원 탈퇴
        </h2>

        <p>
            정말로 탈퇴하시겠습니까?<br>
            회원 탈퇴시 내 정보는 30일 동안 저장 되었다 삭제됩니다.
        </p>

        <button class="leave-btn">
            탈퇴하기
        </button>

    </div>

</div>

<!-- 해지 안내 -->
<div id="cancelModalOverlay"
     class="cancel-modal-overlay">

    <div class="cancel-modal-content">

        <span class="cancel-close-x"
              onclick="closeCancelModal()">

            &times;

        </span>

        <p>
            직접 해지 하셔야합니다.
        </p>

    </div>

</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>

    function openModal() {
        document.getElementById('modalOverlay').style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('modalOverlay').style.display = 'none';
    }

    function openCancelModal() {
        document.getElementById('cancelModalOverlay').style.display = 'flex';
    }

    function closeCancelModal() {
        document.getElementById('cancelModalOverlay').style.display = 'none';
    }

    window.onclick = function(event) {

        const modal = document.getElementById('modalOverlay');
        const cancelModal = document.getElementById('cancelModalOverlay');

        if (event.target === modal) {
            modal.style.display = 'none';
        }

        if (event.target === cancelModal) {
            cancelModal.style.display = 'none';
        }
    }

    window.onload = function() {

        const progressBars =
            document.querySelectorAll('.progress-bar');

        progressBars.forEach((progressBar) => {

            const targetValue =
                parseInt(progressBar.getAttribute('data-value')) || 0;

            setTimeout(() => {

                progressBar.style.width = targetValue + '%';

                if (targetValue <= 30) {

                    progressBar.style.backgroundColor = '#ff8a80';

                } else if (targetValue <= 70) {

                    progressBar.style.backgroundColor = '#fde047';

                } else {

                    progressBar.style.backgroundColor = '#a3e635';
                }

                let count = 0;

                if (targetValue > 0) {

                    const interval = setInterval(() => {

                        if (count >= targetValue) {

                            clearInterval(interval);

                            progressBar.innerText =
                                targetValue + '%';

                        } else {

                            progressBar.innerText =
                                count + '%';

                            count++;
                        }

                    }, 1500 / targetValue);

                } else {

                    progressBar.innerText = '0%';
                }

            }, 200);

        });
    };

</script>

</body>
</html>