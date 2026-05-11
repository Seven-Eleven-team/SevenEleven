<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 공통 헤더나 사이드바 include가 있다면 그 아래에 작성하세요 -->

<div class="expense-form-container">
    <form id="expenseForm">

        <!-- 1. 고정 지출 등록 박스 -->
        <div class="input-box">
            <h3>고정 지출 등록</h3>
            <div id="fixedExpenseContainer"></div>
            <button type="button" class="add-btn" onclick="addExpenseRow('fixed')">+</button>
        </div>

        <!-- 2. 오늘 지출 등록 박스 -->
        <div class="input-box">
            <h3>오늘 지출 등록</h3>
            <div id="dailyExpenseContainer"></div>
            <button type="button" class="add-btn" onclick="addExpenseRow('daily')">+</button>
        </div>

        <!-- 3. 내 목표 설정하기 박스 -->
        <div class="input-box">
            <h3>내 목표 설정하기</h3>
            <div id="goalContainer"></div>
            <button type="button" class="add-btn" onclick="addGoalRow()">+</button>
        </div>

        <button type="button" class="submit-btn" onclick="submitAllData()">입력완료</button>
    </form>
</div>

<!-- 꼭 잊지 말고 맨 아래에서 분리해둔 스크립트 파일을 불러와 주세요! -->
<script src="/js/pages/expense-form.js"></script>