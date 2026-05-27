<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
    <title>게시글 작성 | 지출메이트</title>
</head>
<body class="community-body">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
<%@ include file="/WEB-INF/views/common/include/flash-message.jspf" %>

<main class="community-page">
    <section class="board-form-wrap">
        <h1 class="board-page-title">게시글 작성</h1>

        <c:if test="${not empty userAgeCategoryLabel}">
            <p class="board-guide-text">
                내 나이대 게시판: ${userAgeCategoryLabel} 게시판
            </p>
        </c:if>

        <form method="post"
              action="${pageContext.request.contextPath}/community/write"
              enctype="multipart/form-data"
              class="board-form">

            <div class="board-field">
                <label for="category">게시판 선택</label>

                <select id="category" name="category" required>
                    <option value="FREE" ${category == 'FREE' ? 'selected' : ''}>자유게시판</option>
                    <option value="SECRET" ${category == 'SECRET' ? 'selected' : ''}>비밀게시판</option>
                    <option value="TEENS" ${category == 'TEENS' ? 'selected' : ''} ${userAgeCategory != 'TEENS' ? 'disabled' : ''}>10대 게시판</option>
                    <option value="TWENTIES" ${category == 'TWENTIES' ? 'selected' : ''} ${userAgeCategory != 'TWENTIES' ? 'disabled' : ''}>20대 게시판</option>
                    <option value="THIRTIES" ${category == 'THIRTIES' ? 'selected' : ''} ${userAgeCategory != 'THIRTIES' ? 'disabled' : ''}>30대 게시판</option>
                    <option value="FORTIES" ${category == 'FORTIES' ? 'selected' : ''} ${userAgeCategory != 'FORTIES' ? 'disabled' : ''}>40대 게시판</option>
                    <option value="FIFTIES" ${category == 'FIFTIES' ? 'selected' : ''} ${userAgeCategory != 'FIFTIES' ? 'disabled' : ''}>50대 이상 게시판</option>
                </select>
            </div>

            <div class="board-field">
                <label for="title">제목</label>

                <input type="text"
                       id="title"
                       name="title"
                       maxlength="150"
                       required
                       placeholder="제목을 입력하세요.">
            </div>

            <div class="board-field">
                <label for="content">내용</label>

                <div class="board-textarea-wrap">
                    <textarea id="content"
                              name="content"
                              maxlength="4000"
                              required
                              placeholder="내용을 입력하세요."></textarea>

                    <span class="board-counter">
                        <strong id="contentCount">0</strong> / 4000
                    </span>
                </div>
            </div>

            <div class="board-field">
                <label for="photos">사진 첨부</label>

                <input type="file"
                       id="photos"
                       name="photos"
                       accept="image/*"
                       multiple>

                <div id="previewArea" class="board-preview-area"></div>
            </div>

            <div class="board-form-actions">
                <a href="${pageContext.request.contextPath}/community?category=${category}"
                   class="board-light-btn">
                    취소
                </a>

                <button type="submit" class="board-submit-btn">등록</button>
            </div>
        </form>
    </section>
</main>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/modal/authModal.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>
<script src="${pageContext.request.contextPath}/js/pages/community-form.js"></script>

</body>
</html>