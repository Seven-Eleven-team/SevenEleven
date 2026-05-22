<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menu" value="inquiries"/>

<!DOCTYPE html>
<html lang="ko">

<head>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <title>지출메이트 - 내 문의</title>

    <!-- 공통 마이페이지 css -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <!-- 현재 페이지 css -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/myque.css">

    <style>

        /* 1. 마이페이지 공통 레이아웃 틀 고정 (사이드바 + 메인 정렬) */
               .mypage-container {
                   display: flex !important;
                   flex-direction: row !important;
                   align-items: stretch !important;
                   gap: 26px !important;
                   max-width: 1200px;
                   margin: 0 auto;
                   padding: 40px 0;
               }

               /* 2. 공통 사이드바 크기 및 위아래 중앙 가로막 정렬 스타일링 */
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

        /* =========================
           메인 영역
        ========================= */
        .question-main{
            flex:1;
        }

        /* =========================
           문의 상세 팝업
        ========================= */
        .question-modal-overlay{
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

        .question-modal-content{
            width:780px;
            background:#f5f5f5;
            border-radius:18px;
            padding:22px 20px 30px;
            position:relative;
            border:1px solid #bdbdbd;
        }

        .question-close-btn{
            position:absolute;
            top:12px;
            right:18px;
            font-size:30px;
            font-weight:bold;
            cursor:pointer;
            color:#111;
        }

        .question-detail-title{
            font-size:22px;
            font-weight:700;
            color:#111;
            margin-bottom:12px;
        }

        .question-divider{
            width:100%;
            height:1px;
            background:#8f8f8f;
            margin-bottom:20px;
        }

        .question-box{
            width:100%;
            min-height:180px;
            border:1px solid #c7c7c7;
            border-radius:16px;
            background:white;
            padding:16px;
            margin-bottom:20px;
            font-size:16px;
            color:#333;
            line-height:1.8;
        }

        .answer-box{
            width:100%;
            min-height:180px;
            border:1px solid #c7c7c7;
            border-radius:16px;
            background:white;
            padding:16px;
            font-size:16px;
            color:#333;
            line-height:1.8;
        }

        .confirm-btn{
            width:115px;
            height:42px;
            border:none;
            border-radius:14px;
            background:#1e2d4d;
            color:white;
            font-size:16px;
            font-weight:700;
            cursor:pointer;
            margin-top:20px;
            float:right;
        }

        .confirm-btn:hover{
            opacity:0.92;
        }

        .question-title-link{
            cursor:pointer;
            transition:0.2s;
        }

        .question-title-link:hover{
            color:#1e2d4d;
            text-decoration:underline;
        }

    </style>

</head>

<body class="mypage-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>

    <!-- 메인 -->
    <main class="question-main">

        <h1 class="page-title">
            내 문의
        </h1>

        <section class="question-card">

            <!-- 헤더 -->
            <div class="table-header">

                <div class="col-no">
                    순번
                </div>

                <div class="col-title">
                    제목
                </div>

                <div class="col-answer">
                    답변여부
                </div>

                <div class="col-date">
                    문의시각
                </div>

                <div class="col-manage"></div>

            </div>

            <!-- 문의 -->
            <div class="table-row">

                <div class="col-no">
                    1.
                </div>

                <div class="col-title question-title-link"
                     onclick="openQuestionModal(
                        '컴퓨터가 안켜져요',
                        '어떻게하면 컴퓨터를 킬까요',
                        '전원 버튼을 누르시면 됩니다.'
                     )">

                    어떻게 해요

                </div>

                <div class="col-answer complete">
                    답변 완료
                </div>

                <div class="col-date">
                    05/04 15:33
                </div>

                <div class="col-manage">

                    <button class="delete-btn">
                        삭제하기
                    </button>

                </div>

            </div>

            <!-- 문의 -->
            <div class="table-row">

                <div class="col-no">
                    2.
                </div>

                <div class="col-title question-title-link"
                     onclick="openQuestionModal(
                        '문의 대기중',
                        '문의 내용을 확인중입니다.',
                        '아직 답변이 등록되지 않았습니다.'
                     )">

                    내용 그대로

                </div>

                <div class="col-answer">
                    답변 전
                </div>

                <div class="col-date">
                    05/03 19:52
                </div>

                <div class="col-manage">

                    <button class="delete-btn">
                        삭제하기
                    </button>

                </div>

            </div>

            <!-- 빈 줄 -->
            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>
            <div class="empty-line"></div>

            <!-- 페이지네이션 -->
            <div class="pagination">
                1
            </div>

        </section>

    </main>

</div>

<!-- 문의 팝업 -->
<div id="questionModal" class="question-modal-overlay">

    <div class="question-modal-content">

        <span class="question-close-btn"
              onclick="closeQuestionModal()">

            &times;

        </span>

        <div class="question-detail-title"
             id="modalTitle">

            컴퓨터가 안켜져요

        </div>

        <div class="question-divider"></div>

        <div class="question-box"
             id="modalQuestion">

            어떻게하면 컴퓨터를 킬까요

        </div>

        <div class="answer-box"
             id="modalAnswer">

            전원 버튼을 누르시면 됩니다.

        </div>

        <button class="confirm-btn"
                onclick="closeQuestionModal()">

            확인

        </button>

    </div>

</div>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>

    // 문의 팝업 열기
    function openQuestionModal(title, question, answer){

        document.getElementById('modalTitle').innerText = title;
        document.getElementById('modalQuestion').innerText = question;
        document.getElementById('modalAnswer').innerText = answer;

        document.getElementById('questionModal').style.display = 'flex';
    }

    // 문의 팝업 닫기
    function closeQuestionModal(){

        document.getElementById('questionModal').style.display = 'none';
    }

    // 바깥 클릭 시 닫기
    window.addEventListener('click', function(event){

        const modal = document.getElementById('questionModal');

        if(event.target === modal){
            closeQuestionModal();
        }
    });

</script>

</body>
</html>