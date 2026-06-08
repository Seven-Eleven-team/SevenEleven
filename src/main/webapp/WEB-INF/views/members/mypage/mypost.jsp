<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="menu" value="posts"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 게시글 보기</title>

    <!-- 공통 및 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypost.css?v=3">

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

        /* 내 게시글 메인 영역 */
        .mypost-main { flex: 1; }
        .page-title { font-size: 24px; font-weight: 800; color: #333; margin-bottom: 20px; }

        /* ✅ [수정] 네모 박스 완전히 제거 */
        .post-table {
            background: transparent; /* 배경 제거 */
            border: none;            /* 테두리 제거 */
            border-radius: 0;        /* 곡선 제거 */
            box-shadow: none;        /* 그림자 제거 */
        }
        .table-header {
            display: flex;
            background: white;       /* 헤더만 흰색 */
            border-bottom: 1px solid #eee;
            font-weight: bold;
            color: #333;
            text-align: center;
            padding: 15px 0;
        }
        .table-row {
            display: flex;
            background: white;       /* 각 행만 흰색 */
            border-bottom: 1px solid #f5f5f5;
            align-items: center;
            transition: background 0.2s;
            cursor: pointer;
            padding: 15px 0;
        }
        .table-row:hover { background: #fafafa; }

        /* 컬럼 너비 및 정렬 */
        .col-no { width: 10%; text-align: center; }
        .col-title { width: 50%; text-align: left; padding: 0 20px; color: #333; }
        .col-date { width: 20%; text-align: center; }
        .col-view { width: 10%; text-align: center; }
        .row-right { width: 10%; display: flex; gap: 5px; justify-content: center; }

        /* 버튼 스타일 */
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

        .btn-delete {
            background: #645495;
            color: white;
        }
        .btn-delete:hover { background: #ff4d4d; }

        /* 데이터 없을 때 */
        .empty-msg { text-align: center; padding: 60px 0; color: #999; font-size: 15px; }

        /* 페이지네이션 스타일 */
        .pagination { display: flex; justify-content: center; margin-top: 20px; gap: 5px; }
        .page-link { padding: 8px 12px; border: 1px solid #ddd; border-radius: 5px;
                    text-decoration: none; color: #333; font-size: 14px; }
        .page-link.active { background: #645495; color: white; border-color: #645495; }
    </style>
</head>
<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">
    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <main class="mypost-main">
        <h1 class="page-title">내 게시글 보기</h1>

        <section class="mypost-card">
            <div class="post-table">
                <!-- 테이블 헤더 -->
                <div class="table-header">
                    <div class="col-no">순번</div>
                    <div class="col-title">제목</div>
                    <div class="col-date">게시판</div>
                    <div class="col-view">조회수</div>
                    <div class="row-right">관리</div>
                </div>

                <!-- DB 데이터 출력 루프 -->
                <c:choose>
                    <c:when test="${not empty boards and not empty boards.content}">
                        <c:forEach var="board" items="${boards.content}" varStatus="status">
                            <div class="table-row">
                                <div class="col-no">${status.count}</div>
                                <div class="col-title">${board.title}</div>
                                <div class="col-date">${board.boardType}</div>
                                <div class="col-view">${board.viewCount}</div>
                                <div class="row-right">
                                    <button type="button" class="btn-action"
                                            onclick="location.href='${pageContext.request.contextPath}/board/edit/${board.id}'">수정</button>
                                    <button type="button" class="btn-action btn-delete"
                                            onclick="deleteBoard(${board.id})">삭제</button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-msg">작성하신 게시글이 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 페이지네이션 -->
            <c:if test="${not empty boards and boards.totalPages > 0}">
                <div class="pagination">
                    <c:forEach begin="0" end="${boards.totalPages - 1}" var="i">
                        <a href="?page=${i + 1}" class="page-link ${boards.number == i ? 'active' : ''}">${i + 1}</a>
                    </c:forEach>
                </div>
            </c:if>
        </section>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const hamburgerBtn = document.querySelector('.hamburger-btn');
        const sidebar = document.querySelector('nav.sidebar');
        if (hamburgerBtn && sidebar) {
            hamburgerBtn.addEventListener('click', function () {
                sidebar.classList.toggle('open');
            });
        }
    });

    function deleteBoard(boardId) {
        if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
            fetch('${pageContext.request.contextPath}/board/delete/' + boardId, {
                method: 'DELETE'
            })
            .then(res => {
                if (res.ok) {
                    alert("삭제되었습니다.");
                    location.reload();
                } else {
                    alert("삭제 실패: 권한이 없거나 오류가 발생했습니다.");
                }
            })
            .catch(err => alert("서버 오류가 발생했습니다."));
        }
    }
</script>
</body>
</html>
