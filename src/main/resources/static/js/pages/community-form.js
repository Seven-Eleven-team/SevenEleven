(function () {
    const photoInput = document.getElementById("photos");
    const previewArea = document.getElementById("previewArea");
    const content = document.getElementById("content");
    const contentCount = document.getElementById("contentCount");

    if (photoInput && previewArea) {
        photoInput.addEventListener("change", function () {
            previewArea.innerHTML = "";

            const files = Array.from(photoInput.files || []);

            files.forEach(function (file) {
                if (!file.type || !file.type.startsWith("image/")) {
                    return;
                }

                const reader = new FileReader();

                reader.onload = function (event) {
                    const item = document.createElement("div");
                    item.className = "jm-preview-item";

                    const img = document.createElement("img");
                    img.src = event.target.result;
                    img.alt = file.name;

                    item.appendChild(img);
                    previewArea.appendChild(item);
                };

                reader.readAsDataURL(file);
            });
        });
    }

    if (content && contentCount) {
        function updateCount() {
            contentCount.textContent = String((content.value || "").length);
        }

        content.addEventListener("input", updateCount);
        updateCount();
    }
})();