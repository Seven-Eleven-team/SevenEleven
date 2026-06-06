document.addEventListener("DOMContentLoaded", () => {
    const robotTrigger = document.querySelector(".floating-btn.ai-btn");
    const mentorModal = document.getElementById("ai-mentor-modal");
    const modalCloseBtn = document.getElementById("ai-modal-close");
    const chatForm = document.getElementById("ai-chat-form");
    const chatInput = document.getElementById("ai-chat-input");
    const chatScroller = document.getElementById("ai-chat-scroller");
    const floatingContainer = document.querySelector(".floating-buttons");

    // ★ 상단 고정 날짜 숨기기 (카톡처럼 스크롤 안에 넣기 위해)
    const fixedDateElement = document.getElementById("ai-chat-date");
    if (fixedDateElement) {
        fixedDateElement.style.display = "none";
    }

    // 날짜 포맷 함수 (예: 2026.05.30 (토요일))
    function formatDateToKorean(dateObj) {
        if (!dateObj || isNaN(dateObj.getTime())) dateObj = new Date();
        const year = dateObj.getFullYear();
        const month = String(dateObj.getMonth() + 1).padStart(2, '0');
        const day = String(dateObj.getDate()).padStart(2, '0');
        const days = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
        const dayOfWeek = days[dateObj.getDay()];
        return `${year}.${month}.${day} (${dayOfWeek})`;
    }

    let lastDateString = ""; // 마지막으로 출력된 날짜 문자열 저장

    // ★ 카카오톡 스타일 날짜 구분선 생성 함수
    function renderDateDivider(dateStr) {
        const divider = document.createElement("div");
        divider.className = "chat-date-divider";
        divider.style.textAlign = "center";
        divider.style.margin = "20px 0";
        divider.style.fontSize = "12px";
        divider.style.color = "#8b95a1";
        divider.innerHTML = `<span style="background: #F0F5F9; padding: 6px 16px; border-radius: 20px; font-weight: bold;">${dateStr}</span>`;
        chatScroller.appendChild(divider);
    }

    // 텍스트 자동 늘어남 + Shift&Enter 분리
    chatInput.addEventListener("input", function() {
        this.style.height = "auto";
        this.style.height = (this.scrollHeight) + "px";
        if (this.value === "") this.style.height = "auto";
    });

    chatInput.addEventListener("keydown", function(e) {
        if (e.key === "Enter" && !e.shiftKey) {
            e.preventDefault();
            chatForm.dispatchEvent(new Event("submit", { cancelable: true, bubbles: true }));
        }
    });

    if (robotTrigger && mentorModal) {
        robotTrigger.addEventListener("click", () => {
            mentorModal.classList.add("open");
            if (floatingContainer) floatingContainer.style.display = "none";
            document.body.style.overflow = "hidden";
            fetchChatHistory();
        });

        modalCloseBtn.addEventListener("click", () => {
            mentorModal.classList.remove("open");
            if (floatingContainer) floatingContainer.style.display = "";
            document.body.style.overflow = "";
        });

        chatForm.addEventListener("submit", async (e) => {
            e.preventDefault();
            const userMessage = chatInput.value.trim();
            if (!userMessage) return;

            // ★ 새 메시지 입력 시 자정이 넘어서 날짜가 바뀌었는지 체크
            const todayStr = formatDateToKorean(new Date());
            if (todayStr !== lastDateString) {
                renderDateDivider(todayStr);
                lastDateString = todayStr;
            }

            renderMessageBubble("USER", userMessage);
            chatInput.value = "";
            chatInput.style.height = "auto";

            const temporaryLoadingId = renderLoadingBubble();

            try {
                const response = await fetch("/api/v1/ai/chat", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ message: userMessage })
                });

                if (!response.ok) throw new Error("AI 대화 요청 실패");

                const data = await response.json();
                removeLoadingBubble(temporaryLoadingId);

                // ★ AI 응답 시에도 날짜 체크
                const responseDateStr = formatDateToKorean(new Date());
                if (responseDateStr !== lastDateString) {
                    renderDateDivider(responseDateStr);
                    lastDateString = responseDateStr;
                }

                renderMessageBubble("MENTOR", data.mentorMessage);
            } catch (error) {
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
            lastDateString = ""; // 모달을 열 때마다 초기화

            // ★ 1. 안내 멘트는 과거 내역 유무와 상관없이 항상 최상단에 고정 출력!
            const welcomeMessage = `어머머, 안녕안녕! 👋 지출메이트가 기다리고 있었지롱! 💖\n\n나는 금융 생활을 똑똑하게 도와줄 AI 멘토야. 내가 어떤 일들을 할 수 있는지 매뉴얼을 알려줄게! 📖\n\n✅ [1. 내 소비 패턴 & 통계 분석]\n우리가 등록한 지출 내역을 보고, 이번 달에 어디에 돈을 많이 썼는지 분석해 줄 수 있어!\n💬 "나 이번 달 식비 얼마나 썼어?", "내 소비 습관 분석해줘!"\n\n✅ [2. 지출 피드백 및 조언]\n돈을 잘 썼으면 폭풍 칭찬을, 낭비했다면 아낌없는 조언을 해줄게.\n\n✅ [3. 멘토 성향(말투) 변경하기]\n내 말투가 너무 다정하거나, 혹은 팩트폭력처럼 느껴진다면? 마이페이지(내 정보 설정)에서 멘토 성향을 언제든지 바꿀 수 있어!\n\n부담 갖지 말고 편하게 물어봐줘! 자, 오늘 어떤 소비를 했는지 편하게 말해볼까? 🚀`;

            // 첫 안내 멘트의 날짜 설정 (히스토리가 있으면 유저의 첫 대화 날짜, 없으면 오늘 날짜)
            let firstDateObj = new Date();
            if (historyData.length > 0) {
                const firstChat = historyData[0];
                // 백엔드에서 날짜를 보내주는 필드명에 맞춰 유연하게 파싱
                const dateVal = firstChat.chatDate || firstChat.createdAt || firstChat.regDate;
                if (dateVal) firstDateObj = new Date(dateVal);
            }

            lastDateString = formatDateToKorean(firstDateObj);
            renderDateDivider(lastDateString);
            renderMessageBubble("MENTOR", welcomeMessage);

            // ★ 2. 과거 채팅 내역 출력 (날짜가 바뀔 때마다 카톡처럼 구분선 추가)
            historyData.forEach(chat => {
                let msgDate = new Date();
                const dateVal = chat.chatDate || chat.createdAt || chat.regDate;
                if (dateVal) {
                    msgDate = new Date(dateVal);
                }

                const dateStr = formatDateToKorean(msgDate);
                if (dateStr !== lastDateString) {
                    renderDateDivider(dateStr);
                    lastDateString = dateStr;
                }
                renderMessageBubble(chat.senderType, chat.message);
            });

            autoScrollToBottom();
        } catch (error) {
            console.error("히스토리 로드 실패:", error);
            chatScroller.innerHTML = "<div style='text-align:center; padding:20px; color:#9ca3af;'>대화 내역을 불러오지 못했습니다.</div>";
        }
    }

    // 마크다운(특수기호) 필터링
    function removeMarkdown(text) {
        if (!text) return "";
        return text
            .replace(/\*\*(.*?)\*\*/g, '$1')
            .replace(/\*(.*?)\*/g, '$1')
            .replace(/###\s?/g, '')
            .replace(/##\s?/g, '')
            .replace(/#\s?/g, '')
            .replace(/---/g, '');
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
        bubble.innerText = removeMarkdown(text);

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