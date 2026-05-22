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

            // ★ 추가: 모달이 열릴 때 배경(body) 스크롤 차단
            document.body.style.overflow = "hidden";

            fetchChatHistory();
        });

        modalCloseBtn.addEventListener("click", () => {
            mentorModal.classList.remove("open");
            if (floatingContainer) {
                floatingContainer.style.display = "";
            }

            // ★ 추가: 모달이 닫힐 때 배경(body) 스크롤 다시 허용
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

            historyData.forEach(chat => {
                renderMessageBubble(chat.senderType, chat.message);
            });

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

    // 6. 통신 대기용 임시 로딩 말풍선 (타이핑 애니메이션으로 변경)
        function renderLoadingBubble() {
            const uniqueId = "loading-" + Date.now();
            const itemContainer = document.createElement("div");
            itemContainer.className = "chat-message-item mentor";
            itemContainer.id = uniqueId;

            const avatar = document.createElement("div");
            avatar.className = "mentor-avatar";
            itemContainer.appendChild(avatar);

            const bubble = document.createElement("div");
            // typing-indicator 클래스를 추가하고, 텍스트 대신 점 3개(span)를 삽입합니다.
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