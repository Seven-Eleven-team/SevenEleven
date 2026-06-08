<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menu" value="subscriptions"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>지출메이트 - 내 구독 관리</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mysub.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <style>
    body.mypage .hamburger-btn{
        display:flex !important;
        flex-direction:column !important;
        justify-content:center !important;
        align-items:center !important;
        gap:4px !important;
    }
    body.mypage .hamburger-btn span{
        display:block !important;
        width:22px !important;
        height:2px !important;
        background:white !important;
        border-radius:999px !important;
    }
    .footer {
        width: 100%;
        background: #243864;
        color: white;
        padding: 40px 0;
        margin-top: 60px;
    }
    body.mypage {
        padding-top: 78px;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }
    .mypage-container {
        flex: 1;
    }
    body.mypage .auth-link {
        display: none !important;
    }
    body.mypage .header-action-area {
        position: absolute !important;
        right: 36px !important;
    }
    body.mypage .user-profile-link {
        display: flex !important;
    }
    body.mypage nav.sidebar {
        position: fixed;
        top: 78px;
        left: -260px;
        width: 250px;
        height: calc(100vh - 78px);
        background: #243864;
        border-right: none;
        transition: all 0.3s ease;
        z-index: 9998;
        padding-top: 20px;
    }
    body.mypage nav.sidebar.open {
        left: 0;
    }
    body.mypage nav.sidebar ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    body.mypage nav.sidebar li {
        width: 100%;
    }
    body.mypage nav.sidebar li a {
        display: flex;
        align-items: center;
        height: 54px;
        padding: 0 24px;
        color: white;
        text-decoration: none;
        font-size: 16px;
        font-weight: 500;
        transition: 0.2s;
    }
    body.mypage nav.sidebar li a:hover {
        background: rgba(255, 255, 255, 0.12);
    }
    .sidebar-logout {
        position: absolute;
        bottom: 20px;
        left: 0;
        width: 100%;
    }
    .sidebar-logout a {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 0 24px;
        height: 54px;
        color: white;
        text-decoration: none;
    }
    .sidebar-logout a:hover {
        background: rgba(255, 255, 255, 0.12);
    }
    body.mypage .sidebar-overlay,
    body.mypage .sidebar-drawer,
    body.mypage .sidebar-menu,
    body.mypage .mobile-sidebar {
        display: none !important;
    }
    body.mypage .site-header {
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100% !important;
        height: 78px !important;
        background: rgba(25, 59, 96, 0.96) !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        z-index: 9999 !important;
    }
    body.mypage .site-logo {
        color: white !important;
        font-size: 28px !important;
        font-weight: 800 !important;
        margin: 0 !important;
    }
  body.mypage .hamburger-btn {
            position: absolute !important;
            left: 36px !important;
            width: 42px !important;
            height: 42px !important;
            border: none !important;
            border-radius: 0 !important;        /* 박스 제거 */
            background: transparent !important; /* 배경 제거 */
            color: white !important;
            font-size: 22px !important;
      }
    body.mypage .auth-link {
        color: white !important;
        text-decoration: none !important;
    }
    body.mypage .user-profile-link {
        width: 46px !important;
        height: 46px !important;
        border-radius: 50% !important;
        background: white !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        text-decoration: none !important;
    }
    body.mypage .user-avatar {
        color: #243864 !important;
        font-weight: 700 !important;
    }
    .mypage-container {
        display: flex !important;
        flex-direction: row !important;
        align-items: stretch !important;
        gap: 26px !important;
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px 0;
    }
    .mypage-sidebar {
        width: 250px !important;
        min-width: 250px !important;
        height: auto !important;
        align-self: stretch !important;
        background: #ffffff !important;
        border: 1px solid #dddddd !important;
        border-radius: 20px !important;
        padding: 0 !important;
        display: flex !important;
        align-items: center !important;
    }
    .mypage-sidebar ul {
        display: flex !important;
        flex-direction: column !important;
        justify-content: center !important;
        list-style: none !important;
        padding: 0 !important;
        margin: 0 !important;
        width: 100% !important;
    }
    .mypage-sidebar li {
        width: 100% !important;
        display: block !important;
    }
    .mypage-sidebar li a {
        display: flex !important;
        justify-content: center !important;
        align-items: center !important;
        width: 100% !important;
        height: 55px !important;
        padding: 0 !important;
        line-height: 1 !important;
        text-align: center !important;
        font-size: 16px !important;
        font-weight: 500 !important;
        color: #111111 !important;
        transition: all 0.2s ease !important;
    }
    .mypage-sidebar li a:hover {
        background: #fafafa !important;
        color: #ff4d4d !important;
    }
    .mypage-sidebar li.active a {
        color: #ff4d4d !important;
        font-weight: 700 !important;
    }
    .terms-modal-overlay{
        display:none;
        position:fixed;
        top:0;
        left:0;
        width:100%;
        height:100%;
        background:rgba(0,0,0,0.35);
        z-index:3000;
        justify-content:center;
        align-items:center;
    }
    .terms-modal-content{
        width:420px;
        background:#f5f5f5;
        border-radius:20px;
        padding:28px 38px 30px;
        position:relative;
        box-shadow:0 8px 30px rgba(0,0,0,0.12);
    }
    .terms-close-btn{
        position:absolute;
        top:18px;
        right:22px;
        font-size:26px;
        cursor:pointer;
        color:#555;
    }
    .terms-title{
        text-align:center;
        font-size:34px;
        font-weight:800;
        margin-bottom:22px;
        color:#111;
    }
    .terms-divider{
        width:100%;
        height:1px;
        background:#9f9f9f;
        margin-bottom:26px;
    }
    .terms-text{
        min-height:300px;
        font-size:16px;
        line-height:2.1;
        color:#222;
        word-break:keep-all;
    }
    .terms-text p{
        margin-bottom:18px;
    }
    .terms-bottom-line{
        width:100%;
        height:1px;
        background:#9f9f9f;
        margin:30px 0 34px;
    }
    .terms-confirm-btn{
        width:150px;
        height:48px;
        border:none;
        border-radius:14px;
        background:#1e2d4d;
        color:white;
        font-size:18px;
        font-weight:700;
        cursor:pointer;
        display:block;
        margin:0 auto;
        transition:0.2s;
    }
    .terms-confirm-btn:hover{
        opacity:0.92;
    }
    </style>
</head>

<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>

    <main class="manage-container" style="flex: 1;">

        <h2 class="page-title">내 구독 관리</h2>

        <div class="tab-menu">
            <span class="tab active" onclick="switchTab(0)">구독 중</span>
            <span class="tab" onclick="switchTab(1)">주문 내역</span>
        </div>

        <%-- ========== 구독 중 탭 ========== --%>
        <div id="sub-active-content" class="tab-content active">
            <div class="manage-grid">

                <%-- 구독이 없을 때 --%>
                <c:if test="${empty subscriptions}">
                    <p style="color:#888; font-size:16px; padding:40px 0;">현재 구독 중인 서비스가 없습니다.</p>
                </c:if>

                <%-- 구독 카드 목록 동적 렌더링 --%>
                <c:forEach var="sub" items="${subscriptions}" varStatus="loop">

                    <%-- 1. 결제 완료 상태(PENDING) 또는 관리자 확인 중 상태(PREPARING) --%>
                    <c:if test="${sub.status eq 'PENDING' or sub.status eq 'PREPARING'}">
                    <section class="manage-left">
                        <div class="sub-manage-card">
                            <div class="card-top-content">
                                <div class="card-header">
                                    <div class="service-info">
                                        <div>
                                            <h3>${sub.serviceName}</h3>
                                            <p class="order-num">주문 번호: ${sub.serialCode}</p>
                                        </div>
                                    </div>
                                    <div class="card-btns">
                                        <button class="btn-extend">연장하기</button>
                                        <form action="${pageContext.request.contextPath}/subscription/cancel/${sub.id}"
                                              method="post"
                                              style="display:inline;"
                                              onsubmit="return confirm('정말 구독을 취소하시겠습니까?\n취소 완료 시 결제 금액은 전액 환불 처리되며, 주문 내역에서 확인할 수 있습니다.');">
                                            <button type="submit" class="btn-cancel">취소하기</button>
                                        </form>
                                    </div>
                                </div>

                                <%-- 프로세스 트래커 상태 바 제어 --%>
                                <div class="status-tracker">
                                    <div class="status-step ${sub.status eq 'PENDING' ? 'active' : 'done'}">
                                        <img src="${pageContext.request.contextPath}/images/icon-payment.png" alt="결제완료" class="step-icon">
                                        <span class="step-text">결제완료</span>
                                    </div>
                                    <div class="status-arrow">
                                        <img src="${pageContext.request.contextPath}/images/arrow-right.png" alt="다음">
                                    </div>
                                    <div class="status-step ${sub.status eq 'PREPARING' ? 'active' : ''}">
                                        <img src="${pageContext.request.contextPath}/images/icon-delivery.png" alt="배송중" class="step-icon">
                                        <span class="step-text">배송중</span>
                                    </div>
                                </div>

                                <div class="order-log-box">
                                    <p class="log-title">주문 완료 (${sub.serialCode})</p>
                                    <table class="log-table">
                                        <tr>
                                            <td>계정 충전 정보/확인</td>
                                            <td class="text-right">${sub.startDate}</td>
                                        </tr>
                                        <tr>
                                            <td>결제 완료</td>
                                            <td class="text-right success-text">성공</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <button class="view-terms" onclick="openTermsModal()">이용약관 보기</button>
                        </div>
                    </section>
                    </c:if>

                    <%-- 2. 이제 실제로 사용할 수 있는 완료 상태 (ACTIVE) --%>
                    <c:if test="${sub.status eq 'ACTIVE'}">
                    <section class="manage-right">
                        <div class="detail-card">
                            <div class="card-header">
                                <div class="service-info">
                                    <div>
                                        <h3>${sub.serviceName}</h3>
                                        <p class="order-num">주문 번호: ${sub.serialCode}</p>
                                    </div>
                                </div>
                                <div class="card-btns">
                                    <button class="btn-extend">연장하기</button>
                                    <form id="cancelForm_${sub.id}" action="${pageContext.request.contextPath}/subscription/cancel/${sub.id}" method="post" style="display:inline;" onsubmit="return confirmCancel(event)">
                                        <button type="submit" class="btn-cancel">해지하기</button>
                                    </form>
                                </div>
                            </div>

                            <div class="order-log-box">
                                <p class="log-title">주문 완료 (${sub.serialCode})</p>
                                <table class="log-table">
                                    <tr>
                                        <td>계정 충전 정보/확인</td>
                                        <td class="text-right">${sub.startDate}</td>
                                    </tr>
                                    <tr>
                                        <td>결제 완료</td>
                                        <td class="text-right success-text">성공</td>
                                    </tr>
                                </table>
                            </div>

                            <button class="view-terms" onclick="openTermsModal()">이용약관 보기</button>

                            <table class="detail-info-table">
                             <%-- 실제 공유 계정의 ID / PW 노출 영역 --%>
                           <tr>
                               <td style="color: #ff4d4d; font-weight: bold; width: 110px; text-align: left;">공유 계정 ID</td>
                               <td style="font-weight: bold; color: #111; text-align: left;">
                                   <span style="color: #ccc; margin-right: 15px;">:</span>${sub.sharedId}
                               </td>
                           </tr>
                           <tr>
                               <td style="color: #ff4d4d; font-weight: bold; width: 110px; text-align: left;">공유 비밀번호</td>
                               <td style="font-weight: bold; color: #111; text-align: left;">
                                   <span style="color: #ccc; margin-right: 15px;">:</span>${sub.sharedPwd}
                               </td>
                           </tr>
                                <tr>
                                    <th>결제 방식</th>
                                    <td>계좌이체</td>
                                </tr>
                                <tr>
                                    <th>남은 기간</th>
                                    <td>${sub.endDate}까지</td>
                                </tr>
                                <tr>
                                    <th>가격</th>
                                    <td>${sub.monthlyFee}원</td>
                                </tr>
                                <tr>
                                    <th>총 결제금액</th>
                                    <td>${sub.totalAmount}원</td>
                                </tr>
                            </table>
                        </div>
                    </section>
                    </c:if>

                </c:forEach>

            </div>
        </div>

        <%-- ========== 주문 내역 탭 ========== --%>
        <div id="order-history-content" class="tab-content">
            <div class="history-card">

                <c:if test="${empty subscriptions}">
                    <p style="color:#888; font-size:16px; padding:40px 0;">주문 내역이 없습니다.</p>
                </c:if>

                <c:forEach var="sub" items="${subscriptions}">
                    <c:if test="${sub.status eq 'EXPIRED' or sub.status eq 'REFUNDED' or sub.status eq 'CANCELLED'}">
                    <div class="history-item">
                        <div class="history-left">
                            <div class="history-info">
                               <strong>
                                   ${sub.serviceName}

                                   <c:if test="${sub.status eq 'CANCELLED'}">
                                       <c:if test="${empty sub.startDate or sub.startDate ge LocalDate.now()}">
                                           <span style="color: #ff4d4d; font-size: 14px; margin-left: 6px; font-weight: bold;">(취소됨)</span>
                                       </c:if>

                                       <c:if test="${not empty sub.startDate and sub.startDate lt LocalDate.now()}">
                                           <span style="color: #ff4d4d; font-size: 14px; margin-left: 6px; font-weight: bold;">(해지됨)</span>
                                       </c:if>
                                   </c:if>
                               </strong>>
                                <span>${sub.startDate} ~ ${sub.endDate}</span>
                            </div>
                        </div>
                        <div class="history-right">
                            <span class="order-code">주문코드 : ${sub.serialCode}</span>
                            <button class="btn-re-sub">재구독하기</button>
                        </div>
                    </div>
                    <hr class="history-divider">
                    </c:if>
                </c:forEach>

            </div>
        </div>

    </main>
</div>

<%-- 이용약관 팝업 --%>
<div id="termsModal" class="terms-modal-overlay">
    <div class="terms-modal-content">
        <span class="terms-close-btn" onclick="closeTermsModal()">&times;</span>
        <h2 class="terms-title">이용 약관</h2>
        <div class="terms-divider"></div>
        <div class="terms-text">
            <p>구독 파티란 OTT 등 정기 결제 서비스를 회원 간에 공동으로 이용하고 비용을 분담하기 위해 서비스 내에서 결성된 그룹을 의미합니다.</p>
            <p>"지출메이트 플랫폼은 회원 간의 구독 쉐어 매칭 지원할 뿐, 실제 분할 결제 이행 여부 및 사기 등 회원 간의 사적 거래에서 발생하는 금전적 피해에 대해서는 회사가 일체 법적 책임을 지지 않는다"는 방어 조항(면책 조항) 명시</p>
        </div>
        <div class="terms-bottom-line"></div>
        <button class="terms-confirm-btn" onclick="closeTermsModal()">확인</button>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

<script>
    function switchTab(index){
        const tabs = document.querySelectorAll('.tab');
        const contents = document.querySelectorAll('.tab-content');
        tabs.forEach((tab, i) => {
            if(i === index){
                tab.classList.add('active');
                contents[i].style.display = 'block';
            } else {
                tab.classList.remove('active');
                contents[i].style.display = 'none';
            }
        });
    }

    document.addEventListener('DOMContentLoaded', function(){
        switchTab(0);
    });

    function openTermsModal(){
        document.getElementById('termsModal').style.display = 'flex';
    }
    function closeTermsModal(){
        document.getElementById('termsModal').style.display = 'none';
    }

    window.addEventListener('click', function(event){
        const modal = document.getElementById('termsModal');
        if(event.target === modal){
            closeTermsModal();
        }
    });

    const hamburgerBtn = document.querySelector('.hamburger-btn');
    const sidebar = document.querySelector('nav.sidebar');
    if (hamburgerBtn && sidebar) {
        hamburgerBtn.addEventListener('click', function () {
            sidebar.classList.toggle('open');
        });
    }
    // 해지하기 버튼 클릭 이벤트 함수 내부 예시
    function confirmCancel(event) {
        // 1. 브라우저의 즉시 전송을 잠시 막음
        event.preventDefault();

        // 2. 사용자 안내 컨펌창 띄우기
        if (confirm("정말 구독을 해지하시겠습니까?\n해지 후에도 주문 내역에서 확인이 가능합니다.")) {
            alert("해지 처리가 완료되었습니다.");
            // 3. 사용자가 확인을 누르면 그때 form을 서버로 제출시킴
            event.target.submit();
        } else {
            // 취소를 누르면 아무 동작도 안 함
            return false;
        }
    }
</script>

</body>
</html>