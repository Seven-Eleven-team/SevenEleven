<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
    <title>${categoryLabel} 게시판 | 지출메이트</title>
</head>
<body class="community-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
<%@ include file="/WEB-INF/views/common/include/flash-message.jspf" %>

<main class="community-page">
    <section class="board-list-wrap">
        <h1 class="board-page-title">${categoryLabel} 게시판</h1>

        <div class="board-category-bar">
            <nav class="board-category-tabs" aria-label="게시판 카테고리">
                <a href="${pageContext.request.contextPath}/community?category=FREE"
                   class="${category == 'FREE' ? 'is-active' : ''}">자유</a>

                <a href="${pageContext.request.contextPath}/community?category=SECRET"
                   class="${category == 'SECRET' ? 'is-active' : ''}">비밀</a>

                <a href="${pageContext.request.contextPath}/community?category=TEENS"
                   class="${category == 'TEENS' ? 'is-active' : ''}">10대</a>

                <a href="${pageContext.request.contextPath}/community?category=TWENTIES"
                   class="${category == 'TWENTIES' ? 'is-active' : ''}">20대</a>

                <a href="${pageContext.request.contextPath}/community?category=THIRTIES"
                   class="${category == 'THIRTIES' ? 'is-active' : ''}">30대</a>

                <a href="${pageContext.request.contextPath}/community?category=FORTIES"
                   class="${category == 'FORTIES' ? 'is-active' : ''}">40대</a>

                <a href="${pageContext.request.contextPath}/community?category=FIFTIES"
                   class="${category == 'FIFTIES' ? 'is-active' : ''}">50대 이상</a>
            </nav>

            <a href="${pageContext.request.contextPath}/community/write?category=${category}"
               class="board-write-btn"
               data-auth-required="true">
                게시글 작성
            </a>
        </div>

        <div class="board-header-row">
            <div>순번</div>
            <div>제목</div>
            <div>ID</div>
            <div>게시일</div>
            <div>조회수</div>
        </div>

        <div class="board-list-box">
            <c:choose>
                <c:when test="${empty posts}">
                    <c:forEach begin="1" end="${pageSize}" var="line">
                        <div class="board-line board-empty-line">
                            <div></div>
                            <div></div>
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <c:forEach var="post" items="${posts}" varStatus="status">
                        <a href="${pageContext.request.contextPath}/community/detail/${post.boardId}"
                           class="board-line board-link-line">
                            <div>${startNo + status.index + 1}.</div>
                            <div class="board-title-cell">${post.title}</div>
                            <div>${post.writerName}</div>
                            <div>${post.createdAtText}</div>
                            <div>${post.viewsCount}조회</div>
                        </a>
                    </c:forEach>

                    <c:if test="${emptyLineCount > 0}">
                        <c:forEach begin="1" end="${emptyLineCount}" var="line">
                            <div class="board-line board-empty-line">
                                <div></div>
                                <div></div>
                                <div></div>
                                <div></div>
                                <div></div>
                            </div>
                        </c:forEach>
                    </c:if>
                </c:otherwise>
            </c:choose>

            <nav class="board-pagination" aria-label="게시판 페이지 이동">
                <c:if test="${hasPrevBlock}">
                    <c:url var="prevBlockUrl" value="/community">
                        <c:param name="category" value="${category}" />
                        <c:param name="keyword" value="${keyword}" />
                        <c:param name="sort" value="${sort}" />
                        <c:param name="page" value="${prevBlockPage}" />
                    </c:url>

                    <a href="${prevBlockUrl}"
                       class="board-page-arrow"
                       aria-label="이전 페이지 묶음">←</a>
                </c:if>

                <c:forEach var="pageNo" begin="${startPage}" end="${endPage}">
                    <c:url var="pageUrl" value="/community">
                        <c:param name="category" value="${category}" />
                        <c:param name="keyword" value="${keyword}" />
                        <c:param name="sort" value="${sort}" />
                        <c:param name="page" value="${pageNo}" />
                    </c:url>

                    <a href="${pageUrl}"
                       class="board-page-link ${pageNo == currentPage ? 'is-active' : ''}"
                       aria-current="${pageNo == currentPage ? 'page' : 'false'}">
                            ${pageNo}
                    </a>
                </c:forEach>

                <c:if test="${hasNextBlock}">
                    <c:url var="nextBlockUrl" value="/community">
                        <c:param name="category" value="${category}" />
                        <c:param name="keyword" value="${keyword}" />
                        <c:param name="sort" value="${sort}" />
                        <c:param name="page" value="${nextBlockPage}" />
                    </c:url>

                    <a href="${nextBlockUrl}"
                       class="board-page-arrow"
                       aria-label="다음 페이지 묶음">→</a>
                </c:if>
            </nav>
        </div>

        <a href="${pageContext.request.contextPath}/" class="board-back-btn">이전으로</a>
    </section>
</main>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/modal/authModal.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

</body>
</html>