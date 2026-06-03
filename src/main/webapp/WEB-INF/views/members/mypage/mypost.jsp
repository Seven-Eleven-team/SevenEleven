<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="menu" value="posts"/>

<!DOCTYPE html>
<html lang="ko">

<head>


    <title>지출메이트 - 내 게시글 보기</title>

    <!-- 공통 마이페이지 CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypost.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <!-- 게시글 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypost.css?v=3">

<style>
  /*풋터*/
    .footer {
        width: 100%;
        background: #243864;
        color: white;
        padding: 40px 0;
        margin-top: 60px;
    }
   body.mypage {
       padding-top: 78px;

       min-height: 100vh;

       display: flex;
       flex-direction: column;
   }
   .mypage-container {
       flex: 1;
   }

       /*헤더*/
     /* 마이페이지에서는 로그인 버튼 숨김 */
     body.mypage .auth-link {
         display: none !important;
     }
     body.mypage .header-action-area {
         position: absolute !important;
         right: 36px !important;
     }

     body.mypage .user-profile-link {
         display: flex !important;
     }
     /* 공통 햄버거 사이드바 */
     body.mypage nav.sidebar {
         position: fixed;
         top: 78px;
         left: -260px;

         width: 250px;
         height: calc(100vh - 78px);

         background: white;
         border-right: 1px solid #ddd;

         transition: all 0.3s ease;

         z-index: 9998;

         padding-top: 20px;
     }

     body.mypage nav.sidebar.open {
         left: 0;
     }

     body.mypage nav.sidebar ul {
         list-style: none;
         padding: 0;
         margin: 0;
     }

     body.mypage nav.sidebar li {
         width: 100%;
     }

     body.mypage nav.sidebar li a {
         display: flex;
         align-items: center;

         height: 54px;

         padding: 0 24px;

         color: #222;
         text-decoration: none;
         font-size: 16px;
         font-weight: 500;
     }

     body.mypage nav.sidebar li a:hover {
         background: #f5f5f5;
     }

     /* 마이페이지에서는 공통 사이드 드롭다운 숨김 */
     body.mypage .sidebar-overlay,
     body.mypage .sidebar-drawer,
     body.mypage .sidebar-menu,
     body.mypage .mobile-sidebar {
         display: none !important;
     }
    /* 공통 헤더 */
 body.mypage .site-header {
     position: fixed !important;
     top: 0 !important;
     left: 0 !important;
     width: 100% !important;
     height: 78px !important;
     background: #243864 !important;

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
        border-radius: 12px !important;

        background: rgba(255,255,255,0.15) !important;
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

    body.mypage .user-profile-link {
        width: 46px !important;
        height: 46px !important;

        border-radius: 50% !important;
        background: white !important;

        display: flex !important;
        align-items: center !important;
        justify-content: center !important;

        text-decoration: none !important;
    }

    body.mypage .user-avatar {
        color: #243864 !important;
        font-weight: 700 !important;
    }


 /* 1. 마이페이지 공통 레이아웃 틀 고정 (사이드바 + 메인 정렬) */
        .mypage-container {
            display: flex !important;
            flex-direction: row !important;
            align-items: stretch !important;
            gap: 26px !important;
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 0;
        }

        /* 2. 공통 사이드바 크기 및 위아래 중앙 가로막 정렬 스타일링 */
        .mypage-sidebar {
            width: 250px !important;
            min-width: 250px !important;
            height: auto !important;
            align-self: stretch !important;
            background: #ffffff !important;
            border: 1px solid #dddddd !important;
            border-radius: 20px !important;
            padding: 0 !important;
            display: flex !important;
            align-items: center !important;
        }
        .mypage-sidebar ul {
            display: flex !important;
            flex-direction: column !important;
            justify-content: center !important;
            list-style: none !important;
            padding: 0 !important;
            margin: 0 !important;
            width: 100% !important;
        }
        .mypage-sidebar li {
            width: 100% !important;
            display: block !important;
        }
        .mypage-sidebar li a {
            display: flex !important;
            justify-content: center !important;
            align-items: center !important;
            width: 100% !important;
            height: 55px !important;
            padding: 0 !important;
            line-height: 1 !important;
            text-align: center !important;
            font-size: 16px !important;
            font-weight: 500 !important;
            color: #111111 !important;
            transition: all 0.2s ease !important;
        }
        .mypage-sidebar li a:hover {
            background: #fafafa !important;
            color: #ff4d4d !important;
        }
        .mypage-sidebar li.active a {
            color: #ff4d4d !important;
            font-weight: 700 !important;
        }

</style>
</head>

<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <!-- ✅ 다른 페이지들과 완전히 동일한 사이드바 include -->
    <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>

    <!-- 메인 -->
    <main class="mypost-main" style="flex: 1;">

        <h1 class="page-title">
            내 게시글 보기
        </h1>

        <section class="mypost-card">

            <div class="post-table">

                <!-- 헤더 -->
                <div class="table-header">

                    <div class="col-no">순번</div>
                    <div class="col-title">제목</div>
                    <div class="col-date">게시판</div>
                    <div class="col-view">조회수</div>
                    <div class="col-status">관리</div>

                </div>

               <c:forEach var="board" items="${boards.content}" varStatus="status">

                   <div class="table-row">

                       <div class="col-no">
                           ${status.count}
                       </div>

                       <div class="col-title">
                           ${board.title}
                       </div>

                       <div class="col-date">
                           ${board.boardType}
                       </div>

                       <div class="col-view">
                           ${board.viewCount}
                       </div>

                       <div class="row-right">

                           <button type="button"
                                   class="status-btn"
                                   onclick="location.href='${pageContext.request.contextPath}/board/edit/${board.id}'">

                               수정

                           </button>

                           <button type="button"
                                   class="delete-btn"
                                   onclick="deleteBoard(${board.id})">

                               삭제

                           </button>

                       </div>

                   </div>

               </c:forEach>

                <!-- row 2 -->
                <div class="table-row">

                    <div class="col-no">2</div>
                    <div class="col-title">반갑습니다</div>
                    <div class="col-date">비밀</div>
                    <div class="col-view">5</div>

                    <div class="row-right">
                        <button type="button" class="status-btn">수정</button>
                        <button type="button" class="delete-btn">삭제</button>
                    </div>

                </div>

                <!-- empty -->
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>
                <div class="empty-line"></div>

            </div>

            <div class="pagination">
                1
            </div>

        </section>

    </main>

</div>
 <%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

</body>
</html>
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

</script>
