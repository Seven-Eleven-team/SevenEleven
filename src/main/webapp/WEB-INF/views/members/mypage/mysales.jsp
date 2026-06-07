<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="menu" value="sales"/>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">
    <title>지출메이트 - 내 판매 목록</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mysales.css">
<style>
body.mypage .hamburger-btn{
    display:flex !important;
    flex-direction:column !important;
    justify-content:center !important;
    align-items:center !important;
    gap:4px !important;
}

body.mypage .hamburger-btn span{
    display:block !important;
    width:22px !important;
    height:2px !important;
    background:white !important;
    border-radius:999px !important;
}
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

     body.mypage nav.sidebar {
         position: fixed;
         top: 78px;
         left: -260px;
         width: 250px;
         height: calc(100vh - 78px);

         background: #243864; /* ⭐ 네이비 (핵심) */
         border-right: none;

         transition: all 0.3s ease;
         z-index: 9998;
         padding-top: 20px;
     }

     body.mypage nav.sidebar.open {
         left: 0;
     }

     /* 리스트 기본 */
     body.mypage nav.sidebar ul {
         list-style: none;
         padding: 0;
         margin: 0;
     }

     /* 메뉴 아이템 */
     body.mypage nav.sidebar li {
         width: 100%;
     }

     /* 링크 */
     body.mypage nav.sidebar li a {
         display: flex;
         align-items: center;

         height: 54px;
         padding: 0 24px;

         color: white; /* ⭐ 네이비라서 흰 글씨 */
         text-decoration: none;
         font-size: 16px;
         font-weight: 500;

         transition: 0.2s;
     }

     /* hover */
     body.mypage nav.sidebar li a:hover {
         background: rgba(255, 255, 255, 0.12);
     }

     /* 로그아웃 영역 */
     .sidebar-logout {
         position: absolute;
         bottom: 20px;
         left: 0;
         width: 100%;
     }

     .sidebar-logout a {
         display: flex;
         align-items: center;
         gap: 8px;
         padding: 0 24px;
         height: 54px;

         color: white;
         text-decoration: none;
     }

     .sidebar-logout a:hover {
         background: rgba(255, 255, 255, 0.12);
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

</style>
</head>

<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <!-- 사이드바 -->
    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <!-- 메인 -->
    <main class="dashboard">

        <h2 class="page-title">내 판매 목록</h2>

        <section class="sales-card">

            <!-- 판매자 등록 안된 상태 -->
            <c:if test="${empty salesList}">
                <div class="empty-box">
                    <h1>판매자 등록을 먼저 해주세요!</h1>
                    <button class="primary-btn"
                            onclick="location.href='${pageContext.request.contextPath}/mysales/register'">
                        판매자 등록하기
                    </button>
                </div>
            </c:if>

            <!-- 판매 리스트 -->
            <c:if test="${not empty salesList}">

                <table class="sales-table">

                    <thead>
                    <tr>
                        <th>순번</th>
                        <th>상품명</th>
                        <th>플랫폼</th>
                        <th>가격</th>
                        <th>상태</th>
                        <th>등록일</th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody>

                    <c:forEach var="s" items="${salesList}" varStatus="st">

                        <tr>
                            <td>${st.count}</td>
                            <td>${s.title}</td>
                            <td>${s.platform}</td>
                            <td>${s.price}원</td>

                            <td>
                                <c:choose>
                                    <c:when test="${s.status eq 'ACTIVE'}">
                                        <span class="status-active">판매중</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-stop">중지</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${s.createdAt}</td>

                            <td>
                                <button class="delete-btn"
                                        onclick="location.href='/mysales/delete/${s.id}'">
                                    삭제
                                </button>
                            </td>
                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

                <div class="pagination">
                    1
                </div>

            </c:if>

        </section>

    </main>

</div>
 <%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

<script>
   const hamburgerBtn = document.querySelector('.hamburger-btn');
   const sidebar = document.querySelector('nav.sidebar');

   if (hamburgerBtn && sidebar) {
       hamburgerBtn.addEventListener('click', function () {
           sidebar.classList.toggle('open');
       });
   }
</script>
</body>
</html>