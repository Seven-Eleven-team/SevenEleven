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
</head>
<body>

<header class="top-nav">
    <div class="menu-icon">☰</div>
    <div class="logo" onclick="location.href='${pageContext.request.contextPath}/index'" style="cursor:pointer;">지출메이트</div>
    <div class="my-page">마이페이지</div>
</header>

<div class="container">
    <%-- 사이드바 조각 파일이 있다면 include로 대체 가능 --%>
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

    <main class="manage-content"> <%-- 클래스명 수정 --%>
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
                            <%-- CSS의 .manage-left / .manage-right 구조 유지 --%>
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
                                        </div>
                                    </div>

                                    <%-- 상세 정보 (CSS의 order-log-box 느낌으로 활용) --%>
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

<script>
    // 탭 전환 함수 (클래스 토글 방식)
    function switchTab(index) {
        const tabs = document.querySelectorAll('.tab');
        const contents = document.querySelectorAll('.tab-content');

        tabs.forEach((tab, i) => {
            tab.classList.toggle('active', i === index);
            contents[i].classList.toggle('active', i === index);
        });
    }

    // 모달 제어
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

    window.onclick = function(event) {
        const modal = document.getElementById('realCancelModal');
        if (event.target == modal) closeCancelModal();
    }
</script>

</body>
</html>