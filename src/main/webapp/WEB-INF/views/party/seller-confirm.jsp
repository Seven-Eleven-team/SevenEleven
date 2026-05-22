<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>OTT 판매 확인</title>
    <style>
        body { background: #e8e8e8; min-height: 100vh; display: flex; flex-direction: column; }
        .site-header { opacity: 1 !important; transform: translateY(0) !important; background: rgba(25, 59, 96, 0.96) !important; }
        .footer { height: 130px !important; }
        .page-wrap { padding: 2rem 1.5rem; max-width: 900px; width: 100%; margin: 0 auto; padding-top: calc(74px + 2rem); flex: 1; box-sizing: border-box; }
        .breadcrumb { font-size: 12px; color: #666; margin-bottom: 1rem; }
        .card { background: #f0f0f0; border-radius: 12px; padding: 1.5rem 2rem; box-shadow: 0 4px 14px rgba(0,0,0,0.06); text-align: center; }
        .card-title { font-size: 20px; font-weight: 500; margin-bottom: 1rem; color: #1a1a1a; }
        .card-sub { font-size: 14px; color: #555; margin-bottom: 2.5rem; line-height: 1.6; }
        .btn-row { display: flex; justify-content: center; gap: 1rem; margin-top: 1rem; }
        .btn-dark { background: #1e3a5f; color: #fff; border: none; border-radius: 30px; padding: 10px 40px; font-size: 15px; cursor: pointer; }
        .btn-outline { background: #fff; border: 1px solid #ccc; border-radius: 30px; padding: 10px 40px; font-size: 15px; cursor: pointer; color: #333; }
        .btn-dark:hover { background: #162d4a; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="page-wrap">
    <p class="breadcrumb">판매자 등록</p>

    <div class="card">
        <h2 class="card-title">OTT를 바로 판매하시겠습니까?</h2>
        <p class="card-sub">개인정보가 저장되었습니다.<br>지금 바로 OTT 판매 등록을 진행하시겠습니까?</p>

        <div class="btn-row">
            <button onclick="goNo()" class="btn-outline">아니요 (다음에 판매하겠습니다)</button>
            <button onclick="goYes()" class="btn-dark">예 (바로 판매하고 싶습니다)</button>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script>
    const ctx = '${pageContext.request.contextPath}';

    function goYes() {
        location.href = ctx + '/party/form';
    }

    function goNo() {
        location.href = ctx + '/';
    }
</script>
</body>
</html>