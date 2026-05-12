<%-- 경로 : src/main/webapp/WEB-INF/views/board/edit.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">

    <style>

        *{
            box-sizing:border-box;
        }

        body{
            background:#f5f5f5;
        }

        /* ========================= */
        /* 상단 */
        /* ========================= */

        .top-nav{
            width:100%;
            height:70px;

            background:#1e2d4d;

            display:flex;
            align-items:center;
            justify-content:space-between;

            padding:0 40px;

            color:white;
        }

        .logo{
            font-size:32px;
            font-weight:700;

            cursor:pointer;
        }

        /* ========================= */
        /* 메인 */
        /* ========================= */

        .board-edit-wrap{

            width:1200px;

            margin:40px auto;
        }

        /* 게시판 이름 */

        .board-title{

            font-size:28px;
            font-weight:700;

            margin-bottom:20px;

            color:#222;
        }

        /* 카드 */

        .edit-card{

            width:100%;

            min-height:760px;

            background:white;

            border:1px solid #dbdbdb;

            border-radius:20px;

            padding:35px;
        }

        /* 제목 */

        .input-title{

            width:100%;

            height:55px;

            border:none;

            border-bottom:1px solid #999;

            font-size:24px;

            outline:none;

            margin-bottom:25px;
        }

        .input-title::placeholder{

            color:#999;
        }

        /* ========================= */
        /* 첨부 이미지 */
        /* ========================= */

        .file-upload-wrap{

            display:flex;

            gap:12px;

            margin-bottom:30px;
        }

        .file-box{

            width:120px;
            height:120px;

            border:1px solid #ddd;

            border-radius:10px;

            background:#fafafa;

            position:relative;

            overflow:hidden;

            cursor:pointer;

            display:flex;
            align-items:center;
            justify-content:center;

            transition:0.2s;
        }

        .file-box:hover{

            background:#f1f3f7;
        }

        .clip-icon{

            font-size:40px;

            color:#c7ccd6;
        }

        .file-input{

            display:none;
        }

        .preview-img{

            width:100%;
            height:100%;

            object-fit:cover;
        }

        /* ========================= */
        /* 내용 */
        /* ========================= */

        .content-textarea{

            width:100%;
            height:420px;

            resize:none;

            border:none;

            outline:none;

            font-size:16px;

            line-height:1.8;

            border-top:1px solid #ddd;

            padding-top:20px;
        }

        .content-textarea::placeholder{

            color:#aaa;
        }

        /* ========================= */
        /* 버튼 */
        /* ========================= */

        .bottom-btn-wrap{

            display:flex;

            justify-content:space-between;

            align-items:center;

            margin-top:30px;
        }

        .back-btn{

            width:130px;
            height:45px;

            border:none;

            border-radius:30px;

            background:#d9deea;

            color:#222;

            font-weight:600;

            cursor:pointer;
        }

        .submit-btn{

            width:160px;
            height:45px;

            border:none;

            border-radius:30px;

            background:#1e2d4d;

            color:white;

            font-weight:600;

            cursor:pointer;
        }

        .submit-btn:hover{

            opacity:0.9;
        }

    </style>
</head>
<body>

<header class="top-nav">

    <div>☰</div>

    <div class="logo"
         onclick="location.href='${pageContext.request.contextPath}/index'">
        지출메이트
    </div>

    <div>마이페이지</div>

</header>

<div class="board-edit-wrap">

    <%-- ========================= --%>
    <%-- 게시판 이름 자동 변경 --%>
    <%-- ========================= --%>

    <h1 class="board-title">

        <c:choose>

            <c:when test="${boardType eq 'FREE'}">
                자유 게시판
            </c:when>

            <c:when test="${boardType eq 'SECRET'}">
                비밀 게시판
            </c:when>

            <c:when test="${boardType eq 'TEEN'}">
                10대 게시판
            </c:when>

            <c:when test="${boardType eq 'TWENTY'}">
                20대 게시판
            </c:when>

            <c:when test="${boardType eq 'THIRTY'}">
                30대 게시판
            </c:when>

            <c:when test="${boardType eq 'FORTY'}">
                40대 게시판
            </c:when>

            <c:when test="${boardType eq 'FIFTY'}">
                50대 이상 게시판
            </c:when>

            <c:otherwise>
                게시판
            </c:otherwise>

        </c:choose>

    </h1>

    <form action="${pageContext.request.contextPath}/board/update"
          method="post"
          enctype="multipart/form-data">

        <%-- 게시글 번호 --%>
        <input type="hidden" name="postId" value="${post.id}">

        <%-- 게시판 타입 --%>
        <input type="hidden" name="boardType" value="${boardType}">

        <div class="edit-card">

            <%-- 제목 --%>
            <input type="text"
                   class="input-title"
                   name="title"
                   value="${post.title}"
                   placeholder="제목">

            <%-- 첨부 이미지 최대 5개 --%>
            <div class="file-upload-wrap">

                <c:forEach begin="0" end="4" var="i">

                    <label class="file-box">

                        <input type="file"
                               name="files"
                               class="file-input"
                               accept="image/*"
                               onchange="previewImage(event, ${i})">

                        <div class="clip-icon" id="icon-${i}">
                            📎
                        </div>

                        <img id="preview-${i}"
                             class="preview-img"
                             style="display:none;">

                    </label>

                </c:forEach>

            </div>

            <%-- 내용 --%>
            <textarea class="content-textarea"
                      name="content"
                      placeholder="내용">${post.content}</textarea>

            <%-- 버튼 --%>
            <div class="bottom-btn-wrap">

                <button type="button"
                        class="back-btn"
                        onclick="history.back()">

                    이전으로

                </button>

                <button type="submit"
                        class="submit-btn">

                    수정완료

                </button>

            </div>

        </div>

    </form>

</div>

<script>

    /* ========================= */
    /* 이미지 미리보기 */
    /* ========================= */

    function previewImage(event, index){

        const file = event.target.files[0];

        if(!file) return;

        const reader = new FileReader();

        reader.onload = function(e){

            const preview = document.getElementById("preview-" + index);

            const icon = document.getElementById("icon-" + index);

            preview.src = e.target.result;

            preview.style.display = "block";

            icon.style.display = "none";
        }

        reader.readAsDataURL(file);
    }

</script>

</body>
</html>