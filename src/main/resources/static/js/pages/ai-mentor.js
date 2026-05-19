// 현재 로그인된 유저의 식별자 ID (★ 임시로 1번 유저로 세팅. 추후 로그인 세션과 연결 필요)
// 버튼에 심어놓은 실제 로그인 유저 ID를 가져옵니다. 로그인이 안 되어 있으면 기본값 1을 사용합니다.
let currentUserId = document.querySelector('.ai-btn')?.dataset.userId || 1;

async function toggleAiModal() {
    const modal = document.getElementById('ai-mentor-modal');
    modal.classList.toggle('hidden');

    // 모달 열 때
    if(!modal.classList.contains('hidden')) {
        const today = new Date();
        document.getElementById('ai-chat-date').innerText =
            today.getFullYear() + "." + (today.getMonth()+1) + "." + today.getDate();

        // ★ 추가: 모달이 열릴 때마다 백엔드에서 과거 대화 내역을 불러옵니다.
        await loadChatHistory();
    }
}

// ★ 추가: DB에서 과거 대화 내역을 가져와 화면에 그리는 함수
async function loadChatHistory() {
    const chatBody = document.getElementById('ai-chat-body');
    chatBody.innerHTML = ''; // 기존에 남아있던 대화 화면 초기화

    try {
        const response = await fetch(`/api/v1/ai/history/${currentUserId}`);
        const history = await response.json();

        if (history.length === 0) {
            // 대화 내역이 아예 없는 첫 방문자일 경우 기본 인사말 출력
            addBubble("은아 님 어서와~ 오늘은 어떤 지출이 고민이야?", 'ai-bubble');
        } else {
            // 과거 대화가 있다면 시간 순서대로 화면에 배치
            history.forEach(log => {
                if (log.senderType === 'USER') {
                    addBubble(log.message, 'user-bubble');
                } else {
                    addBubble(log.message, 'ai-bubble');
                }
            });
        }
    } catch (error) {
        console.error("대화 내역 로드 실패:", error);
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
        // 3. 서버에 AI 답변 요청 (★ userId 데이터 추가 동봉)
        const response = await fetch('/api/v1/ai/chat', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                userId: currentUserId, // 백엔드 ChatRequest 구조에 맞춰 추가
                message: message,
                flavor: flavor
            })
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