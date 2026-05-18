document.addEventListener("DOMContentLoaded", function () {
    document.body.classList.add("is-opening-running");

    const header = document.querySelector(".site-header");
    const heroSection = document.querySelector(".hero-section");
    const cardSection = document.querySelector(".scroll-card-section");
    const cards = Array.from(document.querySelectorAll(".service-card"));
    const fanSection = document.querySelector(".fan-card-section");
    const fanCardWrap = document.querySelector(".fan-card-wrap");

    let ticking = false;

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