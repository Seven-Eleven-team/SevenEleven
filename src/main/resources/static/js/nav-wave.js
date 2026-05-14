document.addEventListener('DOMContentLoaded', function() {
    const hamburgerBtn = document.querySelector('.hamburger-btn');
    const sidebar = document.querySelector('.sidebar');

    hamburgerBtn.addEventListener('click', function() {
        sidebar.classList.toggle('open');
    });

    // faqModal 열림/닫힘
    const chatBtn = document.querySelector('.chat-btn');
    const faqModal = document.querySelector('.faq-modal');

    chatBtn.addEventListener('click', function() {
        faqModal.classList.toggle('open');
    });

    const faqInput = document.querySelector('.faq-input');      // 입력창
    const faqSendBtn = document.querySelector('.faq-send-btn'); // 전송 버튼
    const faqChatArea = document.getElementById('faqChatArea'); // 채팅 영역

    function addUserMsg(text) {
        const div = document.createElement('div');  // 새 div 태그 만들기
        div.className = 'faq-user-msg';     // 클래스 이름 붙이기
        div.textContent = text;             // 내용 넣기
        faqChatArea.appendChild(div);       // 채팅창에 추가
    }

    function addBotMsg(text) {
        const div = document.createElement('div');
        div.className = 'faq-bot-msg';
        div.textContent = text;
        faqChatArea.appendChild(div);
    }

    faqSendBtn.addEventListener('click', function() {
        const input = faqInput.value.trim();    // 입력창 내용 가져오기
        if(!input) return;      // 빈 값이면 아무것도 안함

        addUserMsg(input);      // 사용자 메시지 채팅창에 추가
        faqInput.value = '';    // 입력창 비우기

        // 백엔드에 답변 요청
        fetch(`/support/api/faqs/chat?input=${input}`)
            .then(response => response.json())  // 응답을 JSON으로 변환
            .then(data => {
                addBotMsg(data.answer);
                faqChatArea.scrollTop = faqChatArea.scrollHeight    // 스크롤 맨 아래로
            });
    });
});