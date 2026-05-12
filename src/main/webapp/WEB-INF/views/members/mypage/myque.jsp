<%-- 경로: src/main/webapp/WEB-INF/views/members/mypage/myque.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 문의</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myquestion.css">

    <style>

        /* ========================= */
        /* 문의 상세 팝업 */
        /* ========================= */

        .question-modal{
            display:none;

            position:fixed;
            top:0;
            left:0;

            width:100%;
            height:100%;

            background:rgba(0,0,0,0.35);

            z-index:9999;

            justify-content:center;
            align-items:center;
        }

        .question-modal-content{

            width:700px;

            background:white;

            border-radius:10px;

            padding:20px;

            position:relative;
        }

        .modal-close{

            position:absolute;

            top:15px;
            right:18px;

            font-size:18px;

            cursor:pointer;
        }

        .modal-title{

            font-size:28px;

            font-weight:700;

            margin-bottom:10px;

            color:#333;
        }

        .modal-line{

            width:100%;

            height:1px;

            background:#999;

            margin-bottom:20px;
        }

        .modal-box{

            width:100%;

            min-height:120px;

            border:1px solid #d9d9d9;

            border-radius:8px;

            padding:15px;

            margin-bottom:15px;

            font-size:13px;

            color:#333;

            line-height:1.7;

            white-space:pre-line;
        }

        .modal-btn-wrap{

            display:flex;

            justify-content:flex-end;
        }

        .modal-confirm-btn{

            width:90px;

            height:35px;

            border:none;

            border-radius:10px;

            background:#1e2d4d;

            color:white;

            font-size:12px;

            cursor:pointer;
        }

    </style>
</head>
<body>

<header class="top-nav">
    <div class="menu-icon">☰</div>

    <div class="logo"
         onclick="location.href='${pageContext.request.contextPath}/index'"
         style="cursor:pointer;">
        지출메이트
    </div>

    <div class="my-page">마이페이지</div>
</header>

<div class="container">

    <aside class="sidebar">
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/members/mypage/mypage">
                    대시보드
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/members/mypage/mysub">
                    내 구독 관리
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/members/mypage/mypost">
                    내 게시글 보기
                </a>
            </li>

            <li class="active">
                <a href="${pageContext.request.contextPath}/members/mypage/myque">
                    내 문의
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/members/mypage/myreport">
                    내 신고 목록
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/members/mypage/myalarm">
                    알림
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/members/mypage/mysale">
                    내 판매 목록
                </a>
            </li>
        </ul>
    </aside>

    <main class="question-main">

        <h1 class="page-title">내 문의</h1>

        <section class="question-card">

            <!-- 헤더 -->
            <div class="table-header">
                <div class="col-no">순번</div>
                <div class="col-title">제목</div>
                <div class="col-answer">답변여부</div>
                <div class="col-date">문의시각</div>
                <div class="col-manage"></div>
            </div>

            <!-- 데이터 -->
            <c:choose>

                <c:when test="${not empty questionList}">

                    <c:forEach var="que" items="${questionList}" varStatus="status">

                        <div class="table-row">

                            <div class="col-no">
                                ${status.count}.
                            </div>

                            <!-- 제목 클릭 -->
                            <div class="col-title"
                                 style="cursor:pointer;"
                                 onclick="openQuestionModal(
                                     '${que.title}',
                                     '${que.content}',
                                     '${que.answer}'
                                 )">

                                <c:out value="${que.title}" />
                            </div>

                            <!-- 답변 여부 -->
                            <div class="col-answer ${que.answered ? 'complete' : ''}">
                                ${que.answered ? '답변 완료' : '답변 전'}
                            </div>

                            <!-- 날짜 -->
                            <div class="col-date">
                                ${que.regDate}
                            </div>

                            <!-- 삭제 -->
                            <div class="col-manage">

                                <button class="delete-btn"
                                        onclick="if(confirm('문의를 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/support/qna/delete?id=${que.id}'">

                                    삭제하기

                                </button>

                            </div>

                        </div>

                    </c:forEach>

                    <!-- 빈 줄 -->
                    <c:if test="${questionList.size() < 10}">

                        <c:forEach begin="1" end="${10 - questionList.size()}">

                            <div class="empty-line"></div>

                        </c:forEach>

                    </c:if>

                </c:when>

                <!-- 데이터 없음 -->
                <c:otherwise>

                    <div class="table-row"
                         style="justify-content:center; color:#999;">

                        문의하신 내역이 없습니다.

                    </div>

                    <c:forEach begin="1" end="9">

                        <div class="empty-line"></div>

                    </c:forEach>

                </c:otherwise>

            </c:choose>

            <!-- 페이지네이션 -->
            <div class="pagination">

                <c:choose>

                    <c:when test="${not empty totalPages && totalPages > 0}">

                        <c:forEach var="p" begin="1" end="${totalPages}">

                            <span class="page-num ${p == currentPage ? 'active' : ''}"
                                  onclick="location.href='${pageContext.request.contextPath}/members/mypage/myque?page=${p}'"
                                  style="cursor:pointer; margin:0 5px;">

                                ${p}

                            </span>

                        </c:forEach>

                    </c:when>

                    <c:otherwise>

                        1

                    </c:otherwise>

                </c:choose>

            </div>

        </section>

    </main>

</div>

<!-- ========================= -->
<!-- 문의 상세 팝업 -->
<!-- ========================= -->

<div class="question-modal" id="questionModal">

    <div class="question-modal-content">

        <div class="modal-close"
             onclick="closeQuestionModal()">
            ×
        </div>

        <div class="modal-title" id="modalTitle">
            문의 제목
        </div>

        <div class="modal-line"></div>

        <!-- 문의 내용 -->
        <div class="modal-box" id="modalContent">
            문의 내용
        </div>

        <!-- 관리자 답변 -->
        <div class="modal-box" id="modalAnswer">
            관리자 답변
        </div>

        <div class="modal-btn-wrap">

            <button class="modal-confirm-btn"
                    onclick="closeQuestionModal()">

                확인

            </button>

        </div>

    </div>

</div>

<script>

    /* ========================= */
    /* 문의 팝업 열기 */
    /* ========================= */

    function openQuestionModal(title, content, answer){

        document.getElementById('questionModal').style.display = 'flex';

        document.getElementById('modalTitle').innerText = title;

        document.getElementById('modalContent').innerText = content;

        if(answer && answer.trim() !== ''){

            document.getElementById('modalAnswer').innerText = answer;

        }else{

            document.getElementById('modalAnswer').innerText =
                '아직 등록된 답변이 없습니다.';
        }
    }

    /* ========================= */
    /* 팝업 닫기 */
    /* ========================= */

    function closeQuestionModal(){

        document.getElementById('questionModal').style.display = 'none';
    }

    /* ========================= */
    /* 배경 클릭시 닫기 */
    /* ========================= */

    window.onclick = function(e){

        const modal = document.getElementById('questionModal');

        if(e.target === modal){

            modal.style.display = 'none';
        }
    }

</script>

</body>
</html>