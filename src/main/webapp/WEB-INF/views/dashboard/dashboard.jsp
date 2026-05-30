<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 대시보드</title>
    <link rel="stylesheet" href="/css/dashboard.css">
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <script src="/js/vendor/chart.min.js"></script>
</head>
<body>

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

    <main class="dashboard-container">

            <div class="summary-cards">
                        <div class="summary-card">
                            <span class="sc-title">이번 달 지출</span>
                            <span class="sc-value">₩<fmt:formatNumber value="${allTotal}" pattern="#,###" /></span>
                        </div>
                        <div class="summary-card">
                            <span class="sc-title">지난 달 지출</span>
                            <span class="sc-value" style="color: #52616B;">₩<fmt:formatNumber value="${lastMonthTotal}" pattern="#,###" /></span>
                        </div>
                        <div class="summary-card">
                            <span class="sc-title">월 평균 지출</span>
                            <span class="sc-value" style="color: #3F72AF;">₩<fmt:formatNumber value="${averageExpense}" pattern="#,###" /></span>
                        </div>
                        <div class="summary-card">
                            <span class="sc-title">이번 달 저축액 💰</span>
                            <span class="sc-value" style="color: #2b6cb0;">₩<fmt:formatNumber value="${savingsTotal}" pattern="#,###" /></span>
                        </div>
                    </div>

            <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 20px;">

                <div class="dashboard-tabs" id="mainTabs" style="margin-bottom: 0;">
                    <div class="tab active" onclick="changeTab('analysis', this)">카테고리별 분석</div>
                    <div class="tab" onclick="changeTab('monthly', this)">월별 비교</div>
                    <div class="tab" onclick="changeTab('goal', this)">목표 관리</div>
                </div>

                <div class="top-action-bar" style="margin-bottom: 0; display: flex; gap: 10px;">
                    <button type="button" class="btn-secondary" onclick="openGoalModal()">목표 설정</button>
                    <button type="button" id="mainExpenseBtn" class="btn-primary" style="background: #2b6cb0;" onclick="openExpenseModal('create')">+ 지출 입력</button>
                    <button type="button" id="mainSavingBtn" class="btn-primary" style="display: none; background: #2b6cb0;" onclick="openSavingModal()">+ 저축 입력</button>
                </div>

            </div>

            <div id="tab-analysis" class="tab-content" style="display: block;">

                <div class="analysis-card">
                    <div class="toggle-container" style="margin-bottom: 25px;">
                    <button type="button" class="toggle-btn active" onclick="updateChart('all', event)">전체 보기</button>
                    <button type="button" class="toggle-btn" onclick="updateChart('fixed', event)">고정 지출</button>
                    <button type="button" class="toggle-btn" onclick="updateChart('variable', event)">변동 지출</button>
                </div>

                <!-- 좌우 제목 정렬선 일치 셋업 -->
                <div class="analysis-header-row" style="display: flex; gap: 0; margin-bottom: 15px;">
                    <h3 class="analysis-title" style="flex: 1.3; margin: 0; min-width: 450px;">카테고리별 지출 분포</h3>
                    <div class="header-divider-space" style="width: 1px; margin: 0;"></div>
                    <h3 class="analysis-title" style="flex: 1; margin: 0; min-width: 400px; padding-left: 60px; box-sizing: border-box;">카테고리별 상세 분석</h3>
                </div>

                <!-- 본문 그래프 및 초대형 게이지바 구역 -->
                <div class="analysis-grid" style="margin-top: 0; position: relative;">

                            <c:if test="${empty allTotal or allTotal == 0}">
                                <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;
                                            background: rgba(240, 245, 249, 0.9); z-index: 10;
                                            display: flex; align-items: center; justify-content: center;
                                            flex-direction: column; border-radius: 12px; backdrop-filter: blur(2px);">
                                    <span style="font-size: 45px; margin-bottom: 15px;">📊</span>
                                    <p style="font-size: 18px; font-weight: bold; color: #52616B; text-align: center; line-height: 1.6; margin: 0;">
                                        이번 달 지출이 없습니다.<br>
                                        지출을 입력해주시고 확인해 주세요.
                                    </p>
                                </div>
                            </c:if>
                    <!-- 왼쪽 차트실 (여백 0으로 꽉 채운 웅장한 크기) -->
                    <div class="analysis-left" style="padding-top: 15px; margin-top: 0;">
                        <div class="chart-container">
                            <canvas id="expenseChart"></canvas>
                        </div>
                    </div>

                    <!-- 중앙 세로 실선 분할선 (우측 게이지 바 높이에 맞춰 길게 연장) -->
                    <div class="analysis-divider"></div>

                    <!-- 오른쪽 대형 상세 분석실 (글씨 16px, 게이지 두께 16px 적용 완료) -->
                    <div class="analysis-right" style="padding-top: 15px;">
                        <div id="categoryDetailList" class="detail-list">
                            <!-- JS에서 동적으로 그려집니다 -->
                        </div>
                        <div id="mostSpentBox" class="most-spent-box">
                        </div>
                        </div>
                        </div>
                    </div>

            </div>


            <div id="tab-monthly" class="tab-content" style="display: none;">

                    <div class="analysis-card" style="margin-bottom: 25px;">
                        <h3 class="analysis-title" style="margin-bottom: 20px;">카테고리별 월간 비교</h3>
                        <div style="height: 300px; width: 100%;">
                            <canvas id="comparisonChart"></canvas>
                        </div>
                    </div>

                    <div style="display: flex; gap: 25px; flex-wrap: wrap;">
                        <div class="analysis-card" style="flex: 1.5; min-width: 400px; margin-bottom: 0;">
                            <h3 class="analysis-title" style="margin-bottom: 25px;">카테고리별 변화 분석</h3>
                            <div id="categoryChangeList" class="change-list">
                                </div>
                        </div>

                        <div class="analysis-card" style="flex: 1; min-width: 300px; margin-bottom: 0;">
                                        <h3 class="analysis-title" style="margin-bottom: 25px;">최근 ${trendMonthCount}개월 요약</h3>
                            <div class="trend-list">
                                <c:forEach items="${trendLabels}" var="label" varStatus="status">
                                    <div class="trend-item">
                                        <div class="trend-month">
                                            <strong>${label}</strong>
                                            <span>₩<fmt:formatNumber value="${trendData[status.index]}" pattern="#,##0" /></span>
                                        </div>
                                        <c:choose>
                                            <c:when test="${status.index > 0}">
                                                <c:set var="prevAmt" value="${trendData[status.index - 1]}" />
                                                <c:set var="currAmt" value="${trendData[status.index]}" />
                                                <c:choose>
                                                    <c:when test="${currAmt > prevAmt}"><span class="badge badge-danger">초과</span></c:when>
                                                    <c:when test="${currAmt < prevAmt}"><span class="badge badge-success">절감</span></c:when>
                                                    <c:otherwise><span class="badge badge-normal">유지</span></c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <%-- status.index == 0 (화면의 첫 번째 줄) 일 때의 처리 --%>
                                                <c:choose>
                                                    <c:when test="${isAbsolutelyFirst}">
                                                        <%-- 유저의 진짜 첫 지출 기록이면 무조건 유지 --%>
                                                        <span class="badge badge-normal">유지</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <%-- 진짜 첫 기록이 아니라면(잘려나간 과거 데이터가 있다면) 몰래 가져온 금액과 비교! --%>
                                                        <c:set var="currAmt" value="${trendData[0]}" />
                                                        <c:choose>
                                                            <c:when test="${currAmt > firstMonthPrevAmt}"><span class="badge badge-danger">초과</span></c:when>
                                                            <c:when test="${currAmt < firstMonthPrevAmt}"><span class="badge badge-success">절감</span></c:when>
                                                            <c:otherwise><span class="badge badge-normal">유지</span></c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="tab-goal" class="tab-content" style="display: none;">
                    <div class="analysis-card" style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                            <h3 class="analysis-title" style="margin: 0;">목표 달성 진행률</h3>
                            <select id="goalChartSelect" class="large-input" style="width: 200px; margin: 0; padding: 6px 12px; cursor: pointer;" onchange="updateGoalChart()">
                                <c:forEach items="${goalList}" var="g">
                                    <option value="${g.id}" data-isfixed="${g.isFixed}">${g.goalName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div style="height: 300px; width: 100%;">
                            <canvas id="goalProgressChart"></canvas>
                        </div>
                    </div>

                    <div style="display: flex; gap: 25px; flex-wrap: wrap;">
                        <div class="analysis-card" style="flex: 1.2; min-width: 400px; margin-bottom: 0;">
                            <h3 class="analysis-title" style="margin-bottom: 25px;">현재 목표 진행률</h3>
                            <div class="goal-progress-list">
                                <c:forEach items="${goalList}" var="g">
                                    <c:set var="currentSaved" value="${goalCurrentTotals[g.id] != null ? goalCurrentTotals[g.id] : 0}" />
                                    <c:set var="targetAmt" value="${g.targetAmount}" />
                                    <c:set var="progressPercent" value="${targetAmt > 0 ? (currentSaved / targetAmt) * 100 : 0}" />
                                    <c:if test="${progressPercent > 100}"><c:set var="progressPercent" value="100" /></c:if>

                                    <div class="goal-progress-item">
                                        <div class="goal-progress-header">
                                            <span class="goal-name-text">
                                                ${g.goalName}
                                                <c:if test="${g.isFixed == 'Y'}"><span class="badge badge-normal" style="padding: 2px 6px; font-size: 11px; margin-left: 5px;">고정</span></c:if>
                                            </span>
                                            <span class="goal-percent-text"><fmt:formatNumber value="${progressPercent}" pattern="##0.0"/>%</span>
                                        </div>
                                        <div class="progress-bg" style="height: 12px; margin-bottom: 8px; border-radius: 6px; background: #F0F5F9;">
                                            <div class="progress-fill" style="height: 100%; border-radius: 6px; width: ${progressPercent}%; background-color: #3F72AF; transition: width 1.2s ease;"></div>
                                        </div>
                                        <div style="display: flex; justify-content: space-between; font-size: 13px; color: #8b95a1;">
                                            <span>현재: ₩<fmt:formatNumber value="${currentSaved}" pattern="#,##0" /></span>
                                            <span>목표: ₩<fmt:formatNumber value="${targetAmt}" pattern="#,##0" /></span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="analysis-card" style="flex: 1; min-width: 300px; margin-bottom: 0;">
                            <h3 class="analysis-title" style="margin-bottom: 25px;">목표 달성 팁</h3>
                            <div class="goal-tips-list">
                                <div class="tip-box tip-success">
                                    <strong>✓ 잘하고 있어요!</strong>
                                    <c:choose>
                                        <c:when test="${allTotal < lastMonthTotal}">
                                            <p>지난달보다 지출을 <b>₩<fmt:formatNumber value="${lastMonthTotal - allTotal}" pattern="#,###" /></b>이나 절약하셨네요! 절감한 금액을 저축으로 돌려보세요.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p>이번 달 총 <b>₩<fmt:formatNumber value="${savingsTotal}" pattern="#,###" /></b>을 저축하셨습니다. 꾸준한 기록이 목표 달성의 첫걸음입니다!</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="tip-box tip-warning">
                                    <strong>⚠ 주의하세요</strong>
                                    <c:choose>
                                        <c:when test="${not empty allLabels}">
                                            <c:set var="topCategory" value="${allLabels.iterator().next()}" />
                                            <p>이번 달은 <b>[${topCategory}]</b> 카테고리에서 지출이 가장 많습니다. 변동 지출이라면 다음 달엔 조금 줄여보는 건 어떨까요?</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p>아직 이번 달 지출 내역이 충분하지 않습니다. 지출이 생기면 잊지 말고 꼭 기록해 주세요!</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="tip-box tip-info">
                                    <strong>💡 제안</strong>
                                    <c:choose>
                                        <c:when test="${not empty goalList}">
                                            <c:set var="firstGoal" value="${goalList[0]}" />
                                            <p><b>'${firstGoal.goalName}'</b> 목표를 달성하기 위해 커피 한 잔 값을 아껴서 추가 저축을 해보는 건 어떨까요?</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p>아직 설정된 목표가 없네요! 상단의 '목표 설정' 버튼을 눌러 나만의 재무 목표를 세워보세요.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </main>

            <%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

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
                    <div id="categoryContainer" class="category-grid" style="margin-bottom: 25px;">
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
                    <p class="section-title">입력된 지출 내역</p>
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

        <div id="savingEntryModal" class="modal-overlay" style="display: none; z-index: 1000;">
            <div class="modal-content bottom-sheet">
                <div class="modal-header">
                    <h3>저축 내역 추가</h3>
                    <button type="button" class="close-btn" onclick="closeSavingModal()">✕</button>
                </div>

                <div class="modal-tabs" id="savingModalTabs">
                    <button type="button" class="tab-btn active" onclick="switchSavingTab('regular', event)">일반 저축</button>
                    <button type="button" class="tab-btn" onclick="switchSavingTab('fixed', event)">고정 저축</button>
                </div>

                <div class="date-container">
                    <p class="section-title">날짜 선택</p>
                    <input type="date" id="savingDateInput" class="large-input full-input" style="margin-bottom: 25px;">
                </div>

                <div style="margin-bottom: 25px;">
                    <p class="section-title" id="savingGoalLabel">어떤 목표에 저축하시나요?</p>
                    <select id="savingGoalSelect" class="large-input full-input" style="margin-bottom: 0;">
                        <option value="">목표를 선택해주세요</option>
                    </select>
                </div>

                <div class="entered-section">
                    <p class="section-title">입력된 저축 내역</p>
                    <div id="savingEnteredList" class="entered-list-container">
                        <div class="empty-list">아직 입력된 내역이 없습니다.</div>
                    </div>
                </div>

                <div class="bottom-input-row">
                    <div class="amount-wrapper">
                        <span class="currency-label">금액 (₩)</span>
                        <input type="text" id="savingAmountInput" class="bottom-amount-input" placeholder="0" oninput="formatNumber(this)">
                    </div>
                    <button type="button" class="add-to-list-btn" style="background: #2b6cb0;" onclick="addToSavingList()">추가하기</button>
                </div>
                <button type="button" class="final-save-btn" style="background: #2b6cb0;" onclick="saveAllSavingData()">저축 내역 저장 완료</button>
            </div>
        </div>

        <div id="goalRegistrationModal" class="modal-overlay" style="display: none;">
            <div class="modal-content bottom-sheet wide-sheet">
                <div class="modal-header">
                    <h3>나의 목표 설정</h3>
                    <button type="button" class="close-btn" onclick="closeGoalModal()">✕</button>
                </div>
                <div class="goal-section" style="margin-bottom: 30px;">
                    <p class="section-title" style="color: #3F72AF; font-size: 15px;">고정 목표 (최대 1개)</p>
                    <div class="goal-row" style="display: flex; gap: 10px; align-items: center;">
                        <input type="hidden" id="fixedGoalId">
                        <input type="text" id="fixedGoalName" class="large-input full-input" style="flex: 1.5; margin-bottom: 0;" placeholder="목표 이름 (예: 내집마련)">
                        <input type="text" id="fixedGoalAmount" class="large-input full-input" style="flex: 1; margin-bottom: 0;" placeholder="금액 (₩)" oninput="formatNumber(this)">
                        <div style="width: 45px; height: 48px;"></div>
                    </div>
                </div>
                <div class="goal-section" style="margin-bottom: 20px;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                        <p class="section-title" style="margin: 0; font-size: 15px;">일반 목표 (최대 4개)</p>
                        <button type="button" class="btn-secondary" style="padding: 6px 12px; font-size: 13px;" onclick="addRegularGoalRow()">+ 추가</button>
                    </div>
                    <div id="regularGoalContainer"></div>
                </div>
                <button type="button" class="final-save-btn" onclick="saveGoalData()">목표 저장 완료</button>
            </div>
        </div>

        <div id="editExpenseModal" class="modal-overlay" style="display: none;">
            <div class="modal-content bottom-sheet wide-sheet">
                <div class="modal-header">
                    <h3>내역 수정</h3>
                    <button type="button" class="close-btn" onclick="closeEditModal()">✕</button>
                </div>
                <div id="editOriginalAmountDisplay" style="text-align: center; font-size: 32px; font-weight: bold; color: #191f28; margin-bottom: 25px;">0원</div>
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
                <div class="modal-actions" style="margin-top: 10px; display: flex; gap: 10px;">
                    <button type="button" class="delete-btn" onclick="submitDelete()" style="flex:1;">삭제하기</button>
                    <button type="button" class="primary-btn" onclick="submitEdit()" style="flex:2;">수정 완료</button>
                </div>
            </div>
        </div>

        <div id="editSavingModal" class="modal-overlay" style="display: none; z-index: 2000;">
            <div class="modal-content bottom-sheet wide-sheet">
                <div class="modal-header">
                    <h3>저축 내역 수정</h3>
                    <button type="button" class="close-btn" onclick="closeSavingEditModal()">✕</button>
                </div>
                <div id="editSavingOriginalAmountDisplay" style="text-align: center; font-size: 32px; font-weight: bold; color: #2b6cb0; margin-bottom: 25px;">0원</div>
                <div class="date-container">
                    <p class="section-title">날짜</p>
                    <input type="date" id="editSavingDateInput" class="large-input full-input" style="margin-bottom: 20px;">
                </div>
                <div style="margin-bottom: 25px;">
                    <p class="section-title">목표 선택</p>
                    <select id="editSavingGoalSelect" class="large-input full-input" style="margin-bottom: 0;">
                        <option value="">목표를 선택해주세요</option>
                        <c:forEach items="${goalList}" var="g">
                            <option value="${g.id}">${g.goalName}</option>
                        </c:forEach>
                    </select>
                </div>
                <p class="section-title">금액 수정</p>
                <input type="text" id="editSavingAmountInput" class="large-input full-input" placeholder="수정할 금액 입력" oninput="formatNumber(this)">
                <input type="hidden" id="editSavingTargetId">
                <input type="hidden" id="editSavingTargetIsDb">
                <div class="modal-actions" style="margin-top: 10px; display: flex; gap: 10px;">
                    <button type="button" class="delete-btn" onclick="submitSavingDelete()" style="flex:1;">삭제하기</button>
                    <button type="button" class="primary-btn" onclick="submitSavingEdit()" style="flex:2; background: #2b6cb0;">수정 완료</button>
                </div>
            </div>
        </div>

        <div id="customConfirmModal" class="modal-overlay" style="display: none; z-index: 3000;">
                <div class="confirm-content" style="background: #ffffff; border-radius: 16px; padding: 30px; width: 100%; max-width: 320px; text-align: center; box-shadow: 0 10px 40px rgba(0,0,0,0.15);">
                    <h3 id="confirmTitle" class="confirm-title" style="margin: 0 0 15px 0; font-size: 18px; font-weight: 700; color: #112D4E;">확인</h3>
                    <p id="confirmMessage" class="confirm-message" style="margin: 0 0 25px 0; font-size: 14px; color: #52616B;">정말 진행하시겠습니까?</p>
                    <div class="confirm-actions" style="display: flex; gap: 10px;">
                        <button type="button" class="btn-cancel" onclick="closeConfirmModal()" style="flex: 1; padding: 12px; background: #F9F7F7; color: #52616B; border: none; border-radius: 10px; font-size: 14px; font-weight: bold; cursor: pointer;">취소</button>
                        <button type="button" class="btn-danger" onclick="executeConfirmAction()" style="flex: 1; padding: 12px; background: #e57373; color: #ffffff; border: none; border-radius: 10px; font-size: 14px; font-weight: bold; cursor: pointer;">확인</button>
                    </div>
                </div>
            </div>

        <div id="customAlertModal" class="modal-overlay" style="display: none; z-index: 4000;">
                <div class="confirm-content" style="background: #ffffff; border-radius: 16px; padding: 30px; width: 100%; max-width: 320px; text-align: center; box-shadow: 0 10px 40px rgba(0,0,0,0.15);">
                    <h3 id="alertTitle" class="confirm-title" style="margin: 0 0 15px 0; font-size: 18px; font-weight: 700; color: #3F72AF;">알림</h3>
                    <p id="alertMessage" class="confirm-message" style="margin: 0 0 25px 0; font-size: 14px; color: #52616B;">메시지</p>
                    <div class="confirm-actions" style="display: flex; justify-content: center;">
                        <button type="button" class="btn-primary" onclick="executeAlertAction()" style="width: 100%; padding: 12px; background: #3F72AF; color: #ffffff; border: none; border-radius: 10px; font-size: 14px; font-weight: bold; cursor: pointer;">확인</button>
                    </div>
                </div>
            </div>

        <%@ include file="/WEB-INF/views/common/modal/authModal.jspf" %>
                <%@ include file="/WEB-INF/views/common/modal/faqModal.jspf" %>
                <%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>
                <script src="${pageContext.request.contextPath}/js/pages/faq.js"></script>




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
            <c:forEach items="${screenExpenses}" var="e" varStatus="s">
            {
                id: '${e.id}',
                isDb: true,
                type: '${e.isFixed == "Y" ? "fixed" : "daily"}',
                categoryId: '${e.category != null ? e.category.id : ""}',
                name: '${e.category != null ? e.category.name : ""}',
                amount: ${e.amount != null ? e.amount : 0},
                expenseDate: '${e.expenseDate}',
                goalId: '${e.savingGoal != null ? e.savingGoal.id : ""}',
                goalName: '${e.savingGoal != null ? e.savingGoal.goalName : ""}'
            }${!s.last ? ',' : ''}
            </c:forEach>
            ];

            window.serverGoals = [
                <c:forEach items="${goalList}" var="g" varStatus="s">
                {
                    id: '${g.id}',
                    name: '${g.goalName}',
                    amount: ${g.targetAmount != null ? g.targetAmount : 0},
                    isFixed: '${g.isFixed}'
                }${!s.last ? ',' : ''}
                </c:forEach>
            ];

            window.goalChartMonthsMap = {
                            <c:forEach items="${goalChartMonthsMap}" var="entry" varStatus="s">
                            '${entry.key}': [<c:forEach items="${entry.value}" var="val" varStatus="vs">"${val}"${!vs.last ? ',' : ''}</c:forEach>]${!s.last ? ',' : ''}
                            </c:forEach>
                        };

                        window.goalProgressData = {
                            <c:forEach items="${goalProgressData}" var="entry" varStatus="s">
                            '${entry.key}': [<c:forEach items="${entry.value}" var="val" varStatus="vs">${val}${!vs.last ? ',' : ''}</c:forEach>]${!s.last ? ',' : ''}
                            </c:forEach>
                        };

        </script>
        <script src="/js/pages/dashboard.js"></script>
    </body>
    </html>