<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="menu" value="alarm"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 알림</title>

    <!-- 공통 및 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myalarm.css">

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
         background: rgba(25, 59, 96, 0.96) !important;
    }


        /* 사이드바 스타일 */
        .mypage-sidebar {
            width: 250px !important; min-width: 250px !important; height: auto !important;
            background: #ffffff !important; border: 1px solid #dddddd !important;
            border-radius: 20px !important; padding: 0 !important; display: flex !important;
            align-items: center !important;
        }

        /* 메인 영역 */
        .alarm-main { flex: 1; }

        /* 제목과 알림 설정을 한 줄로 배치 */
        .page-header {
            display: flex !important;
            justify-content: space-between !important; /* 양 끝으로 밀어냅니다 */
            align-items: center !important; /* 세로 중앙 정렬 */
            margin-bottom: 20px;
            width: 100%;
        }
        .email-setting {
            display: flex;
            align-items: center;
            gap: 10px; /* 글씨와 토글 사이 간격 */
            font-weight: 600;
            color: #333;
        }


        .page-title {
            font-size: 24px;
            font-weight: 800;
            color: #333;
            margin-bottom: 0;
        }

        body.mypage .hamburger-btn {
               position: absolute !important;
               left: 36px !important;
               width: 42px !important;
               height: 42px !important;
               border: none !important;
               border-radius: 0 !important;        /* 박스 제거 */
               background: transparent !important; /* 배경 제거 */
               color: white !important;
               font-size: 22px !important;
         }

        body.mypage .header-action-area {
            position: absolute !important;
            right: 36px !important;
        }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider {
            position: absolute; cursor: pointer;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc; transition: .4s;
            border-radius: 34px;
        }
        .slider:before {
            position: absolute; content: "";
            height: 16px; width: 16px; left: 3px; bottom: 3px;
            background-color: white; transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider { background-color: #645495; }
        input:checked + .slider:before { transform: translateX(22px); }

        /* 알림 리스트 스타일 (네모 박스 제거) */
        .alarm-table {
            background: transparent;
            border: none;
            box-shadow: none;
        }
        .alarm-row {
            display: flex;
            align-items: center;
            background: white;
            border-bottom: 1px solid #f5f5f5;
            padding: 20px 0;
            transition: background 0.2s;
            cursor: default;
        }
        .alarm-row:hover { background: #fafafa; }

        .alarm-left {
            display: flex;
            align-items: center;
            gap: 15px;
            width: 100%;
            padding: 0 10px;
        }
        .alarm-icon {
            font-size: 20px;
            width: 30px;
            text-align: center;
        }
        .alarm-text {
            font-size: 15px;
            color: #444;
            line-height: 1.5;
        }
        .danger-text {
            color: #ff4d4d;
            font-weight: 700;
        }


                .alarm-card {
                    width: 100%;
                    min-height: 760px; /* 다른 카드들과 높이를 맞춥니다 */
                    background: white;
                    border: 1px solid #dbdbdb;
                    border-radius: 24px;
                    box-shadow: 0 4px 15px rgba(0,0,0,0.04);
                    padding: 30px 35px;
                    display: flex;
                    flex-direction: column;
                    box-sizing: border-box;
                }

                /* 알림 리스트가 카드의 남은 공간을 차지하도록 */
                .alarm-table {
                    flex: 1;
                }



        /* 데이터 없을 때 */
        .empty-msg { text-align: center; padding: 60px 0; color: #999; font-size: 15px; }

        .icon-badge {
                    background-color: #eef1f6;
                    color: #243864;
                    padding: 4px 10px;
                    border-radius: 6px;
                    font-size: 12px;
                    font-weight: 700;
                    white-space: nowrap;
                }

        /* 페이지네이션 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: auto;
            padding-top: 30px;
            gap: 8px;
            width: 100%;
        }
        .page-link {
            display: inline-block;
            padding: 8px 14px;
            border: 1px solid #ddd !important;
            border-radius: 8px !important;
            text-decoration: none !important; /* 파란 밑줄 강제 제거 */
            color: #52616B !important; /* 파란 글씨 강제 제거 */
            font-weight: 600;
            background: #fff;
            transition: all 0.2s;
        }
        .page-link.active {
            background: #243864 !important; /* 지출메이트 네이비 */
            color: white !important;
            border-color: #243864 !important;
        }
        .page-link:hover:not(.active) {
            background: #f1f3f5 !important;
        }
    </style>
</head>
<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">
    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <main class="alarm-main">
        <!-- 제목과 설정을 한 줄로 배치한 헤더 -->
        <div class="page-header">
            <h1 class="page-title">알림</h1>
            <div class="email-setting">
                <span>이메일 알림</span>
                <label class="switch">
                    <input type="checkbox" checked>
                    <span class="slider"></span>
                </label>
            </div>
        </div>

        <section class="alarm-card">
            <div class="alarm-table">
                <c:choose>
                    <c:when test="${not empty alarms and not empty alarms.content}">
                        <c:forEach var="noti" items="${alarms.content}">
                            <div class="alarm-row">
                                <div class="alarm-left">
                                    <span class="alarm-icon">
                                        <span class="icon-badge">알림</span>
                                    </span>
                                    <span class="alarm-text">
                                        ${noti.content}
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-msg">도착한 알림이 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:if test="${not empty alarms and alarms.totalPages > 0}">
                <div class="pagination">
                    <c:forEach begin="1" end="${alarms.totalPages}" var="i">
                        <a href="?page=${i - 1}" class="page-link ${alarms.number == (i - 1) ? 'active' : ''}">${i}</a>
                    </c:forEach>
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
</script>
</body>
</html>
