<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>판매자 프로필</title>
    <style>
        body { background: #e8e8e8; min-height: 100vh; display: flex; flex-direction: column; }
        .site-header { opacity: 1 !important; transform: translateY(0) !important; background: rgba(25, 59, 96, 0.96) !important; }
        .footer { height: 130px !important; }
        .page-wrap { padding: 2rem 1.5rem; max-width: 900px; width: 100%; margin: 0 auto; padding-top: calc(74px + 2rem); flex: 1; box-sizing: border-box; }
        .page-title { text-align: center; font-size: 20px; font-weight: 500; margin-bottom: 1.5rem; color: #1a1a1a; }
        .profile-card { display: flex; gap: 0; background: #f0f0f0; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 14px rgba(0,0,0,0.06); width: 100%; box-sizing: border-box; }
        .profile-left { display: flex; flex-direction: column; align-items: center; justify-content: flex-start; padding: 2rem 1.5rem; min-width: 200px; background: #e8e8e8; box-sizing: border-box; }
        .profile-img { width: 150px; height: 190px; background: #d5d5d5; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 13px; color: #999; }
        .profile-right { flex: 1; padding: 1.5rem 2rem; }
        .info-row { display: flex; align-items: center; gap: 2rem; padding: 1rem 0; border-bottom: 1px solid #ddd; font-size: 14px; }
        .info-label { font-weight: 700; color: #333; min-width: 80px; }
        .info-value { color: #555; }
        .ott-section { margin-top: 1.5rem; }
        .ott-section h3 { font-size: 14px; font-weight: 700; color: #333; margin-bottom: 0.8rem; }
        .ott-list { display: flex; flex-wrap: wrap; gap: 10px; }
        .ott-logo { width: 52px; height: 52px; border-radius: 10px; background: #ddd; display: flex; align-items: center; justify-content: center; font-size: 10px; color: #555; text-align: center; overflow: hidden; }
        .ott-logo img { width: 100%; height: 100%; object-fit: cover; border-radius: 10px; }
        .empty-msg { font-size: 13px; color: #aaa; }
        .sell-section { margin-top: 2rem; padding-top: 1.2rem; border-top: 1px solid #ddd; display: flex; align-items: center; justify-content: space-between; }
        .sell-question { font-size: 14px; color: #555; }
        .sell-btns { display: flex; gap: 8px; }
        .btn-yes { background: #1e3a5f; color: #fff; border: none; border-radius: 20px; padding: 7px 22px; font-size: 13px; cursor: pointer; }
        .btn-no { background: transparent; color: #888; border: 1px solid #ccc; border-radius: 20px; padding: 7px 22px; font-size: 13px; cursor: pointer; }
        .btn-yes:hover { background: #162d4a; }
        .btn-no:hover { color: #555; border-color: #aaa; }
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
    var ctx = '${pageContext.request.contextPath}';
    var userId = '${sessionScope.loginUser.userId}';

    if (!userId || userId === 'null' || userId === '') {
        location.href = ctx + '/';
    } else {
        fetch(ctx + '/api/party/sellers/profile/' + userId)
            .then(function(res) { return res.json(); })
            .then(function(data) {
                document.getElementById('nickname').textContent = data.nickname || '-';

                var usedList = document.getElementById('used-ott-list');
                if (data.usedOttList && data.usedOttList.length > 0) {
                    usedList.innerHTML = data.usedOttList.map(function(ott) {
                        if (ott.iconUrl) {
                            return '<div class="ott-logo" title="' + ott.serviceName + '"><img src="' + ott.iconUrl + '" alt="' + ott.serviceName + '"></div>';
                        } else {
                            return '<div class="ott-logo" title="' + ott.serviceName + '">' + ott.serviceName + '</div>';
                        }
                    }).join('');
                } else {
                    usedList.innerHTML = '<span class="empty-msg">구매 내역이 없습니다.</span>';
                }

                var soldList = document.getElementById('sold-ott-list');
                if (data.soldOttList && data.soldOttList.length > 0) {
                    soldList.innerHTML = data.soldOttList.map(function(ott) {
                        if (ott.iconUrl) {
                            return '<div class="ott-logo" title="' + ott.serviceName + '"><img src="' + ott.iconUrl + '" alt="' + ott.serviceName + '"></div>';
                        } else {
                            return '<div class="ott-logo" title="' + ott.serviceName + '">' + ott.serviceName + '</div>';
                        }
                    }).join('');
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