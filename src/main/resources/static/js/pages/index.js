document.addEventListener("DOMContentLoaded", function () {
    document.body.classList.add("is-opening-running");

    const header = document.querySelector(".site-header");
    const heroSection = document.querySelector(".hero-section");
    const cardSection = document.querySelector(".scroll-card-section");
    const cards = Array.from(document.querySelectorAll(".service-card"));
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

    function clamp(value, min, max) {
        return Math.max(min, Math.min(max, value));
    }

    function clearCardState(card) {
        card.classList.remove("is-active", "is-back", "is-hidden-up", "is-waiting");
    }

    function updateCards() {
        if (!cardSection || cards.length === 0) {
            return;
        }

        const sectionTop = cardSection.offsetTop;
        const sectionHeight = cardSection.offsetHeight;
        const viewportHeight = window.innerHeight;
        const scrollY = window.scrollY;

        const stickyDistance = Math.max(sectionHeight - viewportHeight, 1);
        const rawProgress = (scrollY - sectionTop) / stickyDistance;
        const progress = clamp(rawProgress, 0, 1);

        const cardCount = cards.length;
        const segment = 1 / cardCount;
        const activeIndex = clamp(Math.floor(progress / segment), 0, cardCount - 1);

        cards.forEach(function (card, index) {
            clearCardState(card);

            if (index < activeIndex) {
                card.classList.add("is-back");
                return;
            }

            if (index === activeIndex) {
                card.classList.add("is-active");
                return;
            }

            card.classList.add("is-waiting");
        });

        if (progress >= 0.995) {
            cards.forEach(function (card, index) {
                clearCardState(card);

                if (index === cardCount - 1) {
                    card.classList.add("is-active");
                } else {
                    card.classList.add("is-hidden-up");
                }
            });
        }
    }

    function handleScroll() {
        if (ticking) {
            return;
        }

        window.requestAnimationFrame(function () {
            updateHeaderState();
            updateCards();
            ticking = false;
        });

        ticking = true;
    }

    window.addEventListener("load", function () {
        document.body.classList.add("is-opening-loaded");

        window.setTimeout(function () {
            document.body.classList.remove("is-opening-running");
        }, 2600);

        updateHeaderState();
        updateCards();
    });

    window.addEventListener("scroll", handleScroll, { passive: true });

    window.addEventListener("resize", function () {
        updateHeaderState();
        updateCards();
    });

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