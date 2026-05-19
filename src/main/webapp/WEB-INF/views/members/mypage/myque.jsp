<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="menu" value="myque"/>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>지출메이트 - 내 문의</title>

    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/myquestion.css">

    <style>

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

        /* 제목 클릭 */

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

    <%@ include file="/WEB-INF/views/common/layout/sidebar.jspf" %>

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

            <!-- 문의 1 -->
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

            <!-- 문의 2 -->
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

            <!-- 페이지 -->
            <div class="pagination">

                1

            </div>

        </section>

    </main>

</div>

<!-- =========================
     문의 상세 팝업
========================= -->

<div id="questionModal"
     class="question-modal-overlay">

    <div class="question-modal-content">

        <span class="question-close-btn"
              onclick="closeQuestionModal()">

            x

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