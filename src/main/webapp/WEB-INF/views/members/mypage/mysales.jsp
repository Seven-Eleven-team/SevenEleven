<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="menu" value="sales"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <meta charset="UTF-8">
    <title>지출메이트 - 내 판매 목록</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mypage.css?v=31">

    <style>
        .sales-main {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .sales-page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            gap: 18px;
        }

        .sales-title-area {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .sales-title-area .page-title {
            margin: 0;
        }

        .sales-subtitle {
            margin: 0;
            color: #6b7280;
            font-size: 15px;
            font-weight: 600;
            line-height: 1.5;
        }

        .register-post-btn {
            height: 46px;
            padding: 0 18px;
            border: none;
            border-radius: 999px;
            background: #243864;
            color: #ffffff;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            white-space: nowrap;
            transition: opacity 0.2s ease, transform 0.2s ease;
        }

        .register-post-btn:hover {
            opacity: 0.92;
            transform: translateY(-1px);
        }

        .sales-card {
            width: 100%;
            min-height: 620px;
            padding: 30px 34px;
            border: 1px solid #e2e4ea;
            border-radius: 24px;
            background: #ffffff;
            box-shadow: 0 8px 24px rgba(17, 24, 39, 0.04);
            display: flex;
            flex-direction: column;
        }

        .empty-box {
            min-height: 460px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            gap: 22px;
            text-align: center;
        }

        .empty-box h1 {
            margin: 0;
            color: #111111;
            font-size: 26px;
            font-weight: 900;
            letter-spacing: -0.04em;
        }

        .empty-box p {
            margin: 0;
            color: #6b7280;
            font-size: 15px;
            font-weight: 600;
            line-height: 1.6;
        }

        .primary-btn {
            min-width: 160px;
            height: 48px;
            padding: 0 20px;
            border: none;
            border-radius: 14px;
            background: #243864;
            color: #ffffff;
            font-size: 15px;
            font-weight: 900;
            cursor: pointer;
            transition: opacity 0.2s ease, transform 0.2s ease;
        }

        .primary-btn:hover {
            opacity: 0.92;
            transform: translateY(-1px);
        }

        .sales-table-wrap {
            width: 100%;
            overflow-x: auto;
        }

        .sales-table {
            width: 100%;
            min-width: 880px;
            border-collapse: collapse;
        }

        .sales-table thead tr {
            height: 54px;
            border-top: 1px solid #e2e4ea;
            border-bottom: 1px solid #e2e4ea;
            background: #f8fafc;
        }

        .sales-table th {
            color: #222222;
            font-size: 14px;
            font-weight: 900;
            text-align: center;
            white-space: nowrap;
        }

        .sales-table tbody tr {
            min-height: 68px;
            border-bottom: 1px solid #eef0f4;
            transition: background 0.2s ease;
        }

        .sales-table tbody tr:hover {
            background: #fbfcff;
        }

        .sales-table td {
            padding: 18px 12px;
            color: #333333;
            font-size: 14px;
            font-weight: 700;
            text-align: center;
            vertical-align: middle;
        }

        .service-name-cell {
            color: #111111 !important;
            font-size: 15px !important;
            font-weight: 900 !important;
        }

        .share-id-cell {
            max-width: 180px;
            word-break: break-all;
        }

        .status-badge {
            min-width: 76px;
            height: 30px;
            padding: 0 10px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 900;
            white-space: nowrap;
        }

        .status-badge.approved {
            background: #e9f8ef;
            color: #1f9d55;
        }

        .status-badge.waiting {
            background: #fff4df;
            color: #d48600;
        }

        .status-badge.full {
            background: #eeeeee;
            color: #666666;
        }

        .status-badge.rejected {
            background: #ffe8e8;
            color: #e53935;
        }

        .manage-btn-group {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }

        .detail-btn,
        .delete-btn {
            min-width: 64px;
            height: 34px;
            padding: 0 12px;
            border-radius: 10px;
            background: #ffffff;
            font-size: 13px;
            font-weight: 800;
            cursor: pointer;
            transition: background 0.2s ease, color 0.2s ease, transform 0.2s ease;
        }

        .detail-btn {
            border: 1px solid #243864;
            color: #243864;
        }

        .detail-btn:hover {
            background: #243864;
            color: #ffffff;
            transform: translateY(-1px);
        }

        .delete-btn {
            border: 1px solid #ff4d4d;
            color: #ff4d4d;
        }

        .delete-btn:hover {
            background: #ff4d4d;
            color: #ffffff;
            transform: translateY(-1px);
        }

        .pagination {
            width: 100%;
            margin-top: auto;
            padding-top: 28px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .page-link {
            min-width: 36px;
            height: 36px;
            padding: 0 12px;
            border: 1px solid #243864;
            border-radius: 10px;
            background: #243864;
            color: #ffffff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 800;
            text-decoration: none;
        }

        @media (max-width: 768px) {
            .sales-page-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .register-post-btn {
                width: 100%;
            }

            .sales-card {
                min-height: 520px;
                padding: 24px 20px;
                border-radius: 20px;
            }

            .empty-box {
                min-height: 380px;
            }

            .empty-box h1 {
                font-size: 22px;
            }
        }
    </style>
</head>

<body class="mypage is-header-ready is-opening-loaded is-fab-ready">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<script id="mypageHeaderInit">
    (function () {
        function initMypageCommonHeaderFallback() {
            const hamburger = document.querySelector('.hamburger-btn');

            if (!hamburger || hamburger.dataset.mypageSidebarBound === 'true') {
                return;
            }

            hamburger.dataset.mypageSidebarBound = 'true';
            hamburger.setAttribute('aria-expanded', 'false');

            const sidebarSelectors = [
                '#sidebar',
                '#sideBar',
                '#sideMenu',
                '#sidebarMenu',
                '#mobileMenu',
                '#menuDrawer',
                '.sidebar',
                '.side-bar',
                '.side-nav',
                '.side-menu',
                '.sidebar-menu',
                '.mobile-menu',
                '.mobile-sidebar',
                '.menu-drawer',
                '.drawer-menu',
                '.nav-drawer',
                '.header-sidebar',
                '.global-sidebar',
                '.layout-sidebar'
            ];

            const overlaySelectors = [
                '#sidebarOverlay',
                '#sideOverlay',
                '#menuOverlay',
                '.sidebar-overlay',
                '.side-overlay',
                '.menu-overlay',
                '.drawer-overlay',
                '.nav-overlay',
                '.global-dim',
                '.dimmed-layer'
            ];

            function getElements(selectors) {
                return selectors
                    .flatMap(function (selector) {
                        return Array.from(document.querySelectorAll(selector));
                    })
                    .filter(function (element, index, array) {
                        return element && array.indexOf(element) === index;
                    });
            }

            function isOpened() {
                return document.body.classList.contains('is-sidebar-open')
                    || document.body.classList.contains('sidebar-open')
                    || hamburger.classList.contains('is-open')
                    || hamburger.classList.contains('active');
            }

            function setSidebarOpen(open) {
                document.body.classList.toggle('is-sidebar-open', open);
                document.body.classList.toggle('sidebar-open', open);
                document.documentElement.classList.toggle('is-sidebar-open', open);

                hamburger.classList.toggle('is-open', open);
                hamburger.classList.toggle('active', open);
                hamburger.setAttribute('aria-expanded', String(open));

                getElements(sidebarSelectors).forEach(function (element) {
                    element.hidden = false;
                    element.classList.toggle('is-open', open);
                    element.classList.toggle('open', open);
                    element.classList.toggle('active', open);
                    element.classList.toggle('show', open);
                    element.setAttribute('aria-hidden', String(!open));
                });

                getElements(overlaySelectors).forEach(function (element) {
                    element.hidden = false;
                    element.classList.toggle('is-open', open);
                    element.classList.toggle('open', open);
                    element.classList.toggle('active', open);
                    element.classList.toggle('show', open);
                    element.setAttribute('aria-hidden', String(!open));
                });
            }

            hamburger.addEventListener('click', function (event) {
                event.preventDefault();
                event.stopPropagation();
                event.stopImmediatePropagation();
                setSidebarOpen(!isOpened());
            }, true);

            document.addEventListener('click', function (event) {
                if (!isOpened()) {
                    return;
                }

                const closeTarget = event.target.closest(
                    '.sidebar-overlay, .side-overlay, .menu-overlay, .drawer-overlay, .nav-overlay, ' +
                    '.sidebar-close, .side-close, .menu-close, .drawer-close, ' +
                    '[data-sidebar-close], [data-menu-close]'
                );

                if (closeTarget) {
                    setSidebarOpen(false);
                }
            });

            document.addEventListener('keydown', function (event) {
                if (event.key === 'Escape' && isOpened()) {
                    setSidebarOpen(false);
                }
            });
        }

        document.querySelector('.site-header')?.classList.add('is-solid');
        document.body.classList.add('is-header-ready');
        document.body.classList.add('is-opening-loaded');
        document.body.classList.add('is-fab-ready');

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initMypageCommonHeaderFallback);
        } else {
            initMypageCommonHeaderFallback();
        }
    })();
</script>

<div class="mypage-container">

    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <main class="sales-main">

        <div class="sales-page-header">
            <div class="sales-title-area">
                <h1 class="page-title">내 판매 목록</h1>
                <p class="sales-subtitle">
                    내가 등록한 구독 공유 판매글의 승인 상태와 판매 정보를 확인할 수 있습니다.
                </p>
            </div>

            <c:if test="${isSeller}">
                <button type="button"
                        class="register-post-btn"
                        onclick="location.href='${pageContext.request.contextPath}/party/form'">
                    판매글 등록하기
                </button>
            </c:if>
        </div>

        <section class="sales-card">

            <c:choose>

                <c:when test="${not isSeller}">
                    <div class="empty-box">
                        <h1>판매자 등록을 먼저 해주세요!</h1>
                        <p>
                            구독 공유 판매글을 등록하려면 판매자 인증이 필요합니다.<br>
                            판매자 등록 후 내 판매 목록을 관리할 수 있습니다.
                        </p>

                        <button type="button"
                                class="primary-btn"
                                onclick="location.href='${pageContext.request.contextPath}/mypage/sales/register-identity'">
                            판매자 등록하기
                        </button>
                    </div>
                </c:when>

                <c:when test="${isSeller and empty salesList}">
                    <div class="empty-box">
                        <h1>등록된 판매글이 없습니다.</h1>
                        <p>
                            판매할 구독 서비스를 등록하면 이곳에서 판매 상태를 확인할 수 있습니다.
                        </p>

                        <button type="button"
                                class="primary-btn"
                                onclick="location.href='${pageContext.request.contextPath}/party/form'">
                            판매글 등록하기
                        </button>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="sales-table-wrap">
                        <table class="sales-table">
                            <thead>
                            <tr>
                                <th>순번</th>
                                <th>서비스명</th>
                                <th>공유 ID</th>
                                <th>월 가격</th>
                                <th>상태</th>
                                <th>등록일</th>
                                <th>관리</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="s" items="${salesList}" varStatus="st">
                                <tr>
                                    <td>${st.count}</td>

                                    <td class="service-name-cell">
                                            ${s.serviceName}
                                    </td>

                                    <td class="share-id-cell">
                                            ${not empty s.shareId ? s.shareId : '-'}
                                    </td>

                                    <td>
                                            ${s.monthlyPrice}원
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${s.status eq 'APPROVED'}">
                                                <span class="status-badge approved">승인됨</span>
                                            </c:when>

                                            <c:when test="${s.status eq 'WAITING'}">
                                                <span class="status-badge waiting">승인대기</span>
                                            </c:when>

                                            <c:when test="${s.status eq 'FULL'}">
                                                <span class="status-badge full">모집완료</span>
                                            </c:when>

                                            <c:when test="${s.status eq 'REJECTED'}">
                                                <span class="status-badge rejected">반려</span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="status-badge full">${s.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                            ${not empty s.createdAt ? s.createdAt : '-'}
                                    </td>

                                    <td>
                                        <div class="manage-btn-group">
                                            <button type="button"
                                                    class="detail-btn"
                                                    onclick="location.href='${pageContext.request.contextPath}/party/detail/${s.id}'">
                                                상세
                                            </button>

                                            <button type="button"
                                                    class="delete-btn"
                                                    onclick="alert('판매글 삭제 기능은 별도 API 연결 후 활성화됩니다.');">
                                                삭제
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination">
                        <span class="page-link">1</span>
                    </div>
                </c:otherwise>

            </c:choose>

        </section>

    </main>

</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>
    document.addEventListener("DOMContentLoaded", function () {
    });
</script>

</body>
</html>