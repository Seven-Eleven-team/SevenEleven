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

        /* ================= 페이징(Pagination) 디자인 ================= */
                .pagination {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    gap: 8px; /* 버튼 사이 간격 */
                    margin-top: 40px;
                    padding-bottom: 30px;
                }

                /* 일반 페이지 버튼 */
                .pagination .page-link {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    width: 32px;
                    height: 32px;
                    border: 1px solid #ddd;
                    border-radius: 6px; /* 약간 둥근 네모 */
                    background-color: #fff;
                    color: #555 !important;
                    text-decoration: none !important;
                    font-size: 14px;
                    transition: all 0.2s ease;
                }

                /* 마우스 올렸을 때 효과 */
                .pagination .page-link:hover {
                    border-color: #243864; /* 지출메이트 메인 네이비 색상 */
                    color: #243864 !important;
                    background-color: #f4f6f9;
                }

                /* 현재 보고 있는 페이지 버튼 (활성화 상태) */
                .pagination .current-page {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    width: 32px;
                    height: 32px;
                    border: 1px solid #243864;
                    border-radius: 6px;
                    background-color: #243864;
                    color: #fff;
                    font-weight: bold;
                    font-size: 14px;
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
                            <%-- 이제 List가 아니라 Page 객체이므로 alarms.content 로 알맹이를 꺼내야 합니다! --%>
                            <c:choose>
                                <c:when test="${empty alarms.content}">
                                    <div class="alarm-row" style="justify-content: center; color: #888;">
                                        <span class="alarm-text">최근 수신된 알림이 없습니다.</span>
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <c:forEach var="alarm" items="${alarms.content}">
                                        <div class="alarm-row">
                                            <div class="alarm-left">
                                                <span class="alarm-icon">
                                                    <%-- 깨지는 이모지 대신 안전한 텍스트 아이콘으로 임시 변경 --%>
                                                    <c:choose>
                                                        <c:when test="${alarm.type == 'EMAIL'}">[메일]</c:when>
                                                        <c:when test="${alarm.type == 'PAYMENT'}">[결제]</c:when>
                                                        <c:otherwise>[알림]</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <span class="alarm-text">${alarm.content}</span>
                                            </div>
                                            <div class="alarm-right" style="color: #aaa; font-size: 13px;">
                                                ${alarm.createdAt.toLocalDate()}
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <%-- 동적 페이징 버튼 영역 --%>
                                    <div class="pagination">
                                        <%-- 이전 페이지 버튼 (<) --%>
                                        <c:if test="${!alarms.first}">
                                            <a href="?page=${alarms.number - 1}" class="page-link">&lt;</a>
                                        </c:if>

                                        <%-- 페이지 번호 (1, 2, 3...) --%>
                                        <c:forEach begin="0" end="${alarms.totalPages - 1}" var="i">
                                            <c:choose>
                                                <%-- 현재 페이지: 굵은 네이비 버튼 --%>
                                                <c:when test="${alarms.number == i}">
                                                    <span class="current-page">${i + 1}</span>
                                                </c:when>
                                                <%-- 다른 페이지: 일반 버튼 --%>
                                                <c:otherwise>
                                                    <a href="?page=${i}" class="page-link">${i + 1}</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>

                                        <%-- 다음 페이지 버튼 (>) --%>
                                        <c:if test="${!alarms.last}">
                                            <a href="?page=${alarms.number + 1}" class="page-link">&gt;</a>
                                        </c:if>
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