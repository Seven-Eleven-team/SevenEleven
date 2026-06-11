<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>

    <title>OTT 판매 등록</title>

    <style>
        body {
            background: #e8e8e8;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .site-header {
            opacity: 1 !important;
            transform: translateY(0) !important;
            background: rgba(25, 59, 96, 0.96) !important;
        }

        .footer {
            height: auto !important;
        }

        .page-wrap {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;

            max-width: 920px;
            width: 100%;
            margin: 0 auto;

            padding: 120px 1.5rem 3rem;
            box-sizing: border-box;
        }

        .breadcrumb {
            font-size: 14px;
            color: #666;
            margin: 0 auto 1.2rem;
            max-width: 730px;
            width: 100%;
        }

        .card {
            background: #f0f0f0;
            border-radius: 16px;

            padding: 2rem 2.2rem;

            width: 100%;
            max-width: 900px;
            margin: 0 auto;

            box-sizing: border-box;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.07);
        }

        .card-title {
            text-align: center;
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 2rem;
            color: #1a1a1a;
        }

        .form-body {
            display: flex;
            gap: 2.5rem;
            align-items: flex-start;
        }

        .logo-area {
            width: 160px;
            flex-shrink: 0;

            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;

            padding-top: 10px;
        }

        .logo-box {
            width: 130px;
            height: 130px;
            border-radius: 18px;

            margin-top: -8px;

            display: flex;
            align-items: center;
            justify-content: center;

            overflow: hidden;
        }

        .logo-box img {
            width: 100px;
            height: 100px;
            object-fit: contain;
        }

        .logo-placeholder {
            width: 100%;
            height: 100%;
            background: rgba(25, 59, 96, 0.96);
            border-radius: 14px;

            display: flex;
            align-items: center;
            justify-content: center;

            color: #fff;
            font-size: 16px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .form-fields {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 0;
        }

        .fg {
            display: flex;
            flex-direction: column;
            padding: 0.55rem 0;
            border-bottom: 1px solid #bbb;
            position: relative;
        }

        .fg input {
            background: transparent;
            border: none;
            outline: none;

            font-size: 16px;
            color: #333;

            padding: 8px 0;
            width: 100%;
        }

        .fg input::placeholder {
            color: #aaa;
            font-size: 14px;
        }

        .custom-select {
            position: relative;
        }

        .custom-select-trigger {
            display: flex;
            align-items: center;
            gap: 8px;

            padding: 8px 0;

            cursor: pointer;
            font-size: 16px;
            color: #333;

            border-bottom: 1px solid #bbb;
        }

        .custom-select-trigger .trigger-text {
            flex: 1;
            color: #aaa;
            font-size: 14px;
        }

        .custom-select-trigger .trigger-text.selected {
            color: #333;
            font-size: 15px;
        }

        .custom-select-trigger::after {
            content: '▼';
            font-size: 10px;
            color: #999;
        }

        .custom-select-dropdown {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;

            background: #fff;
            border: 0.5px solid #ccc;
            border-radius: 9px;

            z-index: 100;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.10);

            max-height: 250px;
            overflow-y: auto;
        }

        .custom-select-dropdown.on {
            display: block;
        }

        .custom-select-option {
            display: flex;
            align-items: center;
            gap: 10px;

            padding: 9px 14px;

            cursor: pointer;
            font-size: 14px;
            color: #333;
        }

        .custom-select-option:hover {
            background: #f5f5f5;
        }

        .custom-select-option img {
            width: 26px;
            height: 26px;
            object-fit: contain;
            border-radius: 5px;
            background: #f0f0f0;
        }

        .month-row {
            display: flex;
            gap: 0.6rem;

            padding: 0.85rem 0;
            border-bottom: 1px solid #bbb;
        }

        .month-btn {
            flex: 1;

            padding: 9px 0;

            border: 1px solid #ccc;
            border-radius: 22px;

            background: #fff;

            font-size: 14px;
            font-weight: 500;
            color: #555;

            cursor: pointer;
            text-align: center;
        }

        .month-btn.on {
            background: #1e3a5f;
            color: #fff;
            border-color: #1e3a5f;
        }

        .price-area {
            padding: 1rem 0;
            border-bottom: 1px solid #bbb;
            min-height: 56px;
        }

        .price-label {
            font-size: 12px;
            color: #999;
            margin-bottom: 5px;
        }

        .price-value {
            font-size: 24px;
            font-weight: 700;
            color: #1e3a5f;
        }

        .price-empty {
            font-size: 14px;
            color: #bbb;
        }

        .btn-row {
            display: flex;
            justify-content: space-between;
            align-items: center;

            margin-top: 2rem;
            gap: 1rem;
        }

        .btn-outline {
            background: #fff;
            border: 1px solid #ccc;
            border-radius: 30px;

            padding: 12px 46px;

            font-size: 16px;
            cursor: pointer;
            color: #333;
        }

        .btn-dark {
            background: #1e3a5f;
            color: #fff;
            border: none;
            border-radius: 30px;

            padding: 12px 46px;

            font-size: 16px;
            cursor: pointer;
        }

        .toast {
            display: none;
            text-align: center;
            color: #e24b4a;
            font-size: 14px;
            margin-top: 12px;
        }

        .toast.on {
            display: block;
        }

        .modal-overlay {
            display: none;
            position: fixed;

            top: 0;
            left: 0;

            width: 100%;
            height: 100%;

            background: rgba(0, 0, 0, 0.45);
            z-index: 9999;

            align-items: center;
            justify-content: center;
        }

        .modal-overlay.on {
            display: flex;
        }

        .modal-box {
            background: #fff;
            border-radius: 16px;

            padding: 2.1rem 2.5rem;

            text-align: center;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.18);

            max-width: 380px;
            width: 90%;
        }

        .modal-title {
            font-size: 19px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 0.6rem;
        }

        .modal-desc {
            font-size: 14px;
            color: #555;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .modal-question {
            font-size: 14px;
            color: #333;
            font-weight: 500;
            margin-bottom: 1rem;
        }

        .modal-btns {
            display: flex;
            gap: 0.8rem;
            justify-content: center;
        }

        .modal-btn-yes {
            background: #1e3a5f;
            color: #fff;
            border: none;
            border-radius: 22px;

            padding: 9px 28px;

            font-size: 14px;
            cursor: pointer;
        }

        .modal-btn-no {
            background: #fff;
            color: #555;
            border: 1px solid #ccc;
            border-radius: 22px;

            padding: 9px 28px;

            font-size: 14px;
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .page-wrap {
                justify-content: flex-start;
                padding: 120px 1rem 3rem;
            }

            .breadcrumb {
                max-width: 100%;
                font-size: 13px;
            }

            .card {
                max-width: 100%;
                padding: 2rem 1.5rem;
                border-radius: 16px;
            }

            .card-title {
                font-size: 24px;
                margin-bottom: 1.8rem;
            }

            .form-body {
                flex-direction: column;
                gap: 1.8rem;
                align-items: center;
            }

            .logo-area {
                width: 100%;
            }

            .logo-box {
                width: 130px;
                height: 130px;
            }

            .logo-box img {
                width: 100px;
                height: 100px;
            }

            .form-fields {
                width: 100%;
            }

            .btn-row {
                flex-direction: column;
            }

            .btn-outline,
            .btn-dark {
                width: 100%;
                padding: 12px 0;
                font-size: 15px;
            }
        }
    </style>
</head>

<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<script>
    (function() {
        var header = document.querySelector('.site-header');
        if (header) header.classList.add('is-solid');

        document.body.classList.add('is-header-ready');
        document.body.classList.add('is-opening-loaded');
        document.body.classList.add('is-fab-ready');
    })();
</script>

<div class="modal-overlay" id="complete-modal">
    <div class="modal-box">
        <div class="modal-title">판매 등록 완료!</div>
        <div class="modal-desc">OTT 판매 등록이 완료되었습니다.<br>등록하신 상품은 승인 후 게시됩니다.</div>
        <div class="modal-question">판매를 추가로 하시겠습니까?</div>
        <div class="modal-btns">
            <button class="modal-btn-yes" onclick="goAgain()">예</button>
            <button class="modal-btn-no" onclick="goMain()">아니요</button>
        </div>
    </div>
</div>

<div class="page-wrap">
    <p class="breadcrumb">OTT 판매 등록</p>

    <div class="card">
        <h2 class="card-title">판매 작성</h2>

        <div class="form-body">
            <div class="logo-area">
                <div class="logo-box">
                    <div id="logo-placeholder" class="logo-placeholder">지출메이트</div>
                    <img id="logo-img" src="" alt="" style="display:none;">
                </div>
            </div>

            <div class="form-fields">
                <div class="fg">
                    <input type="text" id="share-id" placeholder="아이디">
                </div>

                <div class="fg">
                    <input type="password" id="share-pw" placeholder="비밀번호">
                </div>

                <div class="fg" style="border-bottom:none;">
                    <div class="custom-select" id="custom-select">
                        <div class="custom-select-trigger" onclick="toggleDropdown()">
                            <span class="trigger-text" id="trigger-text">OTT 카테고리</span>
                        </div>
                        <div class="custom-select-dropdown" id="custom-dropdown"></div>
                    </div>
                </div>

                <div class="month-row">
                    <button type="button" class="month-btn" data-month="1" onclick="selectMonth(1)">1개월</button>
                    <button type="button" class="month-btn" data-month="3" onclick="selectMonth(3)">3개월</button>
                    <button type="button" class="month-btn" data-month="6" onclick="selectMonth(6)">6개월</button>
                </div>

                <div class="price-area">
                    <div class="price-label">판매 가격</div>
                    <div id="price-display" class="price-empty">OTT와 개월 수를 선택해주세요</div>
                </div>
            </div>
        </div>

        <div class="btn-row">
            <button type="button" onclick="history.back()" class="btn-outline">이전으로</button>
            <button type="button" onclick="submitForm()" class="btn-dark">작성완료</button>
        </div>

        <div id="toast" class="toast"></div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/layout/floatingBtn.jspf" %>
<%@ include file="/WEB-INF/views/common/modal/faqModal.jspf" %>
<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script src="${pageContext.request.contextPath}/js/pages/faq.js"></script>

<script>
    const ctx = '${pageContext.request.contextPath}';

    const ottData = {
        '1':  { name: '넷플릭스',       logo: 'https://www.google.com/s2/favicons?sz=64&domain=netflix.com',         prices: [5980, 16800, 31920] },
        '2':  { name: '유튜브 프리미엄', logo: 'https://www.google.com/s2/favicons?sz=64&domain=youtube.com',         prices: [5490, 14700, 27720] },
        '3':  { name: '티빙',           logo: 'https://www.google.com/s2/favicons?sz=64&domain=tving.com',           prices: [7500, 21000, 40320] },
        '4':  { name: '디즈니+',        logo: 'https://www.google.com/s2/favicons?sz=64&domain=disneyplus.com',      prices: [3330, 9240, 17640] },
        '5':  { name: '라프텔',         logo: 'https://www.google.com/s2/favicons?sz=64&domain=laftel.net',          prices: [2500, 7500, 15000] },
        '6':  { name: '웨이브',         logo: 'https://img.wavve.com/service30/profile/wavve2022.png',               prices: [5360, 14700, 27720] },
        '7':  { name: '왓챠',           logo: 'https://www.google.com/s2/favicons?sz=64&domain=watcha.com',          prices: [3715, 11145, 22290] },
        '8':  { name: '챗지피티',        logo: 'https://www.google.com/s2/favicons?sz=64&domain=openai.com',         prices: [5280, 21294, 45276] },
        '9':  { name: '제미나이',        logo: 'https://www.google.com/s2/favicons?sz=64&domain=gemini.google.com',  prices: [5140, 14280, 26880] },
        '10': { name: '클로드',         logo: 'https://www.google.com/s2/favicons?sz=64&domain=claude.ai',          prices: [7690, 21420, 40320] },
        '11': { name: '캡컷',           logo: 'https://www.google.com/s2/favicons?sz=64&domain=capcut.com',         prices: [7000, 19500, 36000] },
        '12': { name: '어도비',         logo: 'https://www.google.com/s2/favicons?sz=64&domain=adobe.com',          prices: [14000, 39000, 72000] },
        '13': { name: '듀오링고',        logo: 'https://www.google.com/s2/favicons?sz=64&domain=duolingo.com',       prices: [2500, 7500, 15000] },
        '14': { name: '밀리의 서재',    logo: 'https://www.google.com/s2/favicons?sz=64&domain=millie.co.kr',        prices: [4460, 13380, 26760] },
        '15': { name: '마이크로소프트',  logo: 'https://www.google.com/s2/favicons?sz=64&domain=microsoft.com',      prices: [2000, 6000, 12000] },
        '16': { name: '폴라리스 오피스', logo: 'https://play-lh.googleusercontent.com/nCB498hBglRwIDUn_UwSLXcdLv1S-q69mbwd5vBnU-S77y5VLvb1_xIJfeLeGYGiDQfq=w240-h480-rw', prices: [3400, 10200, 20400] }
    };

    let selectedOtt = null;
    let selectedMonth = null;

    const dropdown = document.getElementById('custom-dropdown');

    Object.keys(ottData).forEach(function(key) {
        const item = ottData[key];
        const div = document.createElement('div');

        div.className = 'custom-select-option';
        div.innerHTML = '<img src="' + item.logo + '" alt="' + item.name + '" onerror="this.style.display=\'none\'"> <span>' + item.name + '</span>';
        div.onclick = function() {
            selectOtt(key);
        };

        dropdown.appendChild(div);
    });

    function toggleDropdown() {
        dropdown.classList.toggle('on');
    }

    function selectOtt(key) {
        selectedOtt = key;

        const item = ottData[key];
        const trigger = document.getElementById('trigger-text');

        trigger.className = 'trigger-text selected';
        trigger.innerHTML = '<img src="' + item.logo + '" style="width:22px;height:22px;object-fit:contain;vertical-align:middle;margin-right:7px;" onerror="this.style.display=\'none\'"> ' + item.name;

        const logoImg = document.getElementById('logo-img');
        const placeholder = document.getElementById('logo-placeholder');

        logoImg.src = item.logo;
        logoImg.style.display = 'block';
        placeholder.style.display = 'none';

        logoImg.onerror = function() {
            logoImg.style.display = 'none';
            placeholder.style.display = 'flex';
            placeholder.textContent = item.name;
        };

        dropdown.classList.remove('on');
        updatePrice();
    }

    document.addEventListener('click', function(e) {
        if (!document.getElementById('custom-select').contains(e.target)) {
            dropdown.classList.remove('on');
        }
    });

    function selectMonth(month) {
        selectedMonth = month;

        document.querySelectorAll('.month-btn').forEach(function(btn) {
            btn.classList.toggle('on', parseInt(btn.dataset.month) === month);
        });

        updatePrice();
    }

    function updatePrice() {
        const display = document.getElementById('price-display');

        if (!selectedOtt || !selectedMonth) {
            display.className = 'price-empty';
            display.textContent = 'OTT와 개월 수를 선택해주세요';
            return;
        }

        const idx = selectedMonth === 1 ? 0 : selectedMonth === 3 ? 1 : 2;
        const price = ottData[selectedOtt].prices[idx];

        display.className = 'price-value';
        display.textContent = price.toLocaleString() + '원';
    }

    function showToast(msg) {
        const t = document.getElementById('toast');

        t.textContent = msg;
        t.classList.add('on');

        setTimeout(function() {
            t.classList.remove('on');
        }, 3000);
    }

    function goAgain() {
        location.href = ctx + '/party/form';
    }

    function goMain() {
        location.href = ctx + '/';
    }

    function submitForm() {
        const userId = '${sessionScope.LOGIN_USER_ID}';

        if (!userId || userId === 'null' || userId === '') {
            showToast('로그인이 필요합니다.');
            return;
        }

        const shareId = document.getElementById('share-id').value.trim();
        const sharePw = document.getElementById('share-pw').value.trim();

        if (!shareId) {
            showToast('아이디를 입력해주세요.');
            return;
        }

        if (!sharePw) {
            showToast('비밀번호를 입력해주세요.');
            return;
        }

        if (!selectedOtt) {
            showToast('OTT 카테고리를 선택해주세요.');
            return;
        }

        if (!selectedMonth) {
            showToast('판매 개월 수를 선택해주세요.');
            return;
        }

        const idx = selectedMonth === 1 ? 0 : selectedMonth === 3 ? 1 : 2;
        const price = ottData[selectedOtt].prices[idx];

        const data = {
            sellerId: parseInt(userId),
            serviceId: parseInt(selectedOtt),
            shareId: shareId,
            sharePassword: sharePw,
            monthlyPrice: price,
            saleMonths: selectedMonth,
            description: ''
        };

        fetch(ctx + '/api/party/posts', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        }).then(function(res) {
            if (res.ok) {
                document.getElementById('complete-modal').classList.add('on');
            } else {
                return res.text().then(function(t) {
                    showToast('등록에 실패했습니다: ' + t);
                });
            }
        }).catch(function() {
            showToast('요청에 실패했습니다. 잠시 후 다시 시도해주세요.');
        });
    }
</script>
</body>
</html>