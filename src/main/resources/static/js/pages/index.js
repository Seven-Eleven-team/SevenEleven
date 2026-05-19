document.addEventListener("DOMContentLoaded", function () {
    document.body.classList.add("is-opening-running");

    const header = document.querySelector(".site-header");
    const heroSection = document.querySelector(".hero-section");
    const cardSection = document.querySelector(".scroll-card-section");
    const cards = Array.from(document.querySelectorAll(".service-card"));
    const fanSection = document.querySelector(".fan-card-section");
    const fanCardWrap = document.querySelector(".fan-card-wrap");

    const globalMenuToggle = document.getElementById("globalMenuToggle");
    const globalMenuPanel = document.getElementById("globalMenuPanel");
    const globalMenuBackdrop = document.getElementById("globalMenuBackdrop");
    const globalMenuClose = document.getElementById("globalMenuClose");

    let ticking = false;

    function updateHeaderState() {
        if (!header || !heroSection) {
            if (header) {
                header.classList.add("is-solid");
            }
            return;
        }

        const triggerPoint = heroSection.offsetHeight - header.offsetHeight - 20;

        if (window.scrollY > triggerPoint) {
            header.classList.add("is-solid");
        } else {
            header.classList.remove("is-solid");
        }
    }

    function openGlobalMenu() {
        if (!globalMenuPanel || !globalMenuBackdrop || !globalMenuToggle) {
            return;
        }

        document.body.classList.add("global-menu-open");
        globalMenuPanel.classList.add("is-open");
        globalMenuBackdrop.classList.add("is-open");

        globalMenuPanel.setAttribute("aria-hidden", "false");
        globalMenuBackdrop.setAttribute("aria-hidden", "false");
        globalMenuToggle.setAttribute("aria-expanded", "true");
    }

    function closeGlobalMenu() {
        if (!globalMenuPanel || !globalMenuBackdrop || !globalMenuToggle) {
            return;
        }

        document.body.classList.remove("global-menu-open");
        globalMenuPanel.classList.remove("is-open");
        globalMenuBackdrop.classList.remove("is-open");

        globalMenuPanel.setAttribute("aria-hidden", "true");
        globalMenuBackdrop.setAttribute("aria-hidden", "true");
        globalMenuToggle.setAttribute("aria-expanded", "false");
    }

    function bindGlobalMenu() {
        if (globalMenuToggle) {
            globalMenuToggle.addEventListener("click", function () {
                const isOpen = globalMenuPanel && globalMenuPanel.classList.contains("is-open");

                if (isOpen) {
                    closeGlobalMenu();
                } else {
                    openGlobalMenu();
                }
            });
        }

        if (globalMenuClose) {
            globalMenuClose.addEventListener("click", closeGlobalMenu);
        }

        if (globalMenuBackdrop) {
            globalMenuBackdrop.addEventListener("click", closeGlobalMenu);
        }

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape") {
                closeGlobalMenu();
            }
        });

        document.addEventListener("click", function (event) {
            const menuLink = event.target.closest(".global-menu-nav a");

            if (menuLink) {
                closeGlobalMenu();
            }
        });
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

    function startOpeningAnimation() {
        if (document.body.classList.contains("is-opening-loaded")) {
            return;
        }

        document.body.classList.add("is-opening-loaded");

        window.setTimeout(function () {
            document.body.classList.remove("is-opening-running");
        }, 2600);

        updateHeaderState();
        updateCards();
    }

    bindGlobalMenu();

    if (document.readyState === "complete") {
        startOpeningAnimation();
    } else {
        window.addEventListener("load", startOpeningAnimation);
    }

    window.addEventListener("scroll", handleScroll, { passive: true });

    window.addEventListener("resize", function () {
        updateHeaderState();
        updateCards();
    });

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