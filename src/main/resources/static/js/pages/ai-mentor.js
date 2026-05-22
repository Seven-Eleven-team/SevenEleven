document.addEventListener("DOMContentLoaded", () => {
    const robotTrigger = document.querySelector(".floating-btn.ai-btn");
    const mentorModal = document.getElementById("ai-mentor-modal");
    const modalCloseBtn = document.getElementById("ai-modal-close");
    const chatForm = document.getElementById("ai-chat-form");
    const chatInput = document.getElementById("ai-chat-input");
    const chatScroller = document.getElementById("ai-chat-scroller");
    const floatingContainer = document.querySelector(".floating-buttons");

    // 오늘 날짜 세팅 로직
    function setTodayDate() {
        const dateElement = document.getElementById("ai-chat-date");
        if (dateElement) {
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            const day = String(today.getDate()).padStart(2, '0');
            const days = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
            const dayOfWeek = days[today.getDay()];

            dateElement.innerText = `${year}.${month}.${day} (${dayOfWeek})`;
        }
    }

    setTodayDate();

    if (robotTrigger && mentorModal) {

        robotTrigger.addEventListener("click", () => {
            mentorModal.classList.add("open");
            if (floatingContainer) {
                floatingContainer.style.display = "none";
            }

            // 모달이 열릴 때 배경(body) 스크롤 차단
            document.body.style.overflow = "hidden";

            fetchChatHistory();
        });

        modalCloseBtn.addEventListener("click", () => {
            mentorModal.classList.remove("open");
            if (floatingContainer) {
                floatingContainer.style.display = "";
            }

            // 모달이 닫힐 때 배경(body) 스크롤 다시 허용
            document.body.style.overflow = "";
        });

        chatForm.addEventListener("submit", async (e) => {
            e.preventDefault();
            const userMessage = chatInput.value.trim();
            if (!userMessage) return;

            renderMessageBubble("USER", userMessage);
            chatInput.value = "";

            const temporaryLoadingId = renderLoadingBubble();

            try {
                const response = await fetch("/api/v1/ai/chat", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ message: userMessage })
                });

                if (!response.ok) throw new Error("AI 대화 요청 실패");

                const data = await response.json();

                removeLoadingBubble(temporaryLoadingId);
                renderMessageBubble("MENTOR", data.mentorMessage);

            } catch (error) {
                console.error("Error:", error);
                removeLoadingBubble(temporaryLoadingId);
                renderMessageBubble("MENTOR", "앗, 서버와 통신하는 도중 문제가 생겼어요. 잠시 후 다시 말씀해 주세요!");
            }
        });
    }

    async function fetchChatHistory() {
            try {
                const response = await fetch("/api/v1/ai/history");
                if (!response.ok) throw new Error("과거 내역 조회 실패");

                const historyData = await response.json();
                chatScroller.innerHTML = "";

                // ★ 수정됨: 대화 내역이 없는 처음 접속자일 경우 출력되는 AI 매뉴얼
                if (historyData.length === 0) {
                    const welcomeMessage = `어머머, 우리 친구 안녕안녕안녕! 👋 지출메이트가 기다리고 있었지롱! 💖\n\n나는 우리 친구의 금융 생활을 똑똑하게 도와줄 AI 멘토야. 내가 어떤 일들을 할 수 있는지 매뉴얼을 알려줄게! 📖\n\n✅ [1. 내 소비 패턴 & 통계 분석]\n우리가 등록한 지출 내역을 보고, 이번 달에 어디에 돈을 많이 썼는지 분석해 줄 수 있어!\n💬 "나 이번 달 식비 얼마나 썼어?", "내 소비 습관 분석해줘!"\n\n✅ [2. 지출 피드백 및 조언]\n돈을 잘 썼으면 폭풍 칭찬을, 낭비했다면 아낌없는 조언을 해줄게.\n\n✅ [3. 멘토 성향(말투) 변경하기]\n내 말투가 너무 다정하거나, 혹은 팩트폭력처럼 느껴진다면? 마이페이지(내 정보 설정)에서 멘토 성향을 언제든지 바꿀 수 있어! 설정한 성향에 맞춰서 내가 대답해줄게 😎\n\n부담 갖지 말고 편하게 물어봐줘! 자, 오늘 어떤 소비를 했는지 편하게 말해볼까? 🚀`;

                    renderMessageBubble("MENTOR", welcomeMessage);
                } else {
                    historyData.forEach(chat => {
                        renderMessageBubble(chat.senderType, chat.message);
                    });
                }

                autoScrollToBottom();
            } catch (error) {
                console.error("히스토리 로드 실패:", error);
                chatScroller.innerHTML = "<div style='text-align:center; padding:20px; color:#9ca3af;'>대화 내역을 불러오지 못했습니다.</div>";
            }
        }

    function renderMessageBubble(senderType, text) {
        const itemContainer = document.createElement("div");
        const lowerSender = senderType.toLowerCase();
        itemContainer.className = `chat-message-item ${lowerSender}`;

        if (lowerSender === "mentor") {
            const avatar = document.createElement("div");
            avatar.className = "mentor-avatar";
            itemContainer.appendChild(avatar);
        }

        const bubble = document.createElement("div");
        bubble.className = "message-bubble";
        bubble.innerText = text;
        itemContainer.appendChild(bubble);

        chatScroller.appendChild(itemContainer);
        autoScrollToBottom();
    }

    function renderLoadingBubble() {
        const uniqueId = "loading-" + Date.now();
        const itemContainer = document.createElement("div");
        itemContainer.className = "chat-message-item mentor";
        itemContainer.id = uniqueId;

        const avatar = document.createElement("div");
        avatar.className = "mentor-avatar";
        itemContainer.appendChild(avatar);

        const bubble = document.createElement("div");
        bubble.className = "message-bubble typing-indicator";
        bubble.innerHTML = "<span></span><span></span><span></span>";
        itemContainer.appendChild(bubble);

        chatScroller.appendChild(itemContainer);
        autoScrollToBottom();
        return uniqueId;
    }

    function removeLoadingBubble(id) {
        const target = document.getElementById(id);
        if (target) target.remove();
    }

    function autoScrollToBottom() {
        const drawerBody = document.querySelector('.drawer-body');
        if (drawerBody) {
            drawerBody.scrollTop = drawerBody.scrollHeight;
        }
    }
});