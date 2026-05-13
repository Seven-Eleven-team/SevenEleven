(function () {
    'use strict';

    const modalMap = {
        choice: 'authChoiceOverlay',
        terms: 'termsOverlay',
        login: 'loginOverlay',
        signup: 'signupOverlay',
        findPassword: 'findPasswordOverlay'
    };

    const enterClassMap = {
        choice: 'sign-choice',
        terms: 'sign-terms',
        login: 'sign-in',
        signup: 'sign-up',
        findPassword: 'sign-find'
    };

    let signupTermsLoaded = false;
    let signupTerms = [];
    let termsAgreementPassed = false;

    function getContextPath() {
        const path = window.location.pathname;
        const first = path.split('/').filter(Boolean)[0];

        if (!first || first.includes('.')) {
            return '';
        }

        return window.location.origin + (path.startsWith('/' + first) ? '/' + first : '');
    }

    function getApiUrl(path) {
        return getContextPath() + path;
    }

    function getOverlay(type) {
        const id = modalMap[type];
        return id ? document.getElementById(id) : null;
    }

    function getDialog(overlay) {
        if (!overlay) {
            return null;
        }

        return overlay.querySelector('.terms-modal, .auth-modal__dialog, .auth-choice-modal');
    }

    function clearMotionClass(dialog) {
        if (!dialog) {
            return;
        }

        dialog.classList.remove(
            'sign-choice',
            'sign-terms',
            'sign-in',
            'sign-up',
            'sign-find',
            'is-exiting'
        );
    }

    function closeAllModals() {
        document.querySelectorAll('.auth-modal-overlay').forEach(function (overlay) {
            const dialog = getDialog(overlay);

            if (dialog) {
                clearMotionClass(dialog);
            }

            overlay.classList.remove('is-open');
            overlay.setAttribute('aria-hidden', 'true');
        });

        document.body.classList.remove('auth-modal-lock');
    }

    function focusFirstElement(overlay) {
        const firstFocusable = overlay.querySelector(
            'input, select, textarea, button, a[href], [tabindex]:not([tabindex="-1"])'
        );

        if (firstFocusable) {
            firstFocusable.focus();
        }
    }

    function openModal(type) {
        if (type === 'signup' && !termsAgreementPassed) {
            type = 'terms';
        }
        const overlay = getOverlay(type);

        if (!overlay) {
            return;
        }

        closeAllModals();

        const dialog = getDialog(overlay);
        const enterClass = enterClassMap[type];

        overlay.classList.add('is-open');
        overlay.setAttribute('aria-hidden', 'false');
        document.body.classList.add('auth-modal-lock');

        if (dialog && enterClass) {
            clearMotionClass(dialog);

            window.requestAnimationFrame(function () {
                dialog.classList.add(enterClass);
            });

            window.setTimeout(function () {
                dialog.classList.remove(enterClass);
            }, 650);
        }

        if (type === 'terms') {
            loadSignupTerms();
        }

        window.requestAnimationFrame(function () {
            focusFirstElement(overlay);
        });
    }

    function closeWithMotion() {
        const openedOverlay = document.querySelector('.auth-modal-overlay.is-open');

        if (!openedOverlay) {
            closeAllModals();
            return;
        }

        const dialog = getDialog(openedOverlay);

        if (!dialog) {
            closeAllModals();
            return;
        }

        clearMotionClass(dialog);
        dialog.classList.add('is-exiting');

        window.setTimeout(function () {
            closeAllModals();
        }, 280);
    }

    function termsListElement() {
        return document.getElementById('termsList');
    }

    function createElement(tagName, className, text) {
        const element = document.createElement(tagName);

        if (className) {
            element.className = className;
        }

        if (text !== undefined && text !== null) {
            element.textContent = text;
        }

        return element;
    }

    function loadSignupTerms() {
        if (signupTermsLoaded) {
            updateTermsState();
            return;
        }

        const termsList = termsListElement();

        if (termsList) {
            termsList.innerHTML = '<div class="terms-loading">이용약관을 불러오는 중입니다.</div>';
        }

        fetch(getApiUrl('/api/terms/signup'), {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        })
            .then(function (response) {
                if (!response.ok) {
                    throw new Error('이용약관 조회에 실패했습니다.');
                }

                return response.json();
            })
            .then(function (data) {
                signupTerms = Array.isArray(data.terms) ? data.terms : [];
                signupTermsLoaded = true;
                renderTerms(signupTerms);
                updateTermsState();
            })
            .catch(function () {
                if (termsList) {
                    termsList.innerHTML = '<div class="terms-error">이용약관을 불러오지 못했습니다. 잠시 후 다시 시도해 주세요.</div>';
                }
            });
    }

    function renderTerms(terms) {
        const termsList = termsListElement();

        if (!termsList) {
            return;
        }

        termsList.innerHTML = '';

        if (!terms || terms.length === 0) {
            termsList.innerHTML = '<div class="terms-error">등록된 이용약관이 없습니다. 관리자에게 문의해 주세요.</div>';
            return;
        }

        terms
            .slice()
            .sort(function (a, b) {
                return (a.displayOrder || 0) - (b.displayOrder || 0);
            })
            .forEach(function (term) {
                termsList.appendChild(createTermsItem(term));
            });
    }

    function createTermsItem(term) {
        const article = createElement('article', 'terms-item');
        const top = createElement('div', 'terms-item__top');
        const label = createElement('label', 'terms-check-label');
        const checkbox = document.createElement('input');
        const checkUi = createElement('span', 'terms-check-ui');
        const labelText = createElement(
            'span',
            'terms-label-text',
            '[' + (term.required ? '필수' : '선택') + '] ' + term.title
        );
        const viewButton = createElement('button', 'terms-view-button', '내용 보기 〉');
        const content = createElement('div', 'terms-content');
        const contentTitle = createElement('h3', null, term.title);
        const contentVersion = createElement('p', 'terms-version', '버전: ' + term.version);
        const contentBody = createElement('pre', 'terms-content-text', term.content || '');

        checkbox.type = 'checkbox';
        checkbox.className = 'terms-check';
        checkbox.dataset.required = String(Boolean(term.required));
        checkbox.dataset.termId = String(term.termId);
        checkbox.dataset.termType = term.termType;

        checkUi.setAttribute('aria-hidden', 'true');

        viewButton.type = 'button';
        viewButton.dataset.termsToggle = String(term.termId);
        viewButton.setAttribute('aria-expanded', 'false');

        content.dataset.termsContent = String(term.termId);
        content.appendChild(contentTitle);
        content.appendChild(contentVersion);
        content.appendChild(contentBody);

        label.appendChild(checkbox);
        label.appendChild(checkUi);
        label.appendChild(labelText);

        top.appendChild(label);
        top.appendChild(viewButton);

        article.appendChild(top);
        article.appendChild(content);

        return article;
    }

    function getTermsChecks() {
        return Array.from(document.querySelectorAll('.terms-check'));
    }

    function getRequiredTermsChecks() {
        return getTermsChecks().filter(function (checkbox) {
            return checkbox.dataset.required === 'true';
        });
    }

    function isRequiredTermsChecked() {
        const requiredChecks = getRequiredTermsChecks();

        return requiredChecks.length > 0 && requiredChecks.every(function (checkbox) {
            return checkbox.checked;
        });
    }

    function updateTermsState() {
        const allCheck = document.getElementById('termsAllCheck');
        const confirmButton = document.getElementById('termsConfirmButton');
        const requiredMessage = document.getElementById('termsRequiredMessage');
        const allChecks = getTermsChecks();
        const requiredChecks = getRequiredTermsChecks();

        const allChecked = allChecks.length > 0 && allChecks.every(function (checkbox) {
            return checkbox.checked;
        });

        const anyChecked = allChecks.some(function (checkbox) {
            return checkbox.checked;
        });

        const requiredChecked = requiredChecks.length > 0 && requiredChecks.every(function (checkbox) {
            return checkbox.checked;
        });

        if (allCheck) {
            allCheck.checked = allChecked;
            allCheck.indeterminate = !allChecked && anyChecked;
        }

        if (confirmButton) {
            confirmButton.disabled = !requiredChecked;
        }

        if (requiredMessage) {
            requiredMessage.classList.toggle('is-ready', requiredChecked);
            requiredMessage.textContent = requiredChecked
                ? '필수 약관 동의가 완료되었습니다. 확인하기를 눌러 회원가입을 진행해 주세요.'
                : '필수 약관에 모두 동의해야 회원가입을 진행할 수 있습니다.';
        }
    }

    function toggleTermsContent(targetName) {
        const content = document.querySelector('[data-terms-content="' + targetName + '"]');
        const button = document.querySelector('[data-terms-toggle="' + targetName + '"]');

        if (!content) {
            return;
        }

        const isOpen = content.classList.toggle('is-open');

        if (button) {
            button.textContent = isOpen ? '내용 닫기 〉' : '내용 보기 〉';
            button.setAttribute('aria-expanded', String(isOpen));
        }
    }

    function applyTermsToSignupForm() {
        const hiddenFields = document.getElementById('signupTermsHiddenFields');
        const selectedChecks = getTermsChecks().filter(function (checkbox) {
            return checkbox.checked;
        });
        const marketingCheck = selectedChecks.find(function (checkbox) {
            return checkbox.dataset.termType === 'MARKETING';
        });

        if (!hiddenFields) {
            return;
        }

        hiddenFields.innerHTML = '';

        selectedChecks.forEach(function (checkbox) {
            const hidden = document.createElement('input');
            hidden.type = 'hidden';
            hidden.name = 'agreedTermIds';
            hidden.value = checkbox.dataset.termId;
            hiddenFields.appendChild(hidden);
        });

        const marketingHidden = document.createElement('input');
        marketingHidden.type = 'hidden';
        marketingHidden.name = 'marketingAgreed';
        marketingHidden.value = marketingCheck ? 'true' : 'false';
        hiddenFields.appendChild(marketingHidden);
    }

    function bindTermsEvents(event) {
        const allCheck = event.target.closest('#termsAllCheck');
        const termsCheck = event.target.closest('.terms-check');
        const toggleButton = event.target.closest('[data-terms-toggle]');
        const confirmButton = event.target.closest('#termsConfirmButton');

        if (allCheck) {
            getTermsChecks().forEach(function (checkbox) {
                checkbox.checked = allCheck.checked;
            });

            updateTermsState();
            return;
        }

        if (termsCheck) {
            updateTermsState();
            return;
        }

        if (toggleButton) {
            event.preventDefault();
            toggleTermsContent(toggleButton.dataset.termsToggle);
            return;
        }

        if (confirmButton) {
            event.preventDefault();

            if (!isRequiredTermsChecked()) {
                updateTermsState();
                return;
            }

            applyTermsToSignupForm();
            termsAgreementPassed = true;
            openModal('signup');
            return true;
        }
        return false;
    }

    document.addEventListener('click', function (event) {
        if (bindTermsEvents(event)) {
            return;
        }

        const openButton = event.target.closest('[data-auth-open]');
        const closeButton = event.target.closest('[data-auth-close]');
        const clickedOverlay = event.target.classList.contains('auth-modal-overlay')
            ? event.target
            : null;

        if (openButton) {
            event.preventDefault();
            openModal(openButton.dataset.authOpen);

            const targetModal = openButton.dataset.authOpen;

            // 회원가입 플로우를 처음부터 다시 시작하는 경우,
            // 이전 동의 상태를 초기화해서 약관을 다시 거치도록 한다.
            if (targetModal === 'choice' || targetModal === 'terms') {
                termsAgreementPassed = false;
            }

            openModal(targetModal);
            return;
        }

        if (closeButton || clickedOverlay) {
            event.preventDefault();
            closeWithMotion();
        }
    });

    document.addEventListener('change', function (event) {
        if (
            event.target.matches('#termsAllCheck') ||
            event.target.matches('.terms-check')
        ) {
            updateTermsState();
        }
    });

    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            closeWithMotion();
        }
    });
})();
