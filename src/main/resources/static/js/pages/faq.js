const faqModal = document.getElementById('faqModal');
const faqOpenBtn = document.getElementById('faqOpenBtn');
const faqInput = document.getElementById('faqInput');
const faqSendBtn = document.getElementById('faqSendBtn');
const faqChatArea = document.getElementById('faqChatArea');

if (faqModal) {

    function adjustFaqSize() {
        const widget = document.getElementById('faqWidget');
        const scale = Math.min(1, Math.min(window.innerWidth / 1440, window.innerHeight / 1024));
        widget.style.transform = `scale(${scale})`;
        widget.style.transformOrigin = 'bottom right';
    }

    adjustFaqSize();
    window.addEventListener('resize', adjustFaqSize);

    let faqLoaded = false;

    function loadFaqList() {
        console.log('loadFaqList 호출!');
        fetch('/support/api/faqs/questions')
            .then(res => res.json())
            .then(data => {
                data.forEach((q, index) => {
                    const row = document.createElement('div');
                    row.className = 'faq-bot-row';
                    row.innerHTML = `<span class="faq-num">${index + 1}.</span><div class="faq-bot-msg">${q}</div>`;
                    faqChatArea.appendChild(row);
                });
                faqChatArea.scrollTop = faqChatArea.scrollHeight;
            });
    }

    faqSendBtn.addEventListener('click', function() {
        const input = faqInput.value.trim();
        if (input === '') return;
        addUserMessage(input);
        faqInput.value = '';
        fetch(`/support/api/faqs/chat?input=${input}`)
            .then(res => res.json())
            .then(data => {
                const answer = typeof data === 'string' ? data : data.answer;
                const row = document.createElement('div');
                row.className = 'faq-bot-row';
                row.innerHTML = `<span class="faq-num">${input}.</span><div class="faq-bot-msg">${answer}</div>`;
                faqChatArea.appendChild(row);
                faqChatArea.scrollTop = faqChatArea.scrollHeight;
            });
    });

    let resetTimer = null;

    document.addEventListener('click', function(e) {
        const chatBtn = document.querySelector('.chat-btn');
        if (!faqModal.contains(e.target) &&
            !faqOpenBtn?.contains(e.target) &&
            !(chatBtn && chatBtn.contains(e.target)) &&
            !e.target.closest('#faqOpenBtn')) {    // 추가
            faqModal.classList.remove('open');
            resetTimer = setTimeout(function() {
                faqChatArea.innerHTML = '';
                faqLoaded = false;
            }, 90000);
        }
    });

    document.addEventListener('click', function(e) {
        if (e.target.closest('#faqOpenBtn')) {
            e.stopPropagation();
            faqModal.classList.toggle('open');
            if (resetTimer) {
                clearTimeout(resetTimer);
                resetTimer = null;
            }
            if (faqModal.classList.contains('open')) {
            }
        }
    });

    function addBotMessage(text) {
        const div = document.createElement('div');
        div.className = 'faq-bot-msg';
        div.textContent = text;
        faqChatArea.appendChild(div);
        faqChatArea.scrollTop = faqChatArea.scrollHeight;
    }

    function addUserMessage(text) {
        const div = document.createElement('div');
        div.className = 'faq-user-msg';
        div.textContent = text;
        faqChatArea.appendChild(div);
        faqChatArea.scrollTop = faqChatArea.scrollHeight;
    }



    const supportQnaBtn = document.getElementById('supportQnaBtn');
    if (supportQnaBtn) {
        supportQnaBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            faqModal.classList.toggle('open');
            if (faqModal.classList.contains('open') && !faqLoaded) {
            }
        });
    }
}