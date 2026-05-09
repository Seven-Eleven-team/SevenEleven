function toggleAiModal() {
    const modal = document.getElementById('ai-mentor-modal');
    modal.classList.toggle('hidden');

    // 모달 열 때 오늘 날짜 세팅
    if(!modal.classList.contains('hidden')) {
        const today = new Date();
        document.getElementById('ai-chat-date').innerText =
            today.getFullYear() + "." + (today.getMonth()+1) + "." + today.getDate();
    }
}

function checkEnter(e) {
    if(e.key === 'Enter') sendAiMessage();
}

async function sendAiMessage() {
    const input = document.getElementById('ai-chat-input');
    const message = input.value.trim();
    const flavor = document.querySelector('input[name="ai-flavor"]:checked').value;

    if(!message) return;

    // 1. 내 메시지 화면에 추가
    addBubble(message, 'user-bubble');
    input.value = '';

    // 2. AI 생각 중 표시 (로딩)
    const loadingBubble = addBubble('...', 'ai-bubble');

    try {
        // 3. 서버에 AI 답변 요청
        const response = await fetch('/api/v1/ai/chat', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ message: message, flavor: flavor })
        });
        const data = await response.json();

        // 4. 로딩 메시지 지우고 진짜 답변 넣기
        loadingBubble.remove();
        addBubble(data.mentorMessage, 'ai-bubble');

    } catch (error) {
        loadingBubble.innerText = "연결 에러가 발생했어..";
    }
}

function addBubble(text, className) {
    const chatBody = document.getElementById('ai-chat-body');
    const div = document.createElement('div');
    div.className = 'chat-bubble ' + className;
    div.innerText = text;
    chatBody.appendChild(div);
    chatBody.scrollTop = chatBody.scrollHeight;
    return div;
}