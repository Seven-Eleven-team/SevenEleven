(function () {
    const mainPhoto = document.getElementById("mainCommunityPhoto");
    const thumbButtons = document.querySelectorAll(".jm-thumb-btn");
    const countEl = document.querySelector(".jm-photo-count");

    if (!mainPhoto || thumbButtons.length === 0) {
        return;
    }

    thumbButtons.forEach(function (button, index) {
        button.addEventListener("click", function () {
            const img = button.querySelector("img");

            if (!img) {
                return;
            }

            const src = img.getAttribute("data-src") || img.getAttribute("src");

            if (!src) {
                return;
            }

            mainPhoto.setAttribute("src", src);

            thumbButtons.forEach(function (btn) {
                btn.classList.remove("is-active");
            });

            button.classList.add("is-active");

            if (countEl) {
                countEl.textContent = (index + 1) + " / " + thumbButtons.length;
            }
        });
    });
})();