<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="menu" value="mysub"/>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 구독 관리</title>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage.css">

    <style>
        /* 이용약관 팝업 */
        .terms-modal-overlay {
            display: none;
            position: fixed; top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.35);
            z-index: 3000;
            justify-content: center;
            align-items: center;
        }
        .terms-modal-content {
            width: 420px;
            background: #f5f5f5;
            border-radius: 20px;
            padding: 28px 38px 30px;
            position: relative;
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        }
        .terms-close-btn {
            position: absolute; top: 18px; right: 22px;
            font-size: 26px; cursor: pointer; color: #555;
        }
        .terms-title {
            text-align: center; font-size: 34px;
            font-weight: 800; margin-bottom: 22px; color: #111;
        }
        .terms-divider {
            width: 100%; height: 1px;
            background: #9f9f9f; margin-bottom: 26px;
        }
        .terms-text {
            min-height: 300px; font-size: 16px;
            line-height: 2.1; color: #222; word-break: keep-all;
        }
        .terms-text p { margin-bottom: 18px; }
        .terms-bottom-line {
            width: 100%; height: 1px;
            background: #9f9f9f; margin: 30px 0 34px;
        }
        .terms-confirm-btn {
            width: 150px; height: 48px; border: none;
            border-radius: 14px; background: #1e2d4d;
            color: white; font-size: 18px; font-weight: 700;
            cursor: pointer; display: block; margin: 0 auto; transition: 0.2s;
        }
        .terms-confirm-btn:hover { opacity: 0.92; }

        /* 해지 확인 모달 */
        .cancel-confirm-overlay {
            display: none;
            position: fixed; top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.45);
            z-index: 3000;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(4px);
        }
        .cancel-confirm-box {
            background: #fff;
            border-radius: 20px;
            padding: 40px 36px;
            max-width: 400px; width: 90%;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }
        .cancel-confirm-box h3 {
            font-size: 20px; font-weight: 800; margin-bottom: 12px;
        }
        .cancel-confirm-box p {
            color: #6b7280; font-size: 14.5px;
            line-height: 1.7; margin-bottom: 28px;
        }
        .cancel-confirm-btns {
            display: flex; gap: 12px;
        }
        .cancel-confirm-btns button {
            flex: 1; padding: 14px; border-radius: 12px;
            font-size: 15px; font-weight: 700; cursor: pointer; border: none;
        }
        .btn-back {
            background: #f3f4f6; color: #374151;
            border: 1.5px solid #e5e7eb !important;
        }
        .btn-confirm-cancel { background: #ef4444; color: #fff; }
    </style>
</head>

<body class="mypage-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <%@ include file="/WEB-INF/views/common/layout/sidebar.jspf" %>

    <main class="manage-container">

        <h2 class="page-title">내 구독 관리</h2>

        <!-- 탭 -->
        <div class="tab-menu">
            <span class="tab active" onclick="switchTab(0)">구독 중</span>
            <span class="tab"        onclick="switchTab(1)">주문 내역</span>
        </div>

        <!-- ===== 구독중 탭 ===== -->
        <div id="sub-active-content" class="tab-content active">

            <c:choose>

                <%-- 구독 데이터가 있을 때 --%>
                <c:when test="${not empty subscriptions}">
                    <div class="manage-grid">

                        <c:forEach var="sub" items="${subscriptions}" varStatus="vs">

                            <%-- 첫 번째 카드는 왼쪽(manage-left), 두 번째부터 오른쪽(manage-right) --%>
                            <section class="${vs.index == 0 ? 'manage-left' : 'manage-right'}">

                                <div class="${vs.index == 0 ? 'sub-manage-card' : 'detail-card'}">

                                    <div class="card-top-content">

                                        <div class="card-header">
                                            <div class="service-info">
                                                <img src="${pageContext.request.contextPath}/images/${sub.logoImage}"
                                                     alt="${sub.serviceName}"
                                                     class="sub-logo-small">
                                                <div>
                                                    <h3>${sub.serviceName}</h3>
                                                    <p class="order-num">주문 번호: ${sub.orderCode}</p>
                                                </div>
                                            </div>
                                            <div class="card-btns">
                                                <button class="btn-extend"
                                                        onclick="location.href='${pageContext.request.contextPath}/subscription/extend/${sub.id}'">
                                                    연장하기
                                                </button>
                                                <button class="btn-cancel"
                                                        onclick="openCancelModal(${sub.id}, '${sub.serviceName}')">
                                                    해지하기
                                                </button>
                                            </div>
                                        </div>

                                        <%-- 첫 번째 카드: 상태 트래커 + 로그 --%>
                                        <c:if test="${vs.index == 0}">
                                            <div class="status-tracker">
                                                <div class="status-step done">
                                                    <img src="${pageContext.request.contextPath}/images/icon-payment.png"
                                                         alt="결제완료" class="step-icon">
                                                    <span class="step-text">결제완료</span>
                                                </div>
                                                <div class="status-arrow">
                                                    <img src="${pageContext.request.contextPath}/images/arrow-right.png" alt="다음">
                                                </div>
                                                <div class="status-step active">
                                                    <img src="${pageContext.request.contextPath}/images/icon-delivery.png"
                                                         alt="배송중" class="step-icon">
                                                    <span class="step-text">배송중</span>
                                                </div>
                                                <div class="status-arrow">
                                                    <img src="${pageContext.request.contextPath}/images/arrow-right.png" alt="다음">
                                                </div>
                                                <div class="status-step">
                                                    <img src="${pageContext.request.contextPath}/images/icon-check.png"
                                                         alt="사용가능" class="step-icon">
                                                    <span class="step-text">사용가능</span>
                                                </div>
                                            </div>

                                            <div class="order-log-box">
                                                <p class="log-title">주문 완료 (${sub.orderLogCode})</p>
                                                <table class="log-table">
                                                    <tr>
                                                        <td>계정 충전 정보/확인</td>
                                                        <td class="text-right">${sub.logDate}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>결제 완료</td>
                                                        <td class="text-right success-text">성공</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </c:if>

                                        <%-- 두 번째 카드: 상태 메시지 + 설명 + 상세 정보 --%>
                                        <c:if test="${vs.index > 0}">
                                            <c:if test="${not empty sub.statusMsg}">
                                                <div class="status-msg-box">${sub.statusMsg}</div>
                                            </c:if>
                                            <c:if test="${not empty sub.description}">
                                                <div class="description-box">
                                                    <p>${sub.description}</p>
                                                </div>
                                            </c:if>

                                            <table class="detail-info-table">
                                                <tr><th>결제 방식</th><td>${sub.paymentMethod}</td></tr>
                                                <tr><th>남은 기간</th><td>${sub.remainingDays}d</td></tr>
                                                <tr><th>가격</th>    <td>${sub.price}원</td></tr>
                                                <tr><th>비밀번호</th><td>${sub.sharedPassword}</td></tr>
                                            </table>
                                        </c:if>

                                    </div><!-- /card-top-content -->

                                    <%-- 하단 버튼 --%>
                                    <c:choose>
                                        <c:when test="${vs.index == 0}">
                                            <button class="view-terms" onclick="openTermsModal()">이용약관 보기</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="view-terms"
                                                    onclick="location.href='${pageContext.request.contextPath}/subscription/auth/${sub.id}'">
                                                2차 인증 붙기
                                            </button>
                                        </c:otherwise>
                                    </c:choose>

                                </div>

                            </section>

                        </c:forEach>

                    </div>
                </c:when>

                <%-- 구독 없을 때 --%>
                <c:otherwise>
                    <div style="text-align:center; padding:80px 0; color:#9ca3af;">
                        <div style="font-size:50px; margin-bottom:16px;">📭</div>
                        <p style="font-size:16px; font-weight:500;">현재 구독 중인 서비스가 없습니다.</p>
                    </div>
                </c:otherwise>

            </c:choose>

        </div><!-- /sub-active-content -->

        <!-- ===== 주문내역 탭 ===== -->
        <div id="order-history-content" class="tab-content">

            <c:choose>
                <c:when test="${not empty orderHistory}">
                    <c:forEach var="order" items="${orderHistory}">
                        <div class="history-card">
                            <div class="history-item">
                                <div class="history-left">
                                    <img src="${pageContext.request.contextPath}/images/${order.logoImage}"
                                         alt="${order.serviceName}" class="sub-logo-small">
                                    <div class="history-info">
                                        <strong>${order.serviceName}</strong>
                                        <span>${order.startDate} ~ ${order.endDate}</span>
                                    </div>
                                </div>
                                <div class="history-right">
                                    <span class="order-code">주문코드 : ${order.orderCode}</span>
                                    <button class="btn-re-sub"
                                            onclick="location.href='${pageContext.request.contextPath}/subscription/resub/${order.id}'">
                                        재구독하기
                                    </button>
                                </div>
                            </div>
                            <hr class="history-divider">
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align:center; padding:80px 0; color:#9ca3af;">
                        <div style="font-size:50px; margin-bottom:16px;">🧾</div>
                        <p style="font-size:16px; font-weight:500;">주문 내역이 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>

        </div><!-- /order-history-content -->

    </main>
</div>

<!-- ===== 이용약관 팝업 ===== -->
<div id="termsModal" class="terms-modal-overlay">
    <div class="terms-modal-content">
        <span class="terms-close-btn" onclick="closeTermsModal()">&times;</span>
        <h2 class="terms-title">이용 약관</h2>
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
        <button class="terms-confirm-btn" onclick="closeTermsModal()">확인</button>
    </div>
</div>

<!-- ===== 해지 확인 모달 ===== -->
<div id="cancelConfirmOverlay" class="cancel-confirm-overlay">
    <div class="cancel-confirm-box">
        <h3>⚠️ 구독 해지</h3>
        <p id="cancelConfirmMsg"></p>
        <div class="cancel-confirm-btns">
            <button class="btn-back" onclick="closeCancelModal()">돌아가기</button>
            <button class="btn-confirm-cancel" id="cancelConfirmAction">해지하기</button>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>
    /* ========== 탭 전환 ========== */
    function switchTab(index) {
        document.querySelectorAll('.tab').forEach((tab, i) => {
            tab.classList.toggle('active', i === index);
        });
        document.querySelectorAll('.tab-content').forEach((content, i) => {
            content.style.display = i === index ? 'block' : 'none';
        });
    }

    document.addEventListener('DOMContentLoaded', function () {
        switchTab(0);
    });

    /* ========== 이용약관 팝업 ========== */
    function openTermsModal() {
        document.getElementById('termsModal').style.display = 'flex';
    }
    function closeTermsModal() {
        document.getElementById('termsModal').style.display = 'none';
    }

    /* ========== 해지 확인 모달 ========== */
    let cancelTargetId = null;

    function openCancelModal(subId, serviceName) {
        cancelTargetId = subId;
        document.getElementById('cancelConfirmMsg').textContent =
            '"' + serviceName + '" 구독을 해지하시겠습니까?\n해지 후에는 서비스 이용이 불가합니다.';
        document.getElementById('cancelConfirmOverlay').style.display = 'flex';
        document.getElementById('cancelConfirmAction').onclick = function () {
            location.href = '${pageContext.request.contextPath}/subscription/cancel/' + cancelTargetId;
        };
    }
    function closeCancelModal() {
        document.getElementById('cancelConfirmOverlay').style.display = 'none';
        cancelTargetId = null;
    }

    /* ========== 바깥 클릭 닫기 ========== */
    window.addEventListener('click', function (event) {
        if (event.target.id === 'termsModal')          closeTermsModal();
        if (event.target.id === 'cancelConfirmOverlay') closeCancelModal();
    });
</script>

</body>
</html>
