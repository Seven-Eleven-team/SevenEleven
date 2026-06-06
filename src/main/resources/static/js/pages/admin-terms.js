document.addEventListener('DOMContentLoaded', function () {
    const textarea = document.querySelector('textarea[name="content"]');
    if (!textarea) return;

    textarea.addEventListener('input', function () {
        textarea.style.height = 'auto';
        textarea.style.height = textarea.scrollHeight + 'px';
    });
});
