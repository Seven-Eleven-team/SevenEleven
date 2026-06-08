(function () {
    'use strict';

    function getContextPath() {
        const meta = document.querySelector('meta[name="context-path"]');
        return meta ? (meta.getAttribute('content') || '') : '';
    }

    function isLoggedInByHeader() {
            // ★ 세션 스토리지에 로그인 기록이 있으면 화면 껍데기 무시하고 무조건 로그인 상태로 인정!
            if (sessionStorage.getItem('jichulmate:auth-active') === 'true') {
                return true;
            }

            const headerActionArea = document.getElementById('headerActionArea');

            if (!headerActionArea) {
                return false;
            }

            return headerActionArea.dataset.serverLogin === 'true'
                || headerActionArea.classList.contains('is-logged-in')
                || headerActionArea.classList.contains('is-login');
        }

    function openLoginModal() {
        const loginOpenButton = document.querySelector('[data-auth-open="login"]');

        if (loginOpenButton) {
            loginOpenButton.click();
            return;
        }

        const contextPath = getContextPath();
        window.location.href = contextPath + '/auth/login';
    }

    function isProtectedLink(link) {
        if (!link) {
            return false;
        }

        if (link.dataset.authRequired === 'true') {
            return true;
        }

        const href = link.getAttribute('href');

        if (!href || href === '#') {
            return false;
        }

        const protectedPaths = [
            '/mypage',
            '/expense',
            '/expenses',
            '/dashboard',
            '/goal',

            '/subscriptions',

            '/party',
            '/support/qna',
            '/support/qna/write',
            '/ai',
            '/mentor'
        ];

        return protectedPaths.some(function (path) {
            return href === path || href.indexOf(path + '/') === 0 || href.indexOf(getContextPath() + path) === 0;
        });
    }

    document.addEventListener('click', function (event) {
        const link = event.target.closest('a');

        if (!link) {
            return;
        }

        if (!isProtectedLink(link)) {
            return;
        }

        if (isLoggedInByHeader()) {
            return;
        }

        event.preventDefault();
        openLoginModal();
    });
})();