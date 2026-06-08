<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 💡 현재 활성화된 메뉴를 'report'로 설정하여 사이드바 불빛을 연동합니다. --%>
<c:set var="menu" value="reports"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%-- 💡 프로젝트 공통 head (메타 태그 및 Pretendard 폰트 등 포함) --%>
    <title>지출메이트 - 내 신고 목록</title>

    <%-- CSS 파일들 불러오기 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myreport.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=2">

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
      /*풋터*/
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
    /*헤더*/
         /* 마이페이지에서는 로그인 버튼 숨김 */
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
         /* 공통 햄버거 사이드바 */
         body.mypage nav.sidebar {
             position: fixed;
             top: 78px;
             left: -260px;

             width: 250px;
             height: calc(100vh - 78px);

             background: white;
             border-right: 1px solid #ddd;

             transition: all 0.3s ease;

             z-index: 9998;

             padding-top: 20px;
         }

         body.mypage nav.sidebar.open {
             left: 0;
         }

 body.mypage nav.sidebar {
     position: fixed;
     top: 78px;
     left: -260px;
     width: 250px;
     height: calc(100vh - 78px);

     background: #243864; /* ⭐ 네이비 (핵심) */
     border-right: none;

     transition: all 0.3s ease;
     z-index: 9998;
     padding-top: 20px;
 }

 body.mypage nav.sidebar.open {
     left: 0;
 }

 /* 리스트 기본 */
 body.mypage nav.sidebar ul {
     list-style: none;
     padding: 0;
     margin: 0;
 }

 /* 메뉴 아이템 */
 body.mypage nav.sidebar li {
     width: 100%;
 }

 /* 링크 */
 body.mypage nav.sidebar li a {
     display: flex;
     align-items: center;

     height: 54px;
     padding: 0 24px;

     color: white; /* ⭐ 네이비라서 흰 글씨 */
     text-decoration: none;
     font-size: 16px;
     font-weight: 500;

     transition: 0.2s;
 }

 /* hover */
 body.mypage nav.sidebar li a:hover {
     background: rgba(255, 255, 255, 0.12);
 }

 /* 로그아웃 영역 */
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

         /* 마이페이지에서는 공통 사이드 드롭다운 숨김 */
         body.mypage .sidebar-overlay,
         body.mypage .sidebar-drawer,
         body.mypage .sidebar-menu,
         body.mypage .mobile-sidebar {
             display: none !important;
         }
        /* 공통 헤더 */
     body.mypage .site-header {
         position: fixed !important;
         top: 0 !important;
         left: 0 !important;
         width: 100% !important;
         height: 78px !important;
         background: #243864 !important;

         display: flex !important;
         align-items: center !important;
         justify-content: center !important;

         z-index: 9999 !important;
     }

        /* 우측 영역 */
       body.mypage .header-action-area {
            position: absolute;
            right: 36px;
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
            border-radius: 12px !important;

            background: rgba(255,255,255,0.15) !important;
            color: white !important;

            font-size: 22px !important;
        }

        body.mypage .header-action-area {
            position: absolute !important;
            right: 36px !important;
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

        /* 1. 마이페이지 공통 레이아웃 틀 고정 (사이드바 + 메인 정렬) */
        .container {
            display: flex !important;
            flex-direction: row !important;
            align-items: stretch !important;
            gap: 26px !important;
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 0;
        }

        /* =========================
           신고 상세 팝업 레이아웃 고정
        ========================= */
        .report-modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.35);
            z-index: 3000;
            justify-content: center;
            align-items: center;
        }

        .report-modal-content {
            width: 780px;
            background: #f5f5f5;
            border-radius: 18px;
            padding: 22px 20px 30px;
            position: relative;
            border: 1px solid #bdbdbd;
        }

        .report-close-btn {
            position: absolute;
            top: 12px;
            right: 18px;
            font-size: 30px;
            font-weight: bold;
            cursor: pointer;
            color: #111;
        }

        .report-detail-title {
            font-size: 22px;
            font-weight: 700;
            color: #111;
            margin-bottom: 12px;
        }

        .report-divider {
            width: 100%;
            height: 1px;
            background: #8f8f8f;
            margin-bottom: 20px;
        }

        .report-box, .answer-box {
            width: 100%;
            min-height: 180px;
            border: 1px solid #c7c7c7;
            border-radius: 16px;
            background: white;
            padding: 16px;
            margin-bottom: 20px;
            font-size: 16px;
            color: #333;
            line-height: 1.8;
        }

        .confirm-btn {
            width: 115px;
            height: 42px;
            border: none;
            border-radius: 14px;
            background: #1e2d4d;
            color: white;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 20px;
            float: right;
        }

        .confirm-btn:hover {
            opacity: 0.92;
        }

        /* 제목 클릭 링크 효과 */
        .report-title-link {
            cursor: pointer;
            transition: 0.2s;
        }

        .report-title-link:hover {
            color: #1e2d4d;
            text-decoration: underline;
        }
    </style>
</head>

<body class="mypage">

<%-- 💡 공통 헤더 include --%>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<%-- 다른 페이지들과 완벽히 대칭되는 마이페이지 공통 감싸는 틀 --%>
<div class="mypage-container">

    <%-- 💡 공통 사이드바 include로 교체 (기존 하드코딩 제거) --%>
    <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>

    <%-- 메인 본문 (style="flex: 1;"을 주어 사이드바 자리를 확실히 양보받음) --%>
    <main class="report-main" style="flex: 1; min-width: 0;">

        <h1 class="page-title">내 신고 목록</h1>

        <section class="report-card">

            <div class="table-header">
                <div class="col-no">순번</div>
                <div class="col-title">제목</div>
                <div class="col-answer">답변여부</div>
                <div class="col-date">문의시각</div>
                <div class="col-manage"></div>
            </div>

            <div class="table-row">
                <div class="col-no">1.</div>
                <div class="col-title report-title-link"
                     onclick="openReportModal(
                        '욕설 신고',
                        '상대방이 채팅에서 지속적으로 욕설을 사용했습니다.',
                        '해당 회원에게 경고 조치가 완료되었습니다.'
                     )">
                    욕 신고
                </div>
                <div class="col-answer">답변 전</div>
                <div class="col-date">05/04 15:33</div>
                <div class="col-manage">
                    <button class="delete-btn">삭제하기</button>
                </div>
            </div>

            <div class="table-row">
                <div class="col-no">2.</div>
                <div class="col-title report-title-link"
                     onclick="openReportModal(
                        '패드립 신고',
                        '채팅 중 패드립 및 비하 발언을 했습니다.',
                        '운영진 확인 후 7일 정지 처리되었습니다.'
                     )">
                    패드립 신고
                </div>
                <div class="col-answer complete">답변 완료</div>
                <div class="col-date">05/03 19:52</div>
                <div class="col-manage">
                    <button class="delete-btn">삭제하기</button>
                </div>
            </div>

            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>

            <div class="pagination">
                1
            </div>

        </section>

    </main>

</div>

<div id="reportModal" class="report-modal-overlay">
    <div class="report-modal-content">
        <span class="report-close-btn" onclick="closeReportModal()">&times;</span>
        <div class="report-detail-title" id="modalTitle">신고 상세 내용</div>
        <div class="report-divider"></div>
        <div class="report-box" id="modalReport">신고 내용</div>
        <div class="answer-box" id="modalAnswer">관리자 답변</div>
        <button class="confirm-btn" onclick="closeReportModal()">확인</button>
    </div>
</div>
 <%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>


<script>
    // 신고 팝업 열기
    function openReportModal(title, report, answer){
        document.getElementById('modalTitle').innerText = title;
        document.getElementById('modalReport').innerText = report;
        document.getElementById('modalAnswer').innerText = answer;
        document.getElementById('reportModal').style.display = 'flex';
    }

    // 신고 팝업 닫기
    function closeReportModal(){
        document.getElementById('reportModal').style.display = 'none';
    }

    // 바깥 어두운 배경 클릭 시 팝업 닫기
    window.addEventListener('click', function(event){
        const modal = document.getElementById('reportModal');
        if(event.target === modal){
            closeReportModal();
        }
    });
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