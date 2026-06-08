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
       DESKTOP 기본 레이아웃 보존
    ========================= */
    .mypage-container {
        display: flex;
        gap: 20px;
    }

    /* 카드들이 줄어들 때 깨짐 방지 */
    .info-side,
    .alert-side,
    .card {
        min-width: 0;
    }

    /* 하단 행 - 내 구독과 내 소비 목표가 나란히 배치되도록 복구 */
    .bottom-row {
        display: flex;
        flex-direction: row;
        gap: 20px;
        width: 100%;
    }

    .mypost-card,
    .goal-card {
        flex: 1; /* 반반씩 균등하게 차지 */
        min-width: 0;
    }

    /* =========================
       TABLET (1024px 이하) 반응형 소스
    ========================= */
    @media (max-width: 1024px) {
        .mypage-container {
            flex-direction: column;
            padding: 12px;
        }

        .profile-combined-card {
            flex-direction: column;
            gap: 16px;
        }

        .info-side,
        .alert-side {
            width: 100%;
            max-width: 100%;
        }

        /* 화면이 좁아질 때만 세로로 떨어지게 설정 */
        .bottom-row {
            flex-direction: column;
            gap: 16px;
        }

        .card {
            width: 100%;
        }
    }

    /* =========================
       MOBILE (768px 이하)
    ========================= */
    @media (max-width: 768px) {
        .mypage-container {
            padding: 8px;
        }

        body.mypage .hamburger-btn {
            left: 12px !important;
        }

        body.mypage .header-action-area {
            right: 12px !important;
        }

        body.mypage nav.sidebar {
            width: 220px;
        }

        .account-info-card {
            padding: 12px;
        }

        .single-account-box {
            padding: 18px;
        }

        .sub-item {
            flex-direction: column;
            align-items: flex-start;
            gap: 6px;
        }

        .cancel-link {
            align-self: flex-end;
        }
    }

    /* =========================
       SMALL MOBILE (480px 이하)
    ========================= */
    @media (max-width: 480px) {
        .card-title-center {
            font-size: 16px;
        }

        .info-row strong {
            font-size: 13px;
        }

        .account-info-card {
            padding: 10px;
        }

        .change-account-btn,
        .add-account-btn {
            font-size: 13px;
            padding: 10px;
        }

        body.mypage nav.sidebar {
            width: 200px;
        }
    }

    body.mypage .hamburger-btn {
        display: flex !important;
        flex-direction: column !important;
        justify-content: center !important;
        align-items: center !important;
        gap: 4px !important;
    }

    body.mypage .hamburger-btn span {
        display: block !important;
        width: 22px !important;
        height: 2px !important;
        background: white !important;
        border-radius: 999px !important;
    }

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

    .card-title-center {
        font-size: 18px;
        font-weight: 800;
        text-align: center;
        margin-bottom: 18px;
        color: #222;
    }

    .single-account-box {
        border: 2px solid #1e2d4d;
        border-radius: 20px;
        background: #f8fafc;
        padding: 28px 24px;
        min-height: 220px;
        height: auto;
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .account-info-card {
        background: #f9fafc;
        border: 1px solid #eee;
        border-radius: 12px;
        padding: 16px;
        display: flex;
        flex-direction: column;
        gap: 12px;
        min-height: 100px;
        box-sizing: border-box;
    }

    .account-top {
        display: flex;
        align-items: center;
        gap: 12px;
    }

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

    .main-bank-info {
        display: flex;
        flex-direction: column;
        flex: 1;
        min-width: 0;
    }

    .main-bank-info strong {
        font-size: 15px;
        font-weight: 800;
        color: #222;
    }

    .main-bank-info span {
        font-size: 13px;
        color: #666;
        margin-top: 2px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        display: block;
    }

    .account-notice {
        font-size: 12px;
        color: #888;
        line-height: 1.4;
    }

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

    .change-account-btn { background: #1e2d4d; color: #fff; }
    .change-account-btn:hover { opacity: 0.9; }
    .add-account-btn { background: #ff4d4d; color: #fff; }
    .add-account-btn:hover { opacity: 0.9; }
    .no-account { text-align: center; font-size: 14px; color: #777; margin-bottom: 10px; }

    .footer { width: 100%; background: #243864; color: white; padding: 40px 0; margin-top: 60px; }
    body.mypage { padding-top: 78px; min-height: 100vh; display: flex; flex-direction: column; }
    .mypage-container { flex: 1; }
    body.mypage .auth-link { display: none !important; }
    body.mypage .header-action-area { position: absolute !important; right: 36px !important; }
    body.mypage .user-profile-link { display: flex !important; }


    /* =========================
           개인 소비 목표 UI 개선
        ========================= */
        .goal-card .main-goal {
            background: #fff5f5;
            border: 1px solid #ffe3e3;
            padding: 20px;
            border-radius: 14px;
            margin-bottom: 20px;
        }
        .goal-card .main-goal-title {
            color: #ff4d4d;
            font-size: 14px;
            font-weight: 800;
            margin: 0 0 10px 0;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .goal-card .goal-item {
            padding: 15px 10px;
            border-bottom: 1px dashed #eee;
        }
        .goal-card .goal-item:last-child {
            border-bottom: none;
        }
        .goal-card .goal-name {
            font-size: 16px;
            font-weight: 700;
            color: #333;
            margin: 0 0 12px 0;
        }
        .goal-card .progress-bg {
            position: relative;
            width: 100%;
            height: 24px;
            background-color: #f1f3f5;
            border-radius: 12px;
            overflow: hidden;
        }
        .goal-card .progress-bar {
            height: 100%;
            width: 0%;
            border-radius: 12px;
            transition: width 1.5s ease-in-out, background-color 0.5s;
        }
        .goal-card .progress-text {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 13px;
            font-weight: 800;
            color: #495057;
            z-index: 2;
        }

        /* 대시보드에서 가져온 깔끔한 게이지바 스타일 */
        .progress-bg {
            background: #F0F5F9;
            height: 16px;
            border-radius: 8px;
            width: 100%;
            overflow: hidden;
            margin: 8px 0;
        }
        .progress-fill {
            height: 100%;
            border-radius: 8px;
            background-color: #3F72AF; /* 대시보드와 동일한 파란색 */
            transition: width 1.2s ease;
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

    body.mypage nav.sidebar.open { left: 0; }
    body.mypage nav.sidebar ul { list-style: none; padding: 0; margin: 0; }
    body.mypage nav.sidebar li { width: 100%; }
    body.mypage nav.sidebar li a {
        display: flex; align-items: center; height: 54px; padding: 0 24px;
        color: white; text-decoration: none; font-size: 16px; font-weight: 500; transition: 0.2s;
    }
    body.mypage nav.sidebar li a:hover { background: rgba(255, 255, 255, 0.12); }
    .sidebar-logout { position: absolute; bottom: 20px; left: 0; width: 100%; }
    .sidebar-logout a { display: flex; align-items: center; gap: 8px; padding: 0 24px; height: 54px; color: white; text-decoration: none; }
    .sidebar-logout a:hover { background: rgba(255, 255, 255, 0.12); }

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
    .form-group select, .form-group input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 10px; font-size: 15px; }
    .current-account-card { background: #f8fafc; padding: 15px; border-radius: 12px; margin-bottom: 20px; border: 1px solid #e2e8f0; font-size: 14px; color: #666; }
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

    .card-header-group { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .card-title { margin: 0; }
    .more-link { font-size: 14px; color: #243864; text-decoration: none; font-weight: 600; cursor: pointer; order: 2; }
    .more-link:hover { text-decoration: underline; color: #ff4d4d; }
    .cancel-link { font-size: 14px; color: #243864; font-weight: 600; text-decoration: none; cursor: pointer; }
    .cancel-link:hover { text-decoration: underline; color: #ff4d4d; }
    </style>
</head>
<body class="mypage">
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
<div class="mypage-container">
    <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>

    <main class="dashboard" style="flex: 1;">
        <section class="profile-combined-card">
            <div class="info-side">
                <h3 class="card-title-center">내 정보</h3>
                <div class="info-body">
                    <div class="profile-section">
                        <div class="profile-img-box" style="display: flex; align-items: center; justify-content: center; background-color: #243864; color: white; font-size: 50px; font-weight: bold; border-radius: 50%; width: 140px; height: 140px; margin: 0 auto 15px auto; overflow: hidden; flex-shrink: 0; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">

                            <c:choose>
                                <%-- 백엔드에서 넘겨줄 profileImageUrl 사용 --%>
                                <c:when test="${not empty profileImageUrl}">
                                    <img src="${profileImageUrl}" alt="프로필 사진" style="width: 100%; height: 100%; object-fit: cover;">
                                </c:when>

                                <%-- 사진이 없을 때는 이니셜 표시 --%>
                                <c:otherwise>
                                    ${not empty summary.nickname ? fn:substring(summary.nickname, 0, 1) : 'U'}
                                </c:otherwise>
                            </c:choose>

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

        <!-- 🌟 원래 레이아웃 복원: 내 구독과 내 소비 목표가 좌우로 나란히 정렬됩니다. -->
        <div class="bottom-row">
            <!-- [왼쪽] 내 구독 관리 카드 -->
            <section class="mypost-card" style="padding: 30px; background: #fff; border: 1px solid #e6e6e6; border-radius: 16px; box-sizing: border-box;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 22px;">
                    <h2 style="font-size: 22px; font-weight: 800; color: #111; margin: 0;">내 구독</h2>
                    <a href="${pageContext.request.contextPath}/subscription/my"
                       style="color: #ff4d4d; font-size: 14px; font-weight: bold; text-decoration: none; transition: 0.2s;"
                       onmouseover="this.style.opacity=0.8" onmouseout="this.style.opacity=1">
                        전체보기 &gt;
                    </a>
                </div>

                <div style="display: flex; flex-direction: column; gap: 14px;">
                    <c:choose>
                        <c:when test="${empty top3Subscriptions}">
                            <div style="text-align: center; padding: 50px 0; color: #888; font-size: 15px; background: #fafafa; border-radius: 12px;">
                                현재 이용 중인 구독 서비스가 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                          <c:forEach var="sub" items="${top3Subscriptions}">
                              <div style="display: flex; justify-content: space-between; align-items: center; padding: 18px 24px; background: #fafafa; border: 1px solid #eeeeee; border-radius: 16px;">
                                  <div>
                                      <c:choose>
                                          <c:when test="${sub.status eq 'ACTIVE' || sub.status eq 'active'}">
                                              <span style="font-size: 12px; color: #2ecc71; font-weight: bold; background: #e8f8f0; padding: 4px 10px; border-radius: 8px; display: inline-block; margin-bottom: 8px;">이용중</span>
                                          </c:when>
                                          <c:when test="${sub.status eq 'CANCELLED' || sub.status eq 'cancelled'}">
                                              <span style="font-size: 12px; color: #ff4d4d; font-weight: bold; background: #fff5f5; padding: 4px 10px; border-radius: 8px; display: inline-block; margin-bottom: 8px;">해지됨</span>
                                          </c:when>
                                          <c:otherwise>
                                              <span style="font-size: 12px; color: #7f8c8d; font-weight: bold; background: #f5f6f7; padding: 4px 10px; border-radius: 8px; display: inline-block; margin-bottom: 8px;">${sub.status}</span>
                                          </c:otherwise>
                                      </c:choose>
                                      <strong style="font-size: 17px; color: #111; display: block; margin-bottom: 6px;">
                                          ${sub.serviceName}
                                      </strong>
                                      <span style="font-size: 13px; color: #666; font-weight: 500; display: block;">
                                          이용 기간: ${sub.startDate != null ? sub.startDate : '-'} ~ ${sub.endDate != null ? sub.endDate : '-'}
                                      </span>
                                  </div>
                                  <div style="text-align: right; align-self: center;">
                                      <span style="font-size: 16px; font-weight: 700; color: #111; display: block;">
                                          ${sub.monthlyFee}원 <span style="font-size: 13px; font-weight: 500; color: #666;">/ 월</span>
                                      </span>
                                  </div>
                              </div>
                          </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

           <!-- [오른쪽] 내 소비 목표 카드 -->
           <section class="card goal-card" style="padding: 30px; background: #fff; border: 1px solid #e6e6e6; border-radius: 16px; box-sizing: border-box;">
               <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 22px;">
                   <h2 style="font-size: 22px; font-weight: 800; color: #111; margin: 0;">내 개인 소비 목표</h2>
                   <a href="/dashboard"
                      style="color: #ff4d4d; font-size: 14px; font-weight: bold; text-decoration: none; transition: 0.2s;"
                      onmouseover="this.style.opacity=0.8" onmouseout="this.style.opacity=1">
                       전체보기 &gt;
                   </a>
               </div>
                <%-- 고정 목표 --%>
                <c:if test="${not empty fixedGoal}">
                    <div class="main-goal">
                        <p class="main-goal-title">🔥 가장 중요한 목표</p>
                        <p class="goal-name">${fixedGoal.goalName}</p>
                        <div class="progress-bg">
                            <div class="progress-fill" style="width: ${fixedGoal.targetAmount > 0 ? (fixedGoal.savedAmount * 100.0 / fixedGoal.targetAmount) : 0}%; background-color: #ffb300;"></div>
                        </div>
                        <div style="display: flex; justify-content: space-between; font-size: 13px;">
                             <span>₩<fmt:formatNumber value="${fixedGoal.savedAmount}" pattern="#,##0" /></span>
                             <span><fmt:formatNumber value="${fixedGoal.targetAmount > 0 ? (fixedGoal.savedAmount * 100.0 / fixedGoal.targetAmount) : 0}" pattern="##0.0"/>%</span>
                        </div>
                    </div>
                </c:if>

                <%-- 일반 목표 --%>
                <c:forEach var="goal" items="${normalGoals}">
                    <div class="goal-item">
                        <p class="goal-name">${goal.goalName}</p>
                        <div class="progress-bg">
                            <div class="progress-fill" style="width: ${goal.targetAmount > 0 ? (goal.savedAmount * 100.0 / goal.targetAmount) : 0}%;"></div>
                        </div>
                        <div style="display: flex; justify-content: space-between; font-size: 13px;">
                             <span>₩<fmt:formatNumber value="${goal.savedAmount}" pattern="#,##0" /></span>
                             <span><fmt:formatNumber value="${goal.targetAmount > 0 ? (goal.savedAmount * 100.0 / goal.targetAmount) : 0}" pattern="##0.0"/>%</span>
                        </div>
                    </div>
                </c:forEach>

                <%-- 둘 다 없을 때 --%>
                <c:if test="${empty fixedGoal && empty normalGoals}">
                    <div style="text-align: center; padding: 50px 0; color: #888; font-size: 15px; background: #fafafa; border-radius: 12px;">
                        등록된 소비 목표가 없습니다.
                    </div>
                </c:if>
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

            <input type="hidden" name="primary" id="primary" value="true">

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
        <button class="leave-btn" onclick="submitWithdraw()">탈퇴하기</button>
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

        let targetBank = "";
        let targetNum = "";
        let targetId = "";

        <c:if test="${not empty accounts}">
            <c:set var="acc" value="${accounts[0]}"/>
            targetBank = "${not empty acc.bankName ? acc.bankName : ''}";
            targetNum = "${not empty acc.accountNumber ? acc.accountNumber : ''}";
            targetId = "${not empty acc.id ? acc.id : ''}";
        </c:if>

        document.getElementById('currentAccText').textContent = targetBank + " " + targetNum;
        document.getElementById('accountId').value = targetId;

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
                const textSpan = progressBar.nextElementSibling;

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
                                if(textSpan) textSpan.innerText = targetValue + '%';
                            } else {
                                if(textSpan) textSpan.innerText = count + '%';
                                count++;
                            }
                        }, 1500 / targetValue);
                    } else {
                        if(textSpan) textSpan.innerText = '0%';
                    }
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

    // 회원 탈퇴 실행 함수 추가 (fetch API 사용)
        function submitWithdraw() {
            if(confirm("정말로 탈퇴를 진행하시겠습니까?\n(탈퇴 시 30일 유예 기간이 적용됩니다)")) {

                fetch('${pageContext.request.contextPath}/user/withdraw', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(res => res.json())
                .then(data => {
                    if(data.success) {
                        alert(data.message);
                        window.location.href = '${pageContext.request.contextPath}/'; // 성공 시 메인 화면으로 튕겨냄
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("서버 통신 중 오류가 발생했습니다.");
                });
            }
        }
</script>
</body>
</html>