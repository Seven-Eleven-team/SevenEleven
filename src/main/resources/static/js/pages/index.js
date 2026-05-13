document.addEventListener("DOMContentLoaded", function () {
    document.body.classList.add("is-opening-running");

    const header = document.querySelector(".site-header");
    const heroSection = document.querySelector(".hero-section");
    const cardSection = document.querySelector(".scroll-card-section");
    const cards = document.querySelectorAll(".service-card");
    const fanSection = document.querySelector(".fan-card-section");
    const fanCardWrap = document.querySelector(".fan-card-wrap");

    const headerActionArea = document.getElementById("headerActionArea");
    const userAvatarInitial = document.getElementById("userAvatarInitial");

    let ticking = false;

    function getStoredLoginState() {
        try {
            const raw = localStorage.getItem("jichulmateLoginState");
            return raw ? JSON.parse(raw) : null;
        } catch (error) {
            return null;
        }
    }

    function setStoredLoginState(payload) {
        try {
            localStorage.setItem("jichulmateLoginState", JSON.stringify(payload));
        } catch (error) {
            console.error("로그인 상태 저장 실패:", error);
        }
    }

    function clearStoredLoginState() {
        try {
            localStorage.removeItem("jichulmateLoginState");
        } catch (error) {
            console.error("로그인 상태 삭제 실패:", error);
        }
    }

    function getInitialCharacter(text) {
        if (!text || typeof text !== "string") {
            return "M";
        }

        const trimmed = text.trim();
        if (!trimmed) {
            return "M";
        }

        return trimmed.charAt(0).toUpperCase();
    }

    function applyLoggedInUi(displayName) {
        if (!headerActionArea) {
            return;
        }

        headerActionArea.classList.remove("is-logged-out");
        headerActionArea.classList.add("is-logged-in");

        if (userAvatarInitial) {
            userAvatarInitial.textContent = getInitialCharacter(displayName);
        }
    }

    function applyLoggedOutUi() {
        if (!headerActionArea) {
            return;
        }

        headerActionArea.classList.remove("is-logged-in");
        headerActionArea.classList.add("is-logged-out");

        if (userAvatarInitial) {
            userAvatarInitial.textContent = "M";
        }
    }

    function initializeHeaderAuthState() {
        if (!headerActionArea) {
            return;
        }

        const serverLogin = headerActionArea.dataset.serverLogin === "true";
        const storedLogin = getStoredLoginState();

        if (serverLogin) {
            headerActionArea.classList.add("is-logged-in");
            headerActionArea.classList.remove("is-logged-out");
            return;
        }

        if (storedLogin && storedLogin.isLoggedIn) {
            applyLoggedInUi(storedLogin.displayName || "Mate");
            return;
        }

        applyLoggedOutUi();
    }

    function markClientLoggedIn(displayName) {
        const payload = {
            isLoggedIn: true,
            displayName: displayName || "Mate"
        };

        setStoredLoginState(payload);
        applyLoggedInUi(payload.displayName);
    }

    function markClientLoggedOut() {
        clearStoredLoginState();
        applyLoggedOutUi();
    }

    function updateHeaderState() {
        if (!header || !heroSection) {
            return;
        }

        const triggerPoint = heroSection.offsetHeight - header.offsetHeight - 20;

        if (window.scrollY > triggerPoint) {
            header.classList.add("is-solid");
        } else {
            header.classList.remove("is-solid");
        }
    }

    function updateCards() {
        if (!cardSection || cards.length === 0) {
            return;
        }

        const sectionTop = cardSection.offsetTop;
        const scrollY = window.scrollY;
        const sectionHeight = cardSection.offsetHeight;
        const viewportHeight = window.innerHeight;

        const scrollStart = sectionTop - viewportHeight * 0.35;
        const scrollEnd = sectionTop + sectionHeight - viewportHeight * 1.15;

        let progress = (scrollY - scrollStart) / (scrollEnd - scrollStart);
        progress = Math.max(0, Math.min(1, progress));

        const cardCount = cards.length;
        const step = 1 / cardCount;

        cards.forEach(function (card, index) {
            card.classList.remove("is-active", "is-back", "is-hidden-up", "is-waiting");

            const start = step * index;
            const end = step * (index + 1);

            if (progress < start) {
                card.classList.add("is-waiting");
            } else if (progress >= start && progress < end) {
                card.classList.add("is-active");
            } else if (progress >= end && progress < end + step * 0.65) {
                card.classList.add("is-back");
            } else {
                card.classList.add("is-hidden-up");
            }
        });
    }

    function handleScroll() {
        if (!ticking) {
            window.requestAnimationFrame(function () {
                updateHeaderState();
                updateCards();
                ticking = false;
            });

            ticking = true;
        }
    }

    window.addEventListener("load", function () {
        document.body.classList.add("is-opening-loaded");

        window.setTimeout(function () {
            document.body.classList.remove("is-opening-running");
        }, 2600);

        updateHeaderState();
    });

    window.addEventListener("scroll", handleScroll, { passive: true });
    window.addEventListener("resize", function () {
        updateHeaderState();
        updateCards();
    });

    /*
     * auth-modal.js에서 로그인/회원가입 성공 직후
     * 아래 이벤트를 dispatch 해주면 헤더 아바타가 즉시 바뀜
     *
     * window.dispatchEvent(new CustomEvent("jichulmate:auth-success", {
     *   detail: {
     *     displayName: "곤듀",
     *     type: "login"
     *   }
     * }));
     */
    window.addEventListener("jichulmate:auth-success", function (event) {
        const detail = event.detail || {};
        const displayName = detail.displayName || detail.nickname || detail.name || "Mate";
        markClientLoggedIn(displayName);
    });

    window.addEventListener("jichulmate:logout", function () {
        markClientLoggedOut();
    });

    initializeHeaderAuthState();
    updateHeaderState();
    updateCards();

    if (fanSection && fanCardWrap) {
        const fanObserver = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    fanCardWrap.classList.add("is-open");
                } else {
                    fanCardWrap.classList.remove("is-open");
                }
            });
        }, {
            threshold: 0.35
        });

        fanObserver.observe(fanSection);
    }
});