<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>지출메이트</title>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
</head>
<body>

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<main>
    <section class="hero-section">
        <div class="hero-bg"></div>
        <div class="opening-box" aria-hidden="true"></div>

        <div class="hero-title">
            <p>모든 서비스를 한눈에</p>
            <p>지출 메이트</p>
        </div>
    </section>

    <section class="scroll-card-section">
        <div class="card-sticky">

            <article class="service-card card-01">
                <div class="card-content feature-card">
                    <div class="feature-text">
                        <span class="feature-label">AI MENTORING</span>
                        <h2>AI 멘토링</h2>
                        <p>
                            사용자의 소비 패턴과 지출 흐름을 분석해<br>
                            더 나은 자산 관리 방향을 제안합니다.
                        </p>
                    </div>

                    <div class="feature-icon-wrap">
                        <img src="${pageContext.request.contextPath}/images/ai_modal.jpg?v=1"
                             alt="AI 멘토링"
                             class="feature-icon">
                    </div>
                </div>
            </article>

            <article class="service-card card-02">
                <div class="card-content feature-card">
                    <div class="feature-text">
                        <span class="feature-label">Q&A SERVICE</span>
                        <h2>1:1 질의응답</h2>
                        <p>
                            지출 관리와 서비스 이용 중 궁금한 내용을<br>
                            빠르게 질문하고 답변을 확인할 수 있습니다.
                        </p>
                    </div>

                    <div class="feature-icon-wrap chat-icon-shape">
                        <span>···</span>
                    </div>
                </div>
            </article>

            <article class="service-card card-03">
                <div class="card-content feature-card">
                    <div class="feature-text">
                        <span class="feature-label">SUBSCRIPTION</span>
                        <h2>구독 관리</h2>
                        <p>
                            구독 서비스의 결제일, 연장, 해지 알림을<br>
                            한눈에 확인하고 관리할 수 있습니다.
                        </p>
                    </div>

                    <div class="feature-icon-wrap subscription-icon">
                        <span>₩</span>
                    </div>
                </div>
            </article>

        </div>
    </section>

    <section class="fan-card-section">
        <div class="fan-title">
            <h2>지출메이트와 함께 관리하세요</h2>
            <p>복잡한 소비와 구독 내역을 더 쉽고 명확하게 정리합니다.</p>
        </div>

        <div class="fan-card-wrap">
            <article class="fan-card fan-card-left">
                <h3>AI 멘토링</h3>
                <p>
                    사용자의 소비 패턴과 지출 흐름을 분석해<br>
                    더 나은 자산 관리 방향을 제안합니다.
                </p>
            </article>

            <article class="fan-card fan-card-center">
                <h3>구독 관리</h3>
                <p>
                    구독 서비스를 결제할 수 있고, 연장, 해지 알림을<br>
                    한 눈에 확인하고 관리할 수 있습니다.
                </p>
            </article>

            <article class="fan-card fan-card-right">
                <h3>1:1 질의응답</h3>
                <p>
                    지출 관리와 서비스 이용 중 궁금한 내용을<br>
                    빠르게 질문하고 답변을 확인할 수 있습니다.
                </p>
            </article>
        </div>
    </section>
</main>

<div class="floating-buttons">
    <button type="button" class="floating-btn ai-btn" aria-label="AI 멘토링" data-auth-required="true">
        <img src="${pageContext.request.contextPath}/images/ai_modal.jpg?v=1" alt="AI 멘토링">
    </button>

    <button type="button" class="floating-btn chat-btn" aria-label="1대1 질의응답" data-auth-required="true">
        <span>···</span>
    </button>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

<%@ include file="/WEB-INF/views/common/modal/authModal.jspf" %>

<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>
<script src="${pageContext.request.contextPath}/js/pages/index.js?v=4"></script>

</body>
</html>