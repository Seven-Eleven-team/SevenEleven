document.addEventListener('DOMContentLoaded', function () {
    const rows = document.querySelectorAll('.admin-table tbody tr');
    rows.forEach(function (row, index) {
        row.style.animation = 'adminEnter 420ms cubic-bezier(.16, 1, .3, 1) both';
        row.style.animationDelay = (index * 35) + 'ms';
    });
});
