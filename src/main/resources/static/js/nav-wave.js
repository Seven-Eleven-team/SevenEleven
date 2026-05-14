document.addEventListener('DOMContentLoaded', function() {
    const hamburgerBtn = document.querySelector('.hamburger-btn');
    const sidebar = document.querySelector('.sidebar');

    hamburgerBtn.addEventListener('click', function() {
        sidebar.classList.toggle('open');
    });

    // faqModal 열림/닫힘
    const chatBtn = document.querySelector('.chat-btn');
    const faqModal = document.querySelector('.faq-modal');

    chatBtn.addEventListener('click', function() {
        faqModal.classList.toggle('open');
    });
});