<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="menu" value="mysub"/>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">
    <title>지출메이트 - 내 구독 관리</title>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/manage.css">

    <style>

        /* =========================
           이용약관 팝업
        ========================= */

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

<body class="mypage-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <%@ include file="/WEB-INF/views/common/layout/sidebar.jspf" %>

    <!-- 메인 -->
    <main class="manage-container">

        <h2 class="page-title">내 구독 관리</h2>

        <!-- 탭 -->
        <div class="tab-menu">

            <span class="tab active"
                  onclick="switchTab(0)">
                구독 중
            </span>

            <span class="tab"
                  onclick="switchTab(1)">
                주문 내역
            </span>

        </div>

        <!-- 구독중 -->
        <div id="sub-active-content"
             class="tab-content active">

            <div class="manage-grid">

                <!-- 왼쪽 카드 -->
                <section class="manage-left">

                    <div class="sub-manage-card">

                        <div class="card-top-content">

                            <div class="card-header">

                                <div class="service-info">

                                    <img src="${pageContext.request.contextPath}/images/YoutubeLogo.png"
                                         alt="유튜브"
                                         class="sub-logo-small">

                                    <div>

                                        <h3>유튜브 프리미엄</h3>

                                        <p class="order-num">
                                            주문 번호: 50189-4646
                                        </p>

                                    </div>

                                </div>

                                <div class="card-btns">

                                    <button class="btn-extend">
                                        연장하기
                                    </button>

                                    <button class="btn-cancel">
                                        해지하기
                                    </button>

                                </div>

                            </div>

                            <!-- 상태 -->
                            <div class="status-tracker">

                                <div class="status-step done">

                                    <img src="${pageContext.request.contextPath}/images/icon-payment.png"
                                         alt="결제완료"
                                         class="step-icon">

                                    <span class="step-text">
                                        결제완료
                                    </span>

                                </div>

                                <div class="status-arrow">

                                    <img src="${pageContext.request.contextPath}/images/arrow-right.png"
                                         alt="다음">

                                </div>

                                <div class="status-step active">

                                    <img src="${pageContext.request.contextPath}/images/icon-delivery.png"
                                         alt="배송중"
                                         class="step-icon">

                                    <span class="step-text">
                                        배송중
                                    </span>

                                </div>

                                <div class="status-arrow">

                                    <img src="${pageContext.request.contextPath}/images/arrow-right.png"
                                         alt="다음">

                                </div>

                                <div class="status-step">

                                    <img src="${pageContext.request.contextPath}/images/icon-check.png"
                                         alt="사용가능"
                                         class="step-icon">

                                    <span class="step-text">
                                        사용가능
                                    </span>

                                </div>

                            </div>

                            <!-- 로그 -->
                            <div class="order-log-box">

                                <p class="log-title">
                                    주문 완료 (501-49141)
                                </p>

                                <table class="log-table">

                                    <tr>
                                        <td>계정 충전 정보/확인</td>

                                        <td class="text-right">
                                            26.05.14 13:06
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>결제 완료</td>

                                        <td class="text-right success-text">
                                            성공
                                        </td>
                                    </tr>

                                </table>

                            </div>

                        </div>

                        <!-- 이용약관 버튼 -->
                        <button class="view-terms"
                                onclick="openTermsModal()">

                            이용약관 보기

                        </button>

                    </div>

                </section>

                <!-- 오른쪽 카드 -->
                <section class="manage-right">

                    <div class="detail-card">

                        <div class="card-header">

                            <div class="service-info">

                                <img src="${pageContext.request.contextPath}/images/GPTLogo.png"
                                     alt="GPT"
                                     class="sub-logo-small">

                                <div>

                                    <h3>챗지피티</h3>

                                    <p class="order-num">
                                        주문 번호: 45122-13419
                                    </p>

                                </div>

                            </div>

                            <div class="card-btns">

                                <button class="btn-extend">
                                    연장하기
                                </button>

                                <button class="btn-cancel">
                                    해지하기
                                </button>

                            </div>

                        </div>

                        <div class="status-msg-box">
                            입금확인 전/내용 정보 확인바람
                        </div>

                        <div class="description-box">

                            <p>
                                대한민국에서 유일하게 결제 가능한 서비스를 제공하며,
                                안전하고 불법적인 우려 없이 이용 가능합니다.
                            </p>

                            <p style="margin-top:10px;">
                                GPT-4 및 유료 기능을 저렴하게 이용할 수 있도록 돕습니다.
                            </p>

                        </div>

                        <table class="detail-info-table">

                            <tr>
                                <th>결제 방식</th>
                                <td>계좌이체</td>
                            </tr>

                            <tr>
                                <th>남은 기간</th>
                                <td>54d</td>
                            </tr>

                            <tr>
                                <th>가격</th>
                                <td>7,000원</td>
                            </tr>

                            <tr>
                                <th>비밀번호</th>
                                <td>dsed223sf</td>
                            </tr>

                        </table>

                    </div>

                </section>

            </div>

        </div>

        <!-- 주문내역 -->
        <div id="order-history-content"
             class="tab-content">

            <div class="history-card">

                <div class="history-item">

                    <div class="history-left">

                        <img src="${pageContext.request.contextPath}/images/YoutubeLogo.png"
                             alt="유튜브"
                             class="sub-logo-small">

                        <div class="history-info">

                            <strong>유튜브 프리미엄</strong>

                            <span>
                                25.03.04 ~ 25.06.04
                            </span>

                        </div>

                    </div>

                    <div class="history-right">

                        <span class="order-code">
                            주문코드 : 9416:845
                        </span>

                        <button class="btn-re-sub">
                            재구독하기
                        </button>

                    </div>

                </div>

                <hr class="history-divider">

            </div>

        </div>

    </main>

</div>

<!-- =========================
     이용약관 팝업
========================= -->

<div id="termsModal"
     class="terms-modal-overlay">

    <div class="terms-modal-content">

        <span class="terms-close-btn"
              onclick="closeTermsModal()">

            &times;

        </span>

        <h2 class="terms-title">
            이용 약관
        </h2>

        <div class="terms-divider"></div>

        <div class="terms-text">

            <p>
                구독 파티란 OTT 등 정기 결제 서비스를 회원 간에 공동으로
                이용하고 비용을 분담하기 위해 서비스 내에서 결성된 그룹을 의미합니다.
            </p>

            <p>
                "지출메이트 플랫폼은 회원 간의 구독 쉐어 매칭 지원할 뿐,
                실제 분할 결제 이행 여부 및 사기 등 회원 간의 사적 거래에서 발생하는
                금전적 피해에 대해서는 회사가 일체 법적 책임을 지지 않는다"는
                방어 조항(면책 조항) 명시
            </p>

        </div>

        <div class="terms-bottom-line"></div>

        <button class="terms-confirm-btn"
                onclick="closeTermsModal()">

            확인

        </button>

    </div>

</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>

    // 탭 전환
    function switchTab(index){

        const tabs = document.querySelectorAll('.tab');
        const contents = document.querySelectorAll('.tab-content');

        tabs.forEach((tab, i) => {

            if(i === index){

                tab.classList.add('active');
                contents[i].style.display = 'block';

            }else{

                tab.classList.remove('active');
                contents[i].style.display = 'none';
            }

        });
    }

    // 초기 실행
    document.addEventListener('DOMContentLoaded', function(){

        switchTab(0);
    });

    // 팝업 열기
    function openTermsModal(){

        document.getElementById('termsModal').style.display = 'flex';
    }

    // 팝업 닫기
    function closeTermsModal(){

        document.getElementById('termsModal').style.display = 'none';
    }

    // 바깥 클릭시 닫기
    window.addEventListener('click', function(event){

        const modal = document.getElementById('termsModal');

        if(event.target === modal){

            closeTermsModal();
        }

    });

</script>

</body>
</html>