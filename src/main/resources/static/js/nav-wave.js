const hamburgerBtn = document.querySelector('.hamburger-btn');
const sidebar = document.querySelector('.sidebar');

hamburgerBtn.addEventListener('click', function() {
    sidebar.classList.toggle('open');
});