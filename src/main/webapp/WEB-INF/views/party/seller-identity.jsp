<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>판매자 등록</title>
    <style>
        body {
            background: #e8e8e8;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            margin: 0;
        }
        .footer { height: auto !important; }

        .page-wrap {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: calc(74px + 3rem) 1.5rem 3rem;
            box-sizing: border-box;
        }

        .breadcrumb {
            font-size: 18px;
            color: #333;
            margin-bottom: 1.8rem;
            font-weight: 700;
            text-align: center;
        }

        .card {
            background: #f0f0f0;
            border-radius: 16px;
            padding: 2.8rem 3.5rem;
            width: 100%;
            max-width: 720px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .card-title {
            text-align: center;
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 2rem;
            color: #1a1a1a;
        }

        .inner-box {
            background: #e0e0e0;
            border-radius: 12px;
            padding: 2.3rem 2.5rem;
            margin-bottom: 2.5rem;
        }

        .inner-box p {
            font-size: 17px;
            font-weight: 600;
            margin-bottom: 1.4rem;
            color: #222;
        }

        .check-label {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 14px;
            cursor: pointer;
            font-size: 16px;
            color: #333;
        }

        .check-label input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .btn-row {
            display: flex;
            justify-content: center;
            gap: 1rem;
        }

        .btn-dark {
            background: #1e3a5f;
            color: #fff;
            border: none;
            border-radius: 30px;
            padding: 12px 48px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn-dark:hover { background: #162d4a; }
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
                판매해본 적이 있습니다.
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