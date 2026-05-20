<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
    <title>${post.title} | 지출메이트 게시판</title>
</head>
<body class="community-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
<%@ include file="/WEB-INF/views/common/include/flash-message.jspf" %>

<main class="community-page">
    <section class="board-detail-wrap">
        <div class="board-detail-card">
            <header class="board-detail-head">
                <div>
                    <p class="board-detail-category">${categoryLabel} 게시판</p>
                    <h1>${post.title}</h1>

                    <div class="board-detail-meta">
                        <span>ID: ${post.writerName}</span>
                        <span>조회: ${post.viewsCount}</span>
                        <span>게시일: ${post.createdAtText}</span>
                    </div>
                </div>

                <div class="board-detail-actions">
                    <button type="button" class="board-report-btn">신고</button>

                    <a href="${pageContext.request.contextPath}/community?category=${category}"
                       class="board-light-btn">
                        목록
                    </a>

                    <c:if test="${owner}">
                        <a href="${pageContext.request.contextPath}/community/edit/${post.boardId}"
                           class="board-submit-btn"
                           data-auth-required="true">
                            수정
                        </a>

                        <form method="post"
                              action="${pageContext.request.contextPath}/community/delete/${post.boardId}"
                              onsubmit="return confirm('정말 삭제하시겠습니까?');">
                            <button type="submit" class="board-delete-btn">삭제</button>
                        </form>
                    </c:if>
                </div>
            </header>

            <div class="board-detail-grid">
                <section class="board-photo-zone">
                    <c:choose>
                        <c:when test="${not empty attachments}">
                            <div class="board-main-photo">
                                <img id="mainCommunityPhoto"
                                     src="${pageContext.request.contextPath}${attachments[0].filePath}"
                                     alt="${attachments[0].orgFileName}">

                                <span class="jm-photo-count">1 / ${fn:length(attachments)}</span>
                            </div>

                            <div class="board-thumb-list">
                                <c:forEach var="file" items="${attachments}" varStatus="status">
                                    <button type="button"
                                            class="jm-thumb-btn ${status.first ? 'is-active' : ''}">
                                        <img src="${pageContext.request.contextPath}${file.filePath}"
                                             data-src="${pageContext.request.contextPath}${file.filePath}"
                                             alt="${file.orgFileName}">
                                    </button>
                                </c:forEach>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="board-photo-empty">
                                첨부된 사진이 없습니다.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>

                <aside class="board-content-zone">
                    <div class="board-profile-box">
                        <div class="board-profile-avatar">
                            <c:choose>
                                <c:when test="${not empty post.writerName}">
                                    ${fn:substring(post.writerName, 0, 1)}
                                </c:when>
                                <c:otherwise>M</c:otherwise>
                            </c:choose>
                        </div>

                        <div>
                            <strong>${post.writerName}</strong>
                            <p>게시일: ${post.createdAtText}</p>
                        </div>
                    </div>

                    <div class="board-content-box">
                        <strong>게시글 내용</strong>
                        <pre>${post.content}</pre>
                    </div>
                </aside>
            </div>
        </div>

        <section class="board-comment-card">
            <div class="board-comment-head">
                <h2>댓글</h2>
                <p>댓글 기능 연결 전 화면 구성 영역입니다.</p>
            </div>

            <div class="board-comment-form">
                <input type="text"
                       placeholder="댓글을 입력하세요."
                       aria-label="댓글 입력">

                <button type="button" class="board-submit-btn">등록</button>
            </div>

            <div class="board-comment-empty">
                아직 등록된 댓글이 없습니다.
            </div>
        </section>
    </section>
</main>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/modal/authModal.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>
<script src="${pageContext.request.contextPath}/js/pages/community-detail.js"></script>

</body>
</html>