<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>판매자 등록</title>
    <style>
        body { background: #e8e8e8; min-height: 100vh; display: flex; flex-direction: column; }
        .site-header { opacity: 1 !important; transform: translateY(0) !important; background: rgba(25, 59, 96, 0.96) !important; }
        .footer { height: auto !important; }
        body { display: flex; flex-direction: column; min-height: 100vh; }
        .page-wrap { flex: 1; }
        .page-wrap { padding: 2rem 1.5rem; max-width: 900px; width: 100%; margin: 0 auto; padding-top: calc(74px + 2rem); flex: 1; box-sizing: border-box; }
        .breadcrumb { font-size: 12px; color: #666; margin-bottom: 1rem; }
        .card { background: #f0f0f0; border-radius: 12px; padding: 1.5rem 2rem; }
        .card-title { text-align: center; font-size: 20px; font-weight: 500; margin-bottom: 1.5rem; color: #1a1a1a; }
        .inner-box { background: #e0e0e0; border-radius: 8px; padding: 1.5rem; margin-bottom: 2rem; }
        .inner-box p { font-weight: 500; margin-bottom: 1rem; color: #333; }
        .check-label { display: flex; align-items: center; gap: 8px; margin-bottom: 10px; cursor: pointer; font-size: 14px; color: #333; }
        .btn-row { display: flex; justify-content: center; gap: 1rem; margin-top: 2rem; }
        .btn-dark { background: #1e3a5f; color: #fff; border: none; border-radius: 30px; padding: 10px 40px; font-size: 15px; cursor: pointer; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="page-wrap">
    <p class="breadcrumb">판매자 등록</p>

    <div class="card">
        <h2 class="card-title">판매자 신원 확인</h2>

        <div class="inner-box">
            <p>판매 경험이 있나요?</p>
            <label class="check-label">
                <input type="checkbox" id="chk-new" name="experience" value="N" onchange="handleCheck('chk-new', 'chk-exp')">
                처음 판매합니다.
            </label>
            <label class="check-label">
                <input type="checkbox" id="chk-exp" name="experience" value="Y" onchange="handleCheck('chk-exp', 'chk-new')">
                판매해본 적 이 있습니다.
            </label>
        </div>

        <div class="btn-row">
            <button onclick="location.href='${pageContext.request.contextPath}/'" class="btn-dark">이전</button>
            <button onclick="goNext()" class="btn-dark">다음</button>
        </div>
    </div>
</div>

<div class="floating-buttons">
    <button type="button" class="floating-btn ai-btn" aria-label="AI 멘토링" data-auth-required="true">
        <img src="${pageContext.request.contextPath}/images/ai_modal.jpg?v=1" alt="AI 멘토링">
    </button>
    <button type="button" class="floating-btn chat-btn" aria-label="1대1 질의응답" data-auth-required="true">
        <span>···</span>
    </button>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>
    function handleCheck(checkedId, otherId) {
        const checked = document.getElementById(checkedId);
        const other = document.getElementById(otherId);
        if (checked.checked) other.checked = false;
    }

    function goNext() {
        const chkNew = document.getElementById('chk-new');
        const chkExp = document.getElementById('chk-exp');
        if (!chkNew.checked && !chkExp.checked) {
            alert('항목을 선택해주세요.');
            return;
        }
        if (chkExp.checked) {
            location.href = '${pageContext.request.contextPath}/party/seller-verify';
        } else {
            location.href = '${pageContext.request.contextPath}/party/seller-register?hasExperience=N';
        }
    }
</script>
</body>
</html>