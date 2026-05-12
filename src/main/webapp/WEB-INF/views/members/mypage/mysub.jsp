<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 구독 관리</title>
    <%-- CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/subscription.css">

    <style>
        /* 이용 약관 모달 전용 스타일 */
        .terms-modal-content {
            width: 450px !important;
            padding: 50px 40px !important;
            border-radius: 20px !important;
            text-align: left !important;
            position: relative;
        }

        .terms-title {
            font-size: 26px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 15px;
            color: #000;
        }

        .terms-divider {
            border: 0;
            border-top: 1.5px solid #333;
            margin-bottom: 25px;
        }

        .terms-body {
            font-size: 16px;
            line-height: 1.7;
            color: #333;
            margin-bottom: 30px;
            word-break: keep-all; /* 단어 단위 줄바꿈으로 깔끔하게 */
        }

        .terms-footer-line {
            border: 0;
            border-top: 1px solid #dbdbdb;
            margin-bottom: 30px;
        }

        .terms-btn-wrapper {
            display: flex;
            justify-content: center;
        }

        /* 시안의 남색 확인 버튼 */
        .btn-confirm-dark {
            width: 140px;
            height: 45px;
            background-color: #1e2d4d !important;
            color: #fff !important;
            border: none !important;
            border-radius: 25px !important; /* 알약 모양 버튼 */
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
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
            <li><a href="${pageContext.request.contextPath}/members/mypage/mypage">대시보드</a></li>
            <li class="active"><a href="${pageContext.request.contextPath}/members/mypage/mysub">내 구독 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mypost">내 게시글 보기</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myque">내 문의</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myreport">내 신고 목록</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myalarm">알림</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mysale">내 판매 목록</a></li>
        </ul>
    </aside>

    <main class="manage-content">
        <h2 class="page-title">내 구독 관리</h2>

        <div class="tab-menu">
            <div class="tab active" onclick="switchTab(0)">구독 중</div>
            <div class="tab" onclick="switchTab(1)">주문 내역</div>
        </div>

        <%-- [탭 1] 구독 중 --%>
        <div class="tab-content active">
            <div class="manage-grid">
                <c:choose>
                    <c:when test="${not empty subscriptionActiveList}">
                        <c:forEach var="sub" items="${subscriptionActiveList}" varStatus="status">
                            <div class="${status.index % 2 == 0 ? 'manage-left' : 'manage-right'}">
                                <div class="sub-manage-card">
                                    <div class="card-header">
                                        <div class="service-info">
                                            <img src="${pageContext.request.contextPath}/images/${sub.logoImage}" alt="로고" class="sub-logo-small">
                                            <div>
                                                <h3>${sub.serviceName}</h3>
                                                <p class="order-num">주문 번호: ${sub.orderId}</p>
                                            </div>
                                        </div>
                                        <div class="card-btns">
                                            <button class="btn-extend" onclick="location.href='${pageContext.request.contextPath}/subscription/form?id=${sub.id}'">연장하기</button>
                                            <button class="btn-cancel" onclick="confirmCancel('${sub.id}', '${sub.serviceName}')">해지하기</button>
                                            <span onclick="openTermsModal()" style="font-size: 11px; color: #999; text-decoration: underline; cursor: pointer; margin-top: 8px; text-align: center;">이용약관 보기</span>
                                        </div>
                                    </div>

                                    <div class="order-log-box">
                                        <p class="log-title">상태: ${sub.statusMsg}</p>
                                        <table class="log-table">
                                            <tr><td>남은 기간</td><td class="text-right">${sub.remainingDays}일</td></tr>
                                            <tr><td>결제 금액</td><td class="text-right">${sub.price}원</td></tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="width:100%; text-align: center; padding: 100px; color: #999;">
                            구독 중인 서비스가 없습니다.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- [탭 2] 주문 내역 --%>
        <div class="tab-content">
            <div class="history-card">
                <c:choose>
                    <c:when test="${not empty orderHistoryList}">
                        <c:forEach var="history" items="${orderHistoryList}">
                            <div class="history-item">
                                <div class="history-left">
                                    <div class="history-info">
                                        <strong>${history.serviceName}</strong>
                                        <span>주문일: ${history.orderDate}</span>
                                    </div>
                                </div>
                                <div class="history-right">
                                    <span class="order-code">완료</span>
                                    <button class="btn-re-sub">재구독하기</button>
                                </div>
                            </div>
                            <hr class="history-divider">
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="text-align: center; padding: 50px; color: #999;">주문 내역이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>

<%-- 해지 확인 모달 --%>
<div id="realCancelModal" class="cancel-modal-overlay">
    <div class="cancel-modal-content">
        <span class="cancel-close-x" onclick="closeCancelModal()">&times;</span>
        <h3 id="cancelServiceName" style="margin-bottom: 10px;">서비스명</h3>
        <p style="font-size: 18px; margin-bottom: 30px;">정말로 구독을 해지하시겠습니까?</p>
        <div style="display: flex; gap: 15px; justify-content: center;">
            <button onclick="closeCancelModal()" class="btn-cancel" style="width: 120px;">취소</button>
            <button id="confirmCancelBtn" class="btn-extend" style="width: 120px; background-color: #ff4d4f !important;">해지 확정</button>
        </div>
    </div>
</div>

<%-- 이용약관 모달 (이미지 시안 2 반영) --%>
<div id="termsModal" class="modal-overlay">
    <div class="modal-content terms-modal-content">
        <h2 class="terms-title">이용 약관</h2>
        <hr class="terms-divider">

        <div class="terms-body">
            <p style="margin-bottom: 20px;">
                구독 파티"란 OTT 등 정기 결제 서비스를 회원 간에 공동으로 이용하고 비용을 부담하기 위해 서비스 내에서 결성된 그룹을 의미합니다.
            </p>
            <p>
                "지출메이트 플랫폼은 회원 간의 구독 쉐어 매칭을 지원할 뿐,<br><br>
                실제 분할 결제 이행 여부 및 사기 등 회원 간의 사적 거래에서 발생하는 금전적 피해에 대해서는 회사가 일체 법적 책임을 지지 않는다"는 방어 조항(면책 조항) 명시
            </p>
        </div>

        <hr class="terms-footer-line">
        <div class="terms-btn-wrapper">
            <button class="btn-confirm-dark" onclick="closeTermsModal()">확인</button>
        </div>
    </div>
</div>

<script>
    function switchTab(index) {
        const tabs = document.querySelectorAll('.tab');
        const contents = document.querySelectorAll('.tab-content');
        tabs.forEach((tab, i) => {
            tab.classList.toggle('active', i === index);
            contents[i].classList.toggle('active', i === index);
        });
    }

    function confirmCancel(subId, serviceName) {
        const modal = document.getElementById('realCancelModal');
        document.getElementById('cancelServiceName').innerText = serviceName;
        modal.style.display = 'flex';
        document.getElementById('confirmCancelBtn').onclick = function() {
            location.href = '${pageContext.request.contextPath}/members/mypage/cancelSub?id=' + subId;
        };
    }

    function closeCancelModal() {
        document.getElementById('realCancelModal').style.display = 'none';
    }

    // 이용약관 모달 제어
    function openTermsModal() {
        document.getElementById('termsModal').style.display = 'flex';
    }

    function closeTermsModal() {
        document.getElementById('termsModal').style.display = 'none';
    }

    window.onclick = function(event) {
        const cancelModal = document.getElementById('realCancelModal');
        const termsModal = document.getElementById('termsModal');
        if (event.target == cancelModal) closeCancelModal();
        if (event.target == termsModal) closeTermsModal();
    }
</script>

</body>
</html>