document.addEventListener('DOMContentLoaded', function () {
    const hamburgerBtn = document.querySelector('.hamburger-btn');
    const sidebar = document.querySelector('.sidebar');

    if (hamburgerBtn && sidebar) {
        hamburgerBtn.addEventListener('click', function (event) {
            event.stopPropagation();
            sidebar.classList.toggle('open');

            const header = document.querySelector('.site-header');
                header.classList.toggle('is-locked', sidebar.classList.contains('open'));
        });

        document.addEventListener('click', function (event) {
            if (!sidebar.contains(event.target) && !hamburgerBtn.contains(event.target)) {
                sidebar.classList.remove('open');

                const header = document.querySelector('.site-header');
                header.classList.remove('is-locked');
            }
        });
    }

    const faqInput = document.querySelector('.faq-input');
    const faqSendBtn = document.querySelector('.faq-send-btn');
    const faqChatArea = document.getElementById('faqChatArea');
    const faqList = document.getElementById('faqList');

    function addUserMsg(text) {
        if (!faqChatArea) {
            return;
        }

        const div = document.createElement('div');
        div.className = 'faq-user-msg';
        div.textContent = text;
        faqChatArea.appendChild(div);
    }

    function addBotMsg(text) {
        if (!faqChatArea) {
            return;
        }

        const div = document.createElement('div');
        div.className = 'faq-bot-msg';
        div.textContent = text;
        faqChatArea.appendChild(div);
    }

    if (faqInput && faqSendBtn && faqChatArea) {
        faqSendBtn.addEventListener('click', function () {
            const input = faqInput.value.trim();

            if (!input) {
                return;
            }

            addUserMsg(input);
            faqInput.value = '';

            fetch('/support/api/faqs/chat?input=' + encodeURIComponent(input))
                .then(function (response) {
                    if (!response.ok) {
                        throw new Error('FAQ 답변 조회 실패');
                    }

                    return response.json();
                })
                .then(function (data) {
                    addBotMsg(data.answer);
                    faqChatArea.scrollTop = faqChatArea.scrollHeight;
                })
                .catch(function (error) {
                    console.warn('[nav-wave] FAQ 답변 조회 실패:', error);
                    addBotMsg('답변을 불러오지 못했습니다. 잠시 후 다시 시도해 주세요.');
                });
        });

        faqInput.addEventListener('keydown', function (event) {
            if (event.key === 'Enter') {
                faqSendBtn.click();
            }
        });
    }

    const sidebarLogoutButton = document.getElementById('sidebarLogoutButton');

    if (sidebarLogoutButton) {
        sidebarLogoutButton.addEventListener('click', function (event) {
            event.preventDefault();

            fetch('/auth/logout', {
                method: 'POST',
                headers: {
                    'Accept': 'application/json'
                }
            })
                .then(function () {
                    window.dispatchEvent(new CustomEvent('jichulmate:logout'));
                    window.location.href = '/';
                })
                .catch(function () {
                    window.location.href = '/';
                });
        });
    }
});