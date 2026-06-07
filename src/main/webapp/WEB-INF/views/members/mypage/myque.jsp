<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menu" value="questions"/>

<!DOCTYPE html>
<html lang="ko">

<head>


    <title>지출메이트 - 내 문의</title>

    <!-- 공통 마이페이지 css -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css?v=1">

    <!-- 현재 페이지 css -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/myque.css">

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

        /* 1. 마이페이지 공통 레이아웃 틀 고정 (사이드바 + 메인 정렬) */
               .mypage-container {
                   display: flex !important;
                   flex-direction: row !important;
                   align-items: stretch !important;
                   gap: 26px !important;
                   max-width: 1200px;
                   margin: 0 auto;
                   padding: 118px 0 40px;
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

        /* =========================
           메인 영역
        ========================= */
        .question-main{
            flex:1;
        }

        /* =========================
           문의 상세 팝업
        ========================= */
        .question-modal-overlay{
            display:none;
            position:fixed;
            top:0;
            left:0;
            width:100%;
            height:100%;
            background:rgba(0,0,0,0.35);
            z-index:3000;
            justify-content:center;
            align-items:center;
        }

        .question-modal-content{
            width:780px;
            background:#f5f5f5;
            border-radius:18px;
            padding:22px 20px 30px;
            position:relative;
            border:1px solid #bdbdbd;
        }

        .question-close-btn{
            position:absolute;
            top:12px;
            right:18px;
            font-size:30px;
            font-weight:bold;
            cursor:pointer;
            color:#111;
        }

        .question-detail-title{
            font-size:22px;
            font-weight:700;
            color:#111;
            margin-bottom:12px;
        }

        .question-divider{
            width:100%;
            height:1px;
            background:#8f8f8f;
            margin-bottom:20px;
        }

        .question-box{
            width:100%;
            min-height:180px;
            border:1px solid #c7c7c7;
            border-radius:16px;
            background:white;
            padding:16px;
            margin-bottom:20px;
            font-size:16px;
            color:#333;
            line-height:1.8;
        }

        .answer-box{
            width:100%;
            min-height:180px;
            border:1px solid #c7c7c7;
            border-radius:16px;
            background:white;
            padding:16px;
            font-size:16px;
            color:#333;
            line-height:1.8;
        }

        .confirm-btn{
            width:115px;
            height:42px;
            border:none;
            border-radius:14px;
            background:#1e2d4d;
            color:white;
            font-size:16px;
            font-weight:700;
            cursor:pointer;
            margin-top:20px;
            float:right;
        }

        .confirm-btn:hover{
            opacity:0.92;
        }

        .question-title-link{
            cursor:pointer;
            transition:0.2s;
        }

        .question-title-link:hover{
            color:#1e2d4d;
            text-decoration:underline;
        }

    </style>

</head>


<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>

    <!-- 메인 -->
    <main class="question-main">

        <h1 class="page-title">
            내 문의
        </h1>

        <section class="question-card">

            <!-- 헤더 -->
            <div class="table-header">

                <div class="col-no">
                    순번
                </div>

                <div class="col-title">
                    제목
                </div>

                <div class="col-answer">
                    답변여부
                </div>

                <div class="col-date">
                    문의시각
                </div>

                <div class="col-manage"></div>

            </div>

            <!-- 문의 -->
          <c:choose>
              <c:when test="${empty inquiries.content}">
                  <div style="text-align: center; padding: 50px 0; color: #888; font-size: 15px;">
                      등록된 문의가 없습니다.
                  </div>
              </c:when>
              <c:otherwise>
                  <c:forEach var="inquiry" items="${inquiries.content}" varStatus="status">
                      <div class="table-row">
                          <div class="col-no">${status.count}</div>

                          <div class="col-title question-title-link"
                               onclick="openQuestionModal(
                                  '${inquiry.title}',
                                  '${inquiry.content}',
                                  '${not empty inquiry.answerContent ? inquiry.answerContent : "아직 답변이 등록되지 않았습니다."}'
                               )">
                              ${inquiry.title}
                          </div>

                          <div class="col-answer ${inquiry.status eq 'ANSWERED' ? 'complete' : ''}">
                              ${inquiry.status eq 'ANSWERED' ? '답변 완료' : '답변 전'}
                          </div>

                          <div class="col-date">
                              <fmt:formatDate value="${inquiry.createdAt}" pattern="MM/dd HH:mm"/>
                          </div>

                          <div class="col-manage">
                              <form action="${pageContext.request.contextPath}/mypage/questions/delete/${inquiry.id}"
                                    method="post"
                                    onsubmit="return confirm('삭제하시겠습니까?')">
                                  <button type="submit" class="delete-btn">삭제하기</button>
                              </form>
                          </div>
                      </div>
                  </c:forEach>
              </c:otherwise>
          </c:choose>

         <!-- 페이지네이션 -->
         <div class="pagination">
             <c:if test="${inquiries.totalPages > 0}">
                 <c:forEach begin="0" end="${inquiries.totalPages - 1}" var="i">
                     <a href="?page=${i}"
                        style="${inquiries.number eq i ? 'font-weight:bold; color:#ff4d4d;' : 'color:#333;'}">
                         ${i + 1}
                     </a>
                 </c:forEach>
             </c:if>
         </div>

        </section>

    </main>

</div>

<!-- 문의 팝업 -->
<div id="questionModal" class="question-modal-overlay">

    <div class="question-modal-content">

        <span class="question-close-btn"
              onclick="closeQuestionModal()">

            &times;

        </span>

        <div class="question-detail-title"
             id="modalTitle">

            컴퓨터가 안켜져요

        </div>

        <div class="question-divider"></div>

        <div class="question-box"
             id="modalQuestion">

            어떻게하면 컴퓨터를 킬까요

        </div>

        <div class="answer-box"
             id="modalAnswer">

            전원 버튼을 누르시면 됩니다.

        </div>

        <button class="confirm-btn"
                onclick="closeQuestionModal()">

            확인

        </button>

    </div>

</div>
 <%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>


<script>

    // 문의 팝업 열기
    function openQuestionModal(title, question, answer){

        document.getElementById('modalTitle').innerText = title;
        document.getElementById('modalQuestion').innerText = question;
        document.getElementById('modalAnswer').innerText = answer;

        document.getElementById('questionModal').style.display = 'flex';
    }

    // 문의 팝업 닫기
    function closeQuestionModal(){

        document.getElementById('questionModal').style.display = 'none';
    }

    // 바깥 클릭 시 닫기
    window.addEventListener('click', function(event){

        const modal = document.getElementById('questionModal');

        if(event.target === modal){
            closeQuestionModal();
        }
    });
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