<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 대시보드</title>
    <link rel="stylesheet" href="/css/dashboard.css">
    <script src="/js/vendor/chart.min.js"></script>
</head>
<body>

    <header class="main-header">
        <div class="logo">지출메이트</div>
        <nav class="nav-links">
            <a href="/dashboard" class="active">대시보드</a>
            <a href="/expense/list">지출내역</a>
            <a href="/goal/list">목표관리</a>
        </nav>
    </header>

    <main class="dashboard-container">

        <div class="stats-card horizontal-goal-card">
                    <div class="goal-header-row">
                        <div class="goal-title-area">
                            <h3>나의 목표 🎯</h3>
                            <span class="goal-name" id="displayGoalName">${goal.goalName != null ? goal.goalName : '목표를 설정해주세요'}</span>
                        </div>

                        <div class="goal-right-area">
                            <button type="button" class="goal-edit-btn" onclick="openGoalModal()">목표 등록</button>
                            <div class="goal-text-area" style="margin-top: 10px;">
                                <span class="current-text" id="displayCurrentAmount"><fmt:formatNumber value="${goal.savedAmount != null ? goal.savedAmount : 0}" pattern="#,###" />원</span>
                                <span class="target-text" id="displayTargetAmount"> / <fmt:formatNumber value="${goal.targetAmount != null ? goal.targetAmount : 0}" pattern="#,###" />원</span>
                            </div>
                        </div>
                    </div>

                    <div class="horizontal-progress-wrapper">
                        <div class="horizontal-progress-bar">
                            <c:set var="percent" value="${goal.targetAmount > 0 ? (goal.savedAmount / goal.targetAmount) * 100 : 0}" />
                            <div class="horizontal-progress-fill" style="width: ${percent > 100 ? 100 : percent}%;"></div>
                        </div>
                        <div class="progress-labels">
                            <span>0%</span>
                            <span class="percent-highlight"><fmt:formatNumber value="${percent}" maxFractionDigits="1" />% 달성!</span>
                            <span>100%</span>
                        </div>
                    </div>
                </div>

        <div class="stats-card">
            <div class="card-header action-header">
                <h2>2026년 ${thisMonthMonthValue}월 지출 통계</h2>
                <button type="button" class="header-add-btn" onclick="openExpenseModal('create')">+ 지출 입력</button>
            </div>

            <div class="toggle-container">
                <button type="button" class="toggle-btn active" onclick="updateChart('all', event)">전체 보기</button>
                <button type="button" class="toggle-btn" onclick="updateChart('fixed', event)">고정 지출</button>
                <button type="button" class="toggle-btn" onclick="updateChart('variable', event)">변동 지출</button>
            </div>
            <div class="chart-container">
                <canvas id="expenseChart"></canvas>
            </div>
            <div class="summary-box">
                <p id="totalSummaryText">이번 달 총 지출은 <strong><fmt:formatNumber value="${allTotal}" pattern="#,###" />원</strong>입니다.</p>
            </div>
        </div>

        <div class="stats-card">
            <div class="card-header">
                <h2>전월 지출 비교 표</h2>
            </div>
            <div class="chart-container">
                <canvas id="comparisonChart"></canvas>
            </div>
        </div>

    </main>

    <div id="quickEntryModal" class="modal-overlay" style="display: none;">
        <div class="modal-content bottom-sheet wide-sheet">
            <div class="modal-header">
                <h3>지출 내역 추가</h3>
                <button type="button" class="close-btn" onclick="closeExpenseModal()">✕</button>
            </div>

            <div class="modal-tabs" id="modalTabs">
                <button type="button" class="tab-btn active" onclick="switchTab('daily', event)">변동 지출</button>
                <button type="button" class="tab-btn" onclick="switchTab('fixed', event)">고정 지출</button>
            </div>

            <div class="date-container">
                <p class="section-title">날짜 선택</p>
                <input type="date" id="expenseDateInput" class="large-input full-input" style="margin-bottom: 20px;">
            </div>

            <div id="categoryArea">
                <p class="section-title">카테고리 선택</p>
                <div id="categoryContainer" class="category-grid">
                    <button type="button" class="cat-box" data-id="1" data-name="주거비">🏠 주거비</button>
                    <button type="button" class="cat-box" data-id="2" data-name="식비">🍚 식비</button>
                    <button type="button" class="cat-box" data-id="3" data-name="교통비">🚌 교통비</button>
                    <button type="button" class="cat-box" data-id="4" data-name="통신비">📱 통신비</button>
                    <button type="button" class="cat-box" data-id="5" data-name="보험료">🏥 보험료</button>
                    <button type="button" class="cat-box" data-id="6" data-name="교육비">📚 교육비</button>
                    <button type="button" class="cat-box" data-id="7" data-name="의료비">💊 의료비</button>
                    <button type="button" class="cat-box" data-id="8" data-name="오락/문화">🎮 오락/문화</button>
                    <button type="button" class="cat-box" data-id="9" data-name="의류/미용">👗 의류/미용</button>
                    <button type="button" class="cat-box" data-id="10" data-name="기타">🛒 기타</button>
                </div>
            </div>

            <div class="entered-section">
                <p class="section-title">입력된 내역</p>
                <div id="enteredList" class="entered-list-container">
                    <div class="empty-list">아직 입력된 내역이 없습니다.</div>
                </div>
            </div>

            <div class="bottom-input-row">
                <div class="amount-wrapper">
                    <span class="currency-label">금액 (₩)</span>
                    <input type="text" id="amountInput" class="bottom-amount-input" placeholder="0" oninput="formatNumber(this)">
                </div>
                <button type="button" class="add-to-list-btn" onclick="addToList()">추가하기</button>
            </div>

            <button type="button" class="final-save-btn" onclick="saveAllData()">지출 내역 저장 완료</button>
        </div>
    </div>

    <div id="goalRegistrationModal" class="modal-overlay" style="display: none;">
        <div class="modal-content bottom-sheet wide-sheet">
            <div class="modal-header">
                <h3>나의 목표 설정</h3>
                <button type="button" class="close-btn" onclick="closeGoalModal()">✕</button>
            </div>

            <p class="section-title">목표 이름</p>
            <input type="text" id="regGoalName" class="large-input full-input" placeholder="예: 1억 모으기" value="${goal.goalName}">

            <p class="section-title" style="margin-top: 10px;">목표 금액 (₩)</p>
            <input type="text" id="regGoalAmount" class="large-input full-input" placeholder="0" oninput="formatNumber(this)" value="<fmt:formatNumber value='${goal.targetAmount}' pattern='#,###' />" style="margin-bottom: 30px;">

            <button type="button" class="final-save-btn" onclick="saveGoalData()">목표 저장 완료</button>
        </div>
    </div>

    <div id="editExpenseModal" class="modal-overlay" style="display: none;">
        <div class="modal-content bottom-sheet wide-sheet">
            <div class="modal-header">
                <h3>내역 수정</h3>
                <button type="button" class="close-btn" onclick="closeEditModal()">✕</button>
            </div>

            <div id="editOriginalAmountDisplay" style="text-align: center; font-size: 32px; font-weight: bold; color: #191f28; margin-bottom: 25px;">
                0원
            </div>

            <div id="editGoalNameArea" style="display: none;">
                <p class="section-title">목표 이름 수정</p>
                <input type="text" id="editGoalNameInput" class="large-input full-input" style="margin-bottom: 20px;">
            </div>

            <div id="editExpenseDateArea">
                <p class="section-title">날짜</p>
                <input type="date" id="editExpenseDateInput" class="large-input full-input" style="margin-bottom: 20px;">
            </div>

            <div id="editCategoryArea">
                <p class="section-title">카테고리</p>
                <div class="category-grid" id="editCategoryContainer" style="margin-bottom: 25px;">
                    <button type="button" class="cat-box edit-cat" data-id="1" data-name="주거비">🏠 주거비</button>
                    <button type="button" class="cat-box edit-cat" data-id="2" data-name="식비">🍚 식비</button>
                    <button type="button" class="cat-box edit-cat" data-id="3" data-name="교통비">🚌 교통비</button>
                    <button type="button" class="cat-box edit-cat" data-id="4" data-name="통신비">📱 통신비</button>
                    <button type="button" class="cat-box edit-cat" data-id="5" data-name="보험료">🏥 보험료</button>
                    <button type="button" class="cat-box edit-cat" data-id="6" data-name="교육비">📚 교육비</button>
                    <button type="button" class="cat-box edit-cat" data-id="7" data-name="의료비">💊 의료비</button>
                    <button type="button" class="cat-box edit-cat" data-id="8" data-name="오락/문화">🎮 오락/문화</button>
                    <button type="button" class="cat-box edit-cat" data-id="9" data-name="의류/미용">👗 의류/미용</button>
                    <button type="button" class="cat-box edit-cat" data-id="10" data-name="기타">🛒 기타</button>
                </div>
            </div>

            <p class="section-title">금액 수정</p>
            <input type="text" id="editAmountInput" class="large-input full-input" placeholder="수정할 금액 입력" oninput="formatNumber(this)">

            <input type="hidden" id="editTargetId">
            <input type="hidden" id="editTargetIsDb">
            <input type="hidden" id="editTargetType">

            <div class="modal-actions" style="margin-top: 10px; display: flex; gap: 10px;">
                <button type="button" class="delete-btn" onclick="submitDelete()" style="flex:1;">삭제하기</button>
                <button type="button" class="primary-btn" onclick="submitEdit()" style="flex:2;">수정 완료</button>
            </div>
        </div>
    </div>

    <script>
        window.chartDataSets = {
            'all': {
                labels: [<c:forEach items="${allLabels}" var="l" varStatus="s">"${l}"${!s.last ? ',' : ''}</c:forEach>],
                data: [<c:forEach items="${allData}" var="d" varStatus="s">${d}${!s.last ? ',' : ''}</c:forEach>],
                total: '${allTotal}', text: '총 지출'
            },
            'fixed': {
                labels: [<c:forEach items="${fixedLabels}" var="l" varStatus="s">"${l}"${!s.last ? ',' : ''}</c:forEach>],
                data: [<c:forEach items="${fixedData}" var="d" varStatus="s">${d}${!s.last ? ',' : ''}</c:forEach>],
                total: '${fixedTotal}', text: '고정 지출'
            },
            'variable': {
                labels: [<c:forEach items="${variableLabels}" var="l" varStatus="s">"${l}"${!s.last ? ',' : ''}</c:forEach>],
                data: [<c:forEach items="${variableData}" var="d" varStatus="s">${d}${!s.last ? ',' : ''}</c:forEach>],
                total: '${variableTotal}', text: '변동 지출'
            }
        };

        window.barChartData = {
            labels: [<c:forEach items="${barCategories}" var="c" varStatus="s">"${c}"${!s.last ? ',' : ''}</c:forEach>],
            lastMonth: [<c:forEach items="${lastMonthBarData}" var="v" varStatus="s">${v}${!s.last ? ',' : ''}</c:forEach>],
            thisMonth: [<c:forEach items="${thisMonthBarData}" var="v" varStatus="s">${v}${!s.last ? ',' : ''}</c:forEach>]
        };

        window.monthLabels = { last: '${lastMonthMonthValue}월', current: '${thisMonthMonthValue}월' };

        window.dbExpenses = [
            <c:forEach items="${thisMonthExpenses}" var="e" varStatus="s">
            {
                id: '${e.id}',
                isDb: true,
                type: '${e.isFixed == 'Y' ? 'fixed' : 'daily'}',
                categoryId: '${e.category.id}',
                name: '${e.category.name}',
                amount: ${e.amount},
                expenseDate: '${e.expenseDate}',
                timeStr: '${e.expenseDate}'
            }${!s.last ? ',' : ''}
            </c:forEach>
        ];
    </script>
    <script src="/js/pages/dashboard.js"></script>
</body>
</html>