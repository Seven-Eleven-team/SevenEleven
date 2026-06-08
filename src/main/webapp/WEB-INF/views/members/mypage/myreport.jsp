<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="menu" value="reports"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 신고 목록</title>

    <!-- 공통 및 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myreport.css">

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
        .report-main { flex: 1; }

        /* 제목과 버튼을 한 줄로 배치 */
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
            margin-bottom: 0;
        }

        /* 필터 버튼 스타일 */
        .filter-container {
            display: flex;
            gap: 10px;
            margin-bottom: 0;
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

        /* 테이블 스타일 (네모 박스 제거 버전) */
        .report-table {
            background: transparent;
            border: none;
            border-radius: 0;
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

        /* 버튼 스타일 (통일된 보라색) */
        .btn-action {
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
        .btn-action:hover { background: #4f4178; }
        .btn-delete:hover { background: #ff4d4d; }

        /* 데이터 없을 때 */
        .empty-msg { text-align: center; padding: 60px 0; color: #999; font-size: 15px; }

        /* 페이지네이션 스타일 */
        .pagination { display: flex; justify-content: center; margin-top: 20px; gap: 5px; }
        .page-link { padding: 8px 12px; border: 1px solid #ddd; border-radius: 5px;
                    text-decoration: none; color: #333; font-size: 14px; }
        .page-link.active { background: #645495; color: white; border-color: #645495; }

        /* 신고 상세 팝업 (통일된 디자인) */
        .report-modal-overlay {
            display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.45); z-index: 5000; justify-content: center; align-items: center;
            backdrop-filter: blur(3px);
        }
        .report-modal-content {
            width: 700px; background: white; border-radius: 24px; padding: 30px;
            position: relative; box-shadow: 0 20px 40px rgba(0,0,0,0.2); animation: modalPop 0.3s ease;
        }
        @keyframes modalPop { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        .report-close-btn { position: absolute; top: 20px; right: 20px; font-size: 24px; cursor: pointer; color: #aaa; }
        .report-detail-title { font-size: 22px; font-weight: 700; color: #111; margin-bottom: 15px; }
        .report-divider { width: 100%; height: 1px; background: #eee; margin-bottom: 20px; }
        .report-box, .answer-box {
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
    <!-- 사이드바 고정 include -->
    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <!-- 메인 본문 -->
    <main class="report-main">
        <!-- 제목과 버튼을 한 줄로 배치 -->
        <div class="page-header">
            <h1 class="page-title">내 신고 목록</h1>
            <div class="filter-container">
                <a href="?filter=all" class="filter-btn ${param.filter == 'all' || empty param.filter ? 'active' : ''}">전체</a>
                <a href="?filter=completed" class="filter-btn ${param.filter == 'completed' ? 'active' : ''}">답변 완료</a>
                <a href="?filter=pending" class="filter-btn ${param.filter == 'pending' ? 'active' : ''}">답변 전</a>
            </div>
        </div>

        <section class="report-card">
            <div class="report-table">
                <!-- 테이블 헤더 -->
                <div class="table-header">
                    <div class="col-no">순번</div>
                    <div class="col-title">제목</div>
                    <div class="col-answer">답변여부</div>
                    <div class="col-date">신고시각</div>
                    <div class="col-manage">관리</div>
                </div>

                <!-- ✅ DB 데이터 출력 루프 (하드코딩 제거, DB 연동) -->
                <c:choose>
                    <c:when test="${not empty reports and not empty reports.content}">
                        <c:forEach var="r" items="${reports.content}" varStatus="status">
                            <div class="table-row">
                                <div class="col-no">${status.count}</div>
                                <div class="col-title"
                                     style="cursor:pointer; color:#1e2d4d; font-weight:500;"
                                     onclick="openReportModal('${r.title}', '${r.content}', '${r.answerContent}')">
                                    ${r.title}
                                </div>
                                <div class="col-answer">
                                    <span class="${r.status == 'ANSWERED' ? 'status-complete' : 'status-pending'}">
                                        ${r.status == 'ANSWERED' ? '답변 완료' : '답변 전'}
                                    </span>
                                </div>
                                <div class="col-date">${r.createdAt}</div>
                                <div class="col-manage">
                                    <button type="button" class="btn-action btn-delete" onclick="deleteReport(${r.reportId})">삭제</button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-msg">신고하신 내역이 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 페이지네이션 (Page 객체 기반) -->
            <c:if test="${not empty reports and reports.totalPages > 0}">
                <div class="pagination">
                    <c:forEach begin="0" end="${reports.totalPages - 1}" var="i">
                        <a href="?page=${i + 1}" class="page-link ${reports.number == i ? 'active' : ''}">${i + 1}</a>
                    </c:forEach>
                </div>
            </c:if>
        </section>
    </main>
</div>

<!-- 신고 상세 팝업 -->
<div id="reportModal" class="report-modal-overlay">
    <div class="report-modal-content">
        <span class="report-close-btn" onclick="closeReportModal()">&times;</span>
        <div class="report-detail-title" id="modalTitle">신고 상세 내용</div>
        <div class="report-divider"></div>

        <div style="font-weight:bold; margin-bottom:5px; color:#666;">[신고 내용]</div>
        <div class="report-box" id="modalReport">신고 내용</div>

        <div style="font-weight:bold; margin-bottom:5px; color:#666;">[관리자 답변]</div>
        <div class="answer-box" id="modalAnswer">관리자 답변</div>

        <button class="confirm-btn" onclick="closeReportModal()">확인</button>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

<script>
    function openReportModal(title, report, answer){
        document.getElementById('modalTitle').innerText = title;
        document.getElementById('modalReport').innerText = report;
        document.getElementById('modalAnswer').innerText = (answer && answer.trim() !== "") ? answer : "아직 답변이 등록되지 않았습니다.";
        document.getElementById('reportModal').style.display = 'flex';
    }

    function closeReportModal(){
        document.getElementById('reportModal').style.display = 'none';
    }

    function deleteReport(reportId) {
        if (confirm("정말로 이 신고 내역을 삭제하시겠습니까?")) {
            fetch('${pageContext.request.contextPath}/mypage/reports/delete/' + reportId, {
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

    window.addEventListener('click', function(event){
        const modal = document.getElementById('reportModal');
        if(event.target === modal){
            closeReportModal();
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
