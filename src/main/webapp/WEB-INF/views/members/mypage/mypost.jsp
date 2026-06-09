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
        /* 컬럼 너비 및 정렬 */
                .col-no { width: 10%; text-align: center; }
                .col-title { width: 45%; text-align: left; padding: 0 20px; color: #333; }

                /* ✅ [추가] 제목 링크 기본 스타일 제거 및 호버 효과 */
                .col-title a {
                    text-decoration: none; /* 밑줄 제거 */
                    color: #333; /* 글씨 색상을 기존 텍스트와 동일하게 고정 */
                    display: block; /* 클릭 영역을 넓혀줌 */
                }
                .col-title a:hover {
                    text-decoration: underline; /* 마우스를 올렸을 때만 밑줄이 생기도록 (선택 사항) */
                    color: #243864; /* 마우스를 올리면 네이비색으로 포인트 */
                }

                .col-date { width: 15%; text-align: center; }
                .col-view { width: 10%; text-align: center; }
                .row-right { width: 20%; display: flex; gap: 8px; justify-content: center; align-items: center; }

        /* 버튼 스타일 */
        .btn-edit {
                    padding: 8px 16px;
                    background: #ffffff;
                    color: #243864; /* 지출메이트 네이비 */
                    border: 1px solid #243864;
                    border-radius: 6px;
                    font-size: 13px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    white-space: nowrap;
                }
                .btn-edit:hover {
                    background: #243864;
                    color: #ffffff;
                }

                .btn-delete {
                    padding: 8px 16px;
                    background: #ffffff;
                    color: #ff4d4d; /* 삭제는 강조를 위해 레드 유지 */
                    border: 1px solid #ff4d4d;
                    border-radius: 6px;
                    font-size: 13px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    white-space: nowrap;
                }
                .btn-delete:hover {
                    background: #ff4d4d;
                    color: #ffffff;
                }

        /* 데이터 없을 때 */
        .empty-msg { text-align: center; padding: 60px 0; color: #999; font-size: 15px; }


       /* 페이징 버튼 디자인 */
       .pagination {
           display: flex;
           justify-content: center;
           margin: 40px 0;
           gap: 8px;
       }
       .page-link {
           padding: 8px 16px;
           border: 1px solid #ddd;
           border-radius: 8px;
           text-decoration: none;
           color: #52616B;
           font-weight: 600;
           transition: 0.2s;
       }
       .page-link.active {
           background: #243864; /* 지출메이트 네이비 */
           color: white;
           border-color: #243864;
       }
       .page-link:hover:not(.active) {
           background: #f1f3f5;
           color: #243864;
       }
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
                <div class="table-header">
                    <div class="col-no">순번</div>
                    <div class="col-title">제목</div>
                    <div class="col-date">게시판</div>
                    <div class="col-view">조회수</div> <div class="row-right">관리</div>
                </div>

                <c:choose>
                    <c:when test="${not empty boards and not empty boards.content}">
                        <%-- boards 자체가 Page 객체이므로 그 안의 content를 루프 돌립니다 --%>
                        <c:forEach var="board" items="${boards.content}" varStatus="status">
                            <div class="table-row">
                                <%-- 페이지 번호 * 페이지당 개수 + 순번으로 계산해야 페이지가 넘어가도 번호가 1, 2, 3... 이어집니다 --%>
                                <div class="col-no">${(boards.number * boards.size) + status.count}</div>
                                <div class="col-title">
                                    <a href="${pageContext.request.contextPath}/community/detail/${board.boardId}">
                                        ${board.title}
                                    </a>
                                </div>
                                <div class="col-date">${board.boardType}</div>
                                <div class="col-view">${board.viewsCount}</div>
                                <div class="row-right">
                                    <button type="button" class="btn-edit"
                                            onclick="location.href='${pageContext.request.contextPath}/community/edit/${board.boardId}'">수정</button>

                                    <form action="${pageContext.request.contextPath}/community/delete/${board.boardId}" method="post" style="display:inline;" onsubmit="return confirm('정말로 이 게시글을 삭제하시겠습니까?');">
                                        <button type="submit" class="btn-delete">삭제</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-msg">작성하신 게시글이 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- 페이지네이션 영역 --%>
            <c:if test="${not empty boards and boards.totalPages > 0}">
                <div class="pagination">

                    <%-- [이전] 버튼: 현재 페이지가 1보다 클 때만 표시 --%>
                    <c:if test="${boards.number > 0}">
                        <a href="?page=${boards.number}" class="page-link">이전</a>
                    </c:if>

                    <%-- 페이지 번호 버튼 (1부터 totalPages까지) --%>
                    <%-- boards.number는 0부터 시작하므로, 보여줄 때는 +1을 합니다 --%>
                    <c:forEach begin="0" end="${boards.totalPages - 1}" var="i">
                        <a href="?page=${i + 1}"
                           class="page-link ${boards.number == i ? 'active' : ''}">
                           ${i + 1}
                        </a>
                    </c:forEach>

                    <%-- [다음] 버튼: 현재 페이지가 전체 페이지보다 작을 때만 표시 --%>
                    <c:if test="${boards.number < boards.totalPages - 1}">
                        <a href="?page=${boards.number + 2}" class="page-link">다음</a>
                    </c:if>

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
