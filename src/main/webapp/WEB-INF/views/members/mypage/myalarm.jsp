<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 알림</title>

    <link rel="stylesheet" href="/css/mypage.css">
    <link rel="stylesheet" href="/css/myalarm.css">
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
    </style>
</head>
<body class="mypage">
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<c:set var="menu" value="alarm"/>


<div class="mypage-container">

    <aside class="sidebar">
            <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
        </aside>

    <main class="alarm-main">

        <h1 class="page-title">알림</h1>

        <section class="alarm-card">

            <div class="alarm-top-bar">
                <div class="email-alarm-setting">
                    <span class="email-title">📧 이메일 알림</span>
                    <label class="switch">
                        <input type="checkbox" checked>
                        <span class="slider"></span>
                    </label>
                </div>
            </div>

            <div class="alarm-table">

                <div class="alarm-row warning">
                    <div class="alarm-left">
                        <span class="alarm-icon">🔔</span>
                        <span class="alarm-text">
                            유튜브 자동 결제까지
                            <strong class="danger-text">3일</strong>
                            남았습니다.
                        </span>
                    </div>
                </div>

                <div class="alarm-row">
                    <div class="alarm-left">
                        <span class="alarm-icon">💳</span>
                        <span class="alarm-text">넷플릭스 결제가 완료되었습니다.</span>
                    </div>
                </div>

                <div class="alarm-row">
                    <div class="alarm-left">
                        <span class="alarm-icon">📌</span>
                        <span class="alarm-text">새로운 공지사항이 등록되었습니다.</span>
                    </div>
                </div>

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