<%-- 경로: src/main/webapp/WEB-INF/views/members/mypage/profile.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 정보 수정</title>
    <%-- CSS 경로 contextPath 적용 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
</head>
<body>

<header class="top-nav">
    <div class="menu-icon">☰</div>
    <div class="logo" onclick="location.href='${pageContext.request.contextPath}/index'" style="cursor:pointer;">지출메이트</div>
    <div class="my-page">마이페이지</div>
</header>

<div class="container">
    <%--
        [추가] 다른 마이페이지와 통일감을 주기 위해 사이드바를 포함했습니다.
        만약 프로필 수정 페이지만 넓게 쓰는 디자인이라면 이 aside 태그만 제거하시면 됩니다.
    --%>
    <aside class="sidebar">
        <ul>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mypage">대시보드</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mysub">내 구독 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mypost">내 게시글 보기</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myque">내 문의</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myreport">내 신고 목록</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/myalarm">알림</a></li>
            <li><a href="${pageContext.request.contextPath}/members/mypage/mysale">내 판매 목록</a></li>
        </ul>
    </aside>

    <main class="profile-page">
        <div class="profile-card">
            <h3 class="inner-title">내 정보 수정</h3>

            <div class="profile-img-area">
                <div class="profile-circle">
                    <img src="${pageContext.request.contextPath}/images/${user.profileImage != null ? user.profileImage : 'profile.jpg'}" alt="프로필">
                </div>
                <%-- 이미지 수정 버튼이 필요할 경우를 대비한 레이아웃 --%>
                <div style="margin-top: 10px;">
                    <button type="button" class="btn-img-edit" style="font-size: 12px; cursor: pointer;">사진 변경</button>
                </div>
            </div>

            <%-- 수정 완료 시 처리할 컨트롤러 경로 매핑 --%>
            <form class="edit-form" action="${pageContext.request.contextPath}/members/mypage/updateProfile" method="post" onsubmit="return validateForm()">
                <div class="form-column">
                    <div class="input-item">
                        <label>현재 ID</label>
                        <input type="text" id="currentId" value="${user.id}" readonly style="background-color: #f5f5f5;">
                    </div>
                    <div class="input-item">
                        <label>새 ID (변경 희망 시)</label>
                        <input type="text" id="newId" name="newId" placeholder="새 아이디를 입력하세요">
                    </div>
                </div>

                <div class="form-column">
                    <div class="input-item">
                        <label>현재 비밀번호 <span style="color:red;">*</span></label>
                        <input type="password" name="currentPassword" placeholder="현재 비밀번호를 입력해주세요" required>
                    </div>
                    <div class="input-item">
                        <label>새 비밀번호</label>
                        <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호 (8자 이상)">
                    </div>
                    <div class="input-item">
                        <label>새 비밀번호 확인</label>
                        <input type="password" id="newPasswordConfirm" name="newPasswordConfirm" placeholder="비밀번호 재입력">
                    </div>
                </div>

                <div class="form-btns">
                    <%-- 이전으로 버튼: 대시보드로 이동 --%>
                    <button type="button" class="btn-gray" onclick="location.href='${pageContext.request.contextPath}/members/mypage/mypage'">
                        이전으로
                    </button>
                    <button type="submit" class="btn-navy">
                        수정 완료
                    </button>
                </div>
            </form>
        </div>
    </main>
</div>

<script>
    // 간단한 유효성 검사 스크립트
    function validateForm() {
        const newPw = document.getElementById('newPassword').value;
        const newPwCf = document.getElementById('newPasswordConfirm').value;

        if (newPw !== "" && newPw !== newPwCf) {
            alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            return false;