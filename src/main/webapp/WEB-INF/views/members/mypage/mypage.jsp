<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 마이페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
    <style>
        .cancel-modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
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
        .cancel-modal-content p { font-size: 24px; font-weight: bold; margin: 0; color: #333; }
        .cancel-close-x {
            position: absolute; top: 15px; right: 20px; font-size: 20px;
            font-weight: bold; cursor: pointer; color: #333;
        }
    </style>
</head>
<body>

<header class="top-nav">
    <div class="menu-icon">☰</div>
    <div class="logo" onclick="location.href='${pageContext.request.contextPath}/index'" style="cursor:pointer;">지출메이트</div>
    <div class="my-page">마이페이지</div>
</header>

<div class="container">
    <aside class="sidebar">
        <ul>
            <%-- [수정] 확정된 파일명(mysub, mypost, myque 등)으로 사이드바 링크 통일 --%>
            <li class="active"><a href="${pageContext.request.contextPath}/members/mypage/mypage">대시보드</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mysub">내 구독 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mypost">내 게시글 보기</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myque">내 문의</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myreport">내 신고 목록</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myalarm">알림</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mysale">내 판매 목록</a></li>
        </ul>
    </aside>

    <main class="dashboard">
        <section class="profile-combined-card">
            <div class="info-side">
                <h3 class="card-title-center">내 정보</h3>
                <div class="info-body">
                    <div class="profile-section">
                        <div class="profile-img-box">
                            <img src="${pageContext.request.contextPath}/images/${user.profileImage != null ? user.profileImage : 'profile.jpg'}" alt="프로필">
                        </div>
                        <button class="edit-info-btn"
                                onclick="location.href='${pageContext.request.contextPath}/members/mypage/profile'">내 정보 수정</button>
                    </div>

                    <div class="text-area">
                        <div class="info-row">
                            <span>닉네임</span>
                            <strong>${user.nickname}</strong>
                        </div>
                        <div class="info-row">
                            <span>생년월일</span>
                            <strong>${user.birthDate}(${user.gender})</strong>
                        </div>
                        <div class="info-row">
                            <span>이메일</span>
                            <strong>${user.email}</strong>
                        </div>

                        <div class="withdraw-container">
                            <a href="#" class="withdraw-link" onclick="openModal(); return false;">회원 탈퇴</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="alert-side">
                <h3 class="card-title-center">알림 설정</h3>
                <div class="alert-box">
                    <c:forEach var="i" begin="1" end="3">
                        <div class="alert-item">
                            <span>다음 결제일 전에 알림 설정</span>
                            <input type="checkbox" ${user.alertStatus == 'Y' ? 'checked' : ''}>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <div class="bottom-row">
            <section class="card sub-card">
                <h3 class="card-title">내 구독 요약</h3>
                <div class="sub-list">
                    <c:forEach var="sub" items="${subscriptionList}">
                        <div class="sub-item">
                            <div class="sub-icon ${sub.serviceName.toLowerCase()}"></div>
                            <div class="sub-info">
                                <strong>${sub.serviceName}</strong>
                                <div class="sub-meta">
                                    <span>월 결제 금액 ${sub.price}원</span>
                                    <span>다음 결제일 ${sub.remainingDays}d</span>
                                </div>
                            </div>
                            <span class="cancel-link" style="cursor:pointer;" onclick="openCancelModal()">해지하기</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty subscriptionList}">
                        <p style="text-align: center; color: #999; margin-top: 50px;">구독 중인 서비스가 없습니다.</p>
                    </c:if>
                </div>
            </section>

            <section class="card goal-card">
                <h3 class="card-title">내 개인 소비 목표</h3>
                <div class="goal-list">
                    <c:forEach var="goal" items="${goalList}">
                        <div class="goal-item">
                            <p>${goal.title}</p>
                            <div class="progress-bg">
                                <div class="progress-bar" data-value="${goal.progress}">0%</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </div>
    </main>
</div>

<div id="modalOverlay" class="modal-overlay">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2 style="margin-bottom: 10px;">회원 탈퇴</h2>
        <p>정말로 탈퇴하시겠습니까?<br>회원 탈퇴시 내 정보는 30일 동안 저장 되었다 삭제됩니다.</p>
        <form action="${pageContext.request.contextPath}/members/mypage/withdraw" method="post">
            <button type="submit" class="leave-btn">탈퇴하기</button>
        </form>
    </div>
</div>

<div id="cancelModalOverlay" class="cancel-modal-overlay">
    <div class="cancel-modal-content">
        <span class="cancel-close-x" onclick="closeCancelModal()">&times;</span>
        <p>직접 해지 하셔야합니다.</p>
    </div>
</div>

<script>
    function openModal() { document.getElementById('modalOverlay').style.display = 'flex'; }
    function closeModal() { document.getElementById('modalOverlay').style.display = 'none'; }
    function openCancelModal() { document.getElementById('cancelModalOverlay').style.display = 'flex'; }
    function closeCancelModal() { document.getElementById('cancelModalOverlay').style.display = 'none'; }

    window.onclick = function(event) {
        if (event.target == document.getElementById('modalOverlay')) closeModal();
        if (event.target == document.getElementById('cancelModalOverlay')) closeCancelModal();
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
                        if (count >= targetValue) {
                            clearInterval(interval);
                            progressBar.innerText = targetValue + '%';
                        } else {
                            progressBar.innerText = count + '%';
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