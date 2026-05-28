const faqModal = document.getElementById('faqModal');
const faqOpenBtn = document.getElementById('faqOpenBtn');
const faqInput = document.getElementById('faqInput');
const faqSendBtn = document.getElementById('faqSendBtn');
const faqChatArea = document.getElementById('faqChatArea');

if (faqModal) {

    let faqLoaded = false;

    function loadFaqList() {
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

    loadFaqList();
    faqLoaded = true;


    faqSendBtn.addEventListener('click', function() {
        const input = faqInput.value.trim();
        if (input === '') return;
        addUserMessage(input);
        faqInput.value = '';
        fetch('/support/api/faqs/chat', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ input: input })
        })
        .then(res => res.text())       // ← 추가
        .then(data => {                // ← 추가
            let answer;
            let showNum = true;
            try {
                const parsed = JSON.parse(data);
                answer = parsed.answer || parsed;
            } catch (e) {
                answer = data;
                showNum = false;
            }
            const row = document.createElement('div');
            row.className = 'faq-bot-row';
            row.innerHTML = `<span class="faq-num">${showNum ? input + '.' : ''}</span><div class="faq-bot-msg">${answer}</div>`;
            faqChatArea.appendChild(row);
            faqChatArea.scrollTop = faqChatArea.scrollHeight;
        });
    });

    let resetTimer = null;

document.addEventListener('click', function(e) {
    const chatBtn = document.querySelector('.chat-btn');
    if (!faqModal.contains(e.target) && !(chatBtn && chatBtn.contains(e.target))) {
        if (faqModal.classList.contains('open')) {
            faqModal.classList.remove('open');
            resetTimer = setTimeout(function() {
                faqChatArea.innerHTML = '';
                faqLoaded = false;
            }, 90000);
        }
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
            if (faqModal.classList.contains('open') && !faqLoaded) {
                loadFaqList();
                faqLoaded = true;
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

    const chatBtn = document.querySelector('.chat-btn');
    if (chatBtn) {
        chatBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            faqModal.classList.toggle('open');
            if (resetTimer) {
                clearTimeout(resetTimer);
                resetTimer = null;
            }
            if (faqModal.classList.contains('open')) {
                        faqInput.focus();
                    }
            if (faqModal.classList.contains('open') && !faqLoaded) {
                loadFaqList();
                faqLoaded = true;
            }
        });
    }
}