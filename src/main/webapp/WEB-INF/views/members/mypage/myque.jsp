<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="menu" value="questions"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 문의</title>

    <!-- 공통 및 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myque.css">

    <style>
        /* 풋터 및 기본 배경 */
        .footer { width: 100%; background: #243864; color: white; padding: 40px 0; margin-top: 60px; }
        body.mypage { padding-top: 78px; min-height: 100vh; display: flex; flex-direction: column; background: #f5f5f5; }

        /* 레이아웃 틀 고정 (사이드바 + 메인) */
        .mypage-container {
            display: flex !important;
            flex-direction: row !important;
            align-items: stretch !important;
            gap: 26px !important;
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 0;
            flex: 1;
        }

        /* 헤더 고정 스타일 */
        body.mypage .site-header {
            position: fixed !important; top: 0 !important; left: 0 !important;
            width: 100% !important; height: 78px !important;
            background: #243864 !important; display: flex !important;
            align-items: center !important; justify-content: center !important; z-index: 9999 !important;
        }

        /* 사이드바 스타일 */
        .mypage-sidebar {
            width: 250px !important; min-width: 250px !important; height: auto !important;
            background: #ffffff !important; border: 1px solid #dddddd !important;
            border-radius: 20px !important; padding: 0 !important; display: flex !important;
            align-items: center !important;
        }

        /* 메인 영역 */
        .question-main { flex: 1; }

        /* ✅ 제목과 버튼을 한 줄로 배치하기 위한 헤더 스타일 */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .page-title {
            font-size: 24px;
            font-weight: 800;
            color: #333;
            margin-bottom: 0; /* 옆에 버튼이 오므로 하단 여백 제거 */
        }
       /* 공통 헤더 */
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
               border-radius: 0 !important;        /* 박스 제거 */
               background: transparent !important; /* 배경 제거 */
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

        /* 필터 버튼 스타일 */
        .filter-container {
            display: flex;
            gap: 10px;
            margin-bottom: 0; /* 헤더 내부로 들어갔으므로 여백 제거 */
        }
        .filter-btn {
            padding: 8px 16px;
            border: 1px solid #ddd;
            border-radius: 20px;
            background: white;
            color: #666;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
            cursor: pointer;
        }
        .filter-btn:hover { background: #f0f0f0; color: #333; }
        .filter-btn.active {
            background: #645495;
            color: white;
            border-color: #645495;
            font-weight: 600;
        }

        /* 테이블 스타일 (통일성 적용) */
        .question-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid #eee;
            box-shadow: none;
        }
        .table-header {
            display: flex;
            background: white;
            border-bottom: 1px solid #eee;
            font-weight: bold;
            color: #333;
            text-align: center;
            padding: 15px 0;
        }
        .table-row {
            display: flex;
            background: white;
            border-bottom: 1px solid #f5f5f5;
            align-items: center;
            transition: background 0.2s;
            cursor: pointer;
            padding: 15px 0;
        }
        .table-row:hover { background: #fafafa; }

        /* 컬럼 너비 설정 */
        .col-no { width: 10%; text-align: center; }
        .col-title { width: 45%; text-align: left; padding: 0 20px; color: #333; }
        .col-answer { width: 20%; text-align: center; }
        .col-date { width: 15%; text-align: center; }
        .col-manage { width: 10%; display: flex; justify-content: center; }

        /* 상태 표시 스타일 */
        .status-complete { color: #10b981; font-weight: 600; }
        .status-pending { color: #f59e0b; font-weight: 600; }

        /* 버튼 스타일 */
        .delete-btn {
            padding: 6px 12px;
            border-radius: 15px;
            border: none;
            font-size: 12px;
            cursor: pointer;
            font-weight: 600;
            transition: 0.2s;
            background: #645495;
            color: white;
        }
        .delete-btn:hover { background: #ff4d4d; }

        /* 데이터 없을 때 */
        .empty-msg { text-align: center; padding: 60px 0; color: #999; font-size: 15px; }

        /* 문의 상세 팝업 */
        .question-modal-overlay {
            display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.45); z-index: 5000; justify-content: center; align-items: center;
            backdrop-filter: blur(3px);
        }
        .question-modal-content {
            width: 700px; background: white; border-radius: 24px; padding: 30px;
            position: relative; box-shadow: 0 20px 40px rgba(0,0,0,0.2); animation: modalPop 0.3s ease;
        }
        @keyframes modalPop { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        .question-close-btn { position: absolute; top: 20px; right: 20px; font-size: 24px; cursor: pointer; color: #aaa; }
        .question-detail-title { font-size: 22px; font-weight: 700; color: #111; margin-bottom: 15px; }
        .question-divider { width: 100%; height: 1px; background: #eee; margin-bottom: 20px; }
        .question-box, .answer-box {
            width: 100%; min-height: 120px; border: 1px solid #eef0f2; border-radius: 12px;
            background: #fcfcfc; padding: 20px; margin-bottom: 20px; font-size: 15px;
            color: #444; line-height: 1.7; box-sizing: border-box;
        }
        .answer-box { background: #f0f4ff; border-color: #dbe2ff; }
        .confirm-btn {
            width: 120px; height: 45px; border: none; border-radius: 12px;
            background: #645495; color: white; font-size: 15px; font-weight: 700;
            cursor: pointer; float: right; transition: 0.2s;
        }
        .confirm-btn:hover { background: #4f4178; }
    </style>
</head>
<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">
    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <main class="question-main">
        <!-- ✅ 제목과 버튼을 한 줄로 배치한 헤더 영역 -->
        <div class="page-header">
            <h1 class="page-title">내 문의</h1>
            <div class="filter-container">
                <a href="?filter=all" class="filter-btn ${param.filter == 'all' || empty param.filter ? 'active' : ''}">전체</a>
                <a href="?filter=completed" class="filter-btn ${param.filter == 'completed' ? 'active' : ''}">답변 완료</a>
                <a href="?filter=pending" class="filter-btn ${param.filter == 'pending' ? 'active' : ''}">답변 전</a>
            </div>
        </div>

        <section class="question-card">
            <div class="table-header">
                <div class="col-no">순번</div>
                <div class="col-title">제목</div>
                <div class="col-answer">답변여부</div>
                <div class="col-date">문의시각</div>
                <div class="col-manage">관리</div>
            </div>

            <c:choose>
                <c:when test="${not empty questions}">
                    <c:forEach var="q" items="${questions}" varStatus="status">
                        <div class="table-row">
                            <div class="col-no">${status.count}</div>
                            <div class="col-title"
                                 style="cursor:pointer; color:#1e2d4d; font-weight:500;"
                                 onclick="openQuestionModal('${q.title}', '${q.content}', '${q.answerContent}')">
                                ${q.title}
                            </div>
                            <div class="col-answer">
                                <span class="${q.status == 'ANSWERED' ? 'status-complete' : 'status-pending'}">
                                    ${q.status == 'ANSWERED' ? '답변 완료' : '답변 전'}
                                </span>
                            </div>
                            <div class="col-date">${q.createdAt}</div>
                            <div class="col-manage">
                                <button type="button" class="delete-btn" onclick="deleteQuestion(${q.inquiryId})">삭제</button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-msg">문의하신 내역이 없습니다.</div>
                </c:otherwise>
            </c:choose>
        </section>
    </main>
</div>

<!-- 문의 상세 팝업 -->
<div id="questionModal" class="question-modal-overlay">
    <div class="question-modal-content">
        <span class="question-close-btn" onclick="closeQuestionModal()">&times;</span>
        <div class="question-detail-title" id="modalTitle">문의 내용</div>
        <div class="question-divider"></div>

        <div style="font-weight:bold; margin-bottom:5px; color:#666;">[문의 내용]</div>
        <div class="question-box" id="modalQuestion"></div>

        <div style="font-weight:bold; margin-bottom:5px; color:#666;">[관리자 답변]</div>
        <div class="answer-box" id="modalAnswer"></div>

        <button class="confirm-btn" onclick="closeQuestionModal()">확인</button>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

<script>
    function openQuestionModal(title, question, answer) {
        document.getElementById('modalTitle').innerText = title;
        document.getElementById('modalQuestion').innerText = question;
        document.getElementById('modalAnswer').innerText = (answer && answer.trim() !== "") ? answer : "아직 답변이 등록되지 않았습니다.";
        document.getElementById('questionModal').style.display = 'flex';
    }

    function closeQuestionModal() {
        document.getElementById('questionModal').style.display = 'none';
    }

    function deleteQuestion(qId) {
        if (confirm("정말로 이 문의 내역을 삭제하시겠습니까?")) {
            fetch('${pageContext.request.contextPath}/mypage/questions/delete/' + qId, {
                method: 'DELETE'
            })
            .then(res => {
                if (res.ok) {
                    alert("삭제되었습니다.");
                    location.reload();
                } else {
                    alert("삭제에 실패했습니다.");
                }
            })
            .catch(err => alert("서버 오류가 발생했습니다."));
        }
    }

    window.addEventListener('click', function(event) {
        const modal = document.getElementById('questionModal');
        if (event.target === modal) {
            closeQuestionModal();
        }
    });

    document.addEventListener("DOMContentLoaded", function () {
        const hamburgerBtn = document.querySelector('.hamburger-btn');
        const sidebar = document.querySelector('nav.sidebar');
        if (hamburgerBtn && sidebar) {
            hamburgerBtn.addEventListener('click', function () {
                sidebar.classList.toggle('open');
            });
        }
    });
</script>
</body>
</html>
