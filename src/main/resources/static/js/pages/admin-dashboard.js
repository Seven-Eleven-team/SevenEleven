document.addEventListener('DOMContentLoaded', function () {
    const links = document.querySelectorAll('.admin-link');
    const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    links.forEach(function (link) {
        link.addEventListener('click', function (event) {
            const href = link.getAttribute('href');
            const target = link.getAttribute('target');

            if (!href || href.startsWith('#') || target === '_blank' || prefersReducedMotion) {
                return;
            }

            event.preventDefault();
            document.body.classList.add('is-leaving');

            window.setTimeout(function () {
                window.location.href = href;
            }, 180);
        });
    });
});
