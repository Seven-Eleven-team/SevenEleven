<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>판매자 프로필</title>
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
            padding: 2rem 1.5rem;
            max-width: 960px;
            width: 100%;
            margin: 0 auto;
            padding-top: calc(74px + 2rem);
            flex: 1;
            box-sizing: border-box;
        }

        .page-title {
            text-align: center;
            font-size: 21px;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: #1a1a1a;
        }

        .profile-card {
            display: flex;
            gap: 0;
            background: #f0f0f0;
            border-radius: 12px;
            overflow: visible;
            box-shadow: 0 4px 14px rgba(0,0,0,0.06);
            width: 100%;
            min-height: 360px;
            box-sizing: border-box;
        }

        .profile-left {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            padding: 2rem 1.6rem;
            min-width: 220px;
            background: #e8e8e8;
            box-sizing: border-box;
            border-radius: 12px 0 0 12px;
        }

        .profile-img {
            width: 160px;
            height: 200px;
            background: #d5d5d5;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13.5px;
            color: #999;
        }

        .profile-right {
            flex: 1;
            padding: 1.9rem 2.2rem 1.5rem;
            box-sizing: border-box;
        }

        .info-row {
            display: flex;
            align-items: center;
            gap: 2.5rem;
            padding: 0.9rem 0 1rem;
            border-bottom: 1px solid #ddd;
            font-size: 14.5px;
        }

        .info-label {
            font-weight: 700;
            color: #333;
            min-width: 80px;
        }

        .info-value {
            color: #333;
            font-weight: 600;
            font-size: 14.5px;
        }

        .ott-section {
            margin-top: 1.45rem;
        }

        .ott-section h3 {
            font-size: 14.5px;
            font-weight: 700;
            color: #2f2f2f;
            margin: 0 0 0.85rem;
        }

        .ott-list {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            overflow: visible;
        }

        .ott-item {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .ott-logo {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: transparent;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10.5px;
            color: #555;
            text-align: center;
            overflow: hidden;
            cursor: default;
        }

        .ott-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 10px;
            display: block;
        }

        .ott-item::after {
            content: attr(data-name);
            position: absolute;
            left: 50%;
            bottom: calc(100% + 8px);
            transform: translateX(-50%);
            background: rgba(30, 58, 95, 0.96);
            color: #fff;
            font-size: 12px;
            font-weight: 500;
            padding: 5px 9px;
            border-radius: 8px;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            pointer-events: none;
            transition: opacity 0.15s ease, transform 0.15s ease;
            z-index: 30;
        }

        .ott-item::before {
            content: "";
            position: absolute;
            left: 50%;
            bottom: calc(100% + 3px);
            transform: translateX(-50%);
            border-width: 5px 5px 0 5px;
            border-style: solid;
            border-color: rgba(30, 58, 95, 0.96) transparent transparent transparent;
            opacity: 0;
            visibility: hidden;
            pointer-events: none;
            transition: opacity 0.15s ease;
            z-index: 29;
        }

        .ott-item:hover::after {
            opacity: 1;
            visibility: visible;
            transform: translateX(-50%) translateY(-2px);
        }

        .ott-item:hover::before {
            opacity: 1;
            visibility: visible;
        }

        .empty-msg {
            font-size: 13.5px;
            color: #aaa;
        }

        .sell-section {
            margin-top: 2rem;
            padding-top: 1.2rem;
            border-top: 1px solid #ddd;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .sell-question {
            font-size: 14.5px;
            color: #555;
        }

        .sell-btns {
            display: flex;
            gap: 8px;
        }

        .btn-yes {
            background: #1e3a5f;
            color: #fff;
            border: none;
            border-radius: 20px;
            padding: 7px 22px;
            font-size: 13.5px;
            cursor: pointer;
        }

        .btn-no {
            background: transparent;
            color: #888;
            border: 1px solid #ccc;
            border-radius: 20px;
            padding: 7px 22px;
            font-size: 13.5px;
            cursor: pointer;
        }

        .btn-yes:hover {
            background: #162d4a;
        }

        .btn-no:hover {
            color: #555;
            border-color: #aaa;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="page-wrap">
    <h2 class="page-title">내 정보</h2>

    <div class="profile-card">
        <div class="profile-left">
            <div class="profile-img">프로필</div>
        </div>

        <div class="profile-right">
            <div class="info-row">
                <span class="info-label">닉네임</span>
                <span class="info-value" id="nickname">불러오는 중...</span>
            </div>

            <div class="ott-section">
                <h3>사용했던 OTT 내역</h3>
                <div class="ott-list" id="used-ott-list">
                    <span class="empty-msg">불러오는 중...</span>
                </div>
            </div>

            <div class="ott-section">
                <h3>판매했던 OTT 내역</h3>
                <div class="ott-list" id="sold-ott-list">
                    <span class="empty-msg">불러오는 중...</span>
                </div>
            </div>

            <div class="sell-section">
                <span class="sell-question">OTT를 바로 판매하시겠습니까?</span>
                <div class="sell-btns">
                    <button onclick="location.href='${pageContext.request.contextPath}/party/form'" class="btn-yes">예</button>
                    <button onclick="location.href='${pageContext.request.contextPath}/'" class="btn-no">아니요</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>
    var ottLogoMap = {
        '1':  'https://www.google.com/s2/favicons?sz=64&domain=netflix.com',
        '2':  'https://www.google.com/s2/favicons?sz=64&domain=youtube.com',
        '3':  'https://www.google.com/s2/favicons?sz=64&domain=tving.com',
        '4':  'https://www.google.com/s2/favicons?sz=64&domain=disneyplus.com',
        '5':  'https://www.google.com/s2/favicons?sz=64&domain=laftel.net',
        '6':  'https://img.wavve.com/service30/profile/wavve2022.png',
        '7':  'https://www.google.com/s2/favicons?sz=64&domain=watcha.com',
        '8':  'https://www.google.com/s2/favicons?sz=64&domain=chat.openai.com',
        '9':  'https://www.google.com/s2/favicons?sz=64&domain=gemini.google.com',
        '10': 'https://www.google.com/s2/favicons?sz=64&domain=claude.ai',
        '11': 'https://www.google.com/s2/favicons?sz=64&domain=capcut.com',
        '12': 'https://www.google.com/s2/favicons?sz=64&domain=adobe.com',
        '13': 'https://www.google.com/s2/favicons?sz=64&domain=duolingo.com',
        '14': 'https://www.google.com/s2/favicons?sz=64&domain=millie.co.kr',
        '15': 'https://www.google.com/s2/favicons?sz=64&domain=microsoft.com',
        '16': 'https://play-lh.googleusercontent.com/nCB498hBglRwIDUn_UwSLXcdLv1S-q69mbwd5vBnU-S77y5VLvb1_xIJfeLeGYGiDQfq=w240-h480-rw'
    };

    function escapeHtml(value) {
        if (value === null || value === undefined) {
            return '';
        }

        return String(value)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#039;');
    }

    function renderOttItem(ott) {
        var serviceName = escapeHtml(ott.serviceName || '');
        var logoUrl = ott.iconUrl || ottLogoMap[String(ott.serviceId)] || '';

        if (logoUrl) {
            return '<div class="ott-item" data-name="' + serviceName + '">'
                +      '<div class="ott-logo">'
                +          '<img src="' + logoUrl + '" alt="' + serviceName + '">'
                +      '</div>'
                + '</div>';
        } else {
            return '<div class="ott-item" data-name="' + serviceName + '">'
                +      '<div class="ott-logo">' + serviceName + '</div>'
                + '</div>';
        }
    }

    var ctx = '${pageContext.request.contextPath}';
    var userId = '${sessionScope.LOGIN_USER_ID}';

    if (!userId || userId === 'null' || userId === '') {
        location.href = ctx + '/';
    } else {
        fetch(ctx + '/api/party/sellers/profile/' + userId)
            .then(function(res) {
                return res.json();
            })
            .then(function(data) {
                document.getElementById('nickname').textContent = data.nickname || '-';

                var usedList = document.getElementById('used-ott-list');
                if (data.usedOttList && data.usedOttList.length > 0) {
                    usedList.innerHTML = data.usedOttList.map(renderOttItem).join('');
                } else {
                    usedList.innerHTML = '<span class="empty-msg">구매 내역이 없습니다.</span>';
                }

                var soldList = document.getElementById('sold-ott-list');
                if (data.soldOttList && data.soldOttList.length > 0) {
                    soldList.innerHTML = data.soldOttList.map(renderOttItem).join('');
                } else {
                    soldList.innerHTML = '<span class="empty-msg">판매 내역이 없습니다.</span>';
                }
            })
            .catch(function() {
                document.getElementById('nickname').textContent = '-';
                document.getElementById('used-ott-list').innerHTML = '<span class="empty-msg">불러오기 실패</span>';
                document.getElementById('sold-ott-list').innerHTML = '<span class="empty-msg">불러오기 실패</span>';
            });
    }
</script>
</body>
</html>