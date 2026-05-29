<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>지출메이트 - 내 정보 수정</title>

    <!-- 공통 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <!-- 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/editprofile.css">

    <style>

        /* =========================
           FOOTER
        ========================= */
        .footer {
            width: 100%;
            background: #243864;
            color: white;
            padding: 40px 0;
            margin-top: 60px;
        }

        /* =========================
           BODY
        ========================= */
        body.mypage {
            padding-top: 78px;
            min-height: 100vh;

            display: flex;
            flex-direction: column;

            background: #f5f5f5;
        }

        .mypage-container {
            flex: 1;
        }

        /* =========================
           HEADER
        ========================= */

        body.mypage .auth-link {
            display: none !important;
        }

        body.mypage .header-action-area {
            position: absolute !important;
            right: 36px !important;
        }

        body.mypage .user-profile-link {
            display: flex !important;
        }

        body.mypage .site-header {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;

            width: 100% !important;
            height: 78px !important;

            background: #243864 !important;

            display: flex !important;
            align-items: center !important;
            justify-content: center !important;

            z-index: 9999 !important;
        }

        body.mypage .site-logo {
            color: white !important;
            font-size: 28px !important;
            font-weight: 800 !important;
            margin: 0 !important;
        }

        body.mypage .hamburger-btn {
            position: absolute !important;
            left: 36px !important;

            width: 42px !important;
            height: 42px !important;

            border: none !important;
            border-radius: 12px !important;

            background: rgba(255,255,255,0.15) !important;
            color: white !important;

            font-size: 22px !important;

            cursor: pointer;
        }

        body.mypage .auth-link {
            color: white !important;
            text-decoration: none !important;
        }

        body.mypage .user-profile-link {
            width: 46px !important;
            height: 46px !important;

            border-radius: 50% !important;
            background: white !important;

            display: flex !important;
            align-items: center !important;
            justify-content: center !important;

            text-decoration: none !important;
        }

        body.mypage .user-avatar {
            color: #243864 !important;
            font-weight: 700 !important;
        }

        /* =========================
           SIDEBAR
        ========================= */

        body.mypage nav.sidebar {
            position: fixed;
            top: 78px;
            left: -260px;

            width: 250px;
            height: calc(100vh - 78px);

            background: white;
            border-right: 1px solid #ddd;

            transition: all 0.3s ease;

            z-index: 9998;

            padding-top: 20px;
        }

        body.mypage nav.sidebar.open {
            left: 0;
        }

        body.mypage nav.sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        body.mypage nav.sidebar li {
            width: 100%;
        }

        body.mypage nav.sidebar li a {
            display: flex;
            align-items: center;

            height: 54px;

            padding: 0 24px;

            color: #222;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
        }

        body.mypage nav.sidebar li a:hover {
            background: #f5f5f5;
        }

        body.mypage .sidebar-overlay,
        body.mypage .sidebar-drawer,
        body.mypage .sidebar-menu,
        body.mypage .mobile-sidebar {
            display: none !important;
        }

    </style>

</head>

<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">

    <!-- 메인 -->
    <div class="profile-page">

        <div class="profile-card">

            <h3 class="inner-title">
                내 정보 수정
            </h3>

           <!-- 프로필 이미지 -->
           <div class="profile-img-area">

               <label for="profileImageInput" class="profile-circle profile-upload">

                   <img id="profilePreview"
                        src="${pageContext.request.contextPath}/images/profile.jpg"
                        alt="프로필">

                   <div class="profile-overlay">
                       사진 변경
                   </div>

               </label>

               <input type="file"
                      id="profileImageInput"
                      accept="image/*"
                      hidden>

           </div>

            <!-- 수정 폼 -->
            <form class="edit-form">

           <!-- 왼쪽 -->
           <div class="form-column">

               <div class="input-item">

                   <label>현재 이메일</label>

                   <input type="email"
                          value="ymd3123@naver.com"
                          readonly>

               </div>

               <div class="input-item">

                   <label>새 이메일</label>

                   <input type="email"
                          placeholder="새 이메일 입력">

               </div>

               <div class="input-item">

                   <label>닉네임</label>

                   <input type="text"
                          placeholder="닉네임 입력">

               </div>

           </div>

                <!-- 오른쪽 -->
                <div class="form-column">

                    <div class="input-item">

                        <label>현재 비밀번호</label>

                        <input type="password"
                               placeholder="현재 비밀번호">

                    </div>

                    <div class="input-item">

                        <label>새 비밀번호</label>

                        <input type="password"
                               placeholder="새 비밀번호">

                    </div>

                    <div class="input-item">

                        <label>새 비밀번호 확인</label>

                        <input type="password"
                               placeholder="새 비밀번호 확인">

                    </div>

                </div>

            </form>

            <!-- 계좌 변경 -->
            <div class="account-change-section">

                <h3 class="inner-title">
                    계좌 변경
                </h3>

                <div class="account-form">



                  <div class="input-item">

                      <label>계좌번호</label>

                      <div class="account-row">

                          <button type="button"
                                  class="bank-btn"
                                  onclick="openBankModal()"
                                  id="selectedBank">

                              은행선택

                          </button>

                          <input type="text"
                                 class="account-input"
                                 placeholder="계좌번호">

                      </div>

                  </div>

                    <div class="input-item">

                        <label>예금주</label>

                        <input type="text"
                               placeholder="예금주명을 입력하세요">

                    </div>

                </div>

            </div>
             <!-- AI 멘토 성향 -->
             <div class="account-change-section">

                             <h3 class="inner-title">
                                 AI 멘토 성향
                             </h3>
                      <div class="input-item">
                          <label>AI 멘토 성향</label>

                          <select name="aiTone" class="mentor-select">
                              <option value="GOOD" ${user.aiTone == 'GOOD' ? 'selected' : ''}>착한맛</option>
                              <option value="NORMAL" ${user.aiTone == 'NORMAL' ? 'selected' : ''}>중간맛</option>
                              <option value="BAD" ${user.aiTone == 'BAD' ? 'selected' : ''}>매운맛</option>
                          </select>
                      </div>

            <!-- 버튼 -->
            <div class="form-btns">

                <button type="button"
                        class="btn-gray"
                        onclick="history.back()">

                    이전으로

                </button>

                <button type="button"
                        class="btn-navy"
                        onclick="saveProfile()">

                    수정 완료

                </button>

            </div>


        </div>

    </div>

</div>
<!-- 은행 선택 모달 -->
<div id="bankModal" class="bank-modal">

    <div class="bank-modal-content">

        <div class="bank-modal-header">

            <h3>은행 선택</h3>

            <span class="close-bank-modal"
                  onclick="closeBankModal()">

                ×

            </span>

        </div>

        <div class="bank-list">

            <button type="button" onclick="selectBank('국민은행')">국민은행</button>
            <button type="button" onclick="selectBank('신한은행')">신한은행</button>
            <button type="button" onclick="selectBank('우리은행')">우리은행</button>
            <button type="button" onclick="selectBank('하나은행')">하나은행</button>
            <button type="button" onclick="selectBank('농협은행')">농협은행</button>
            <button type="button" onclick="selectBank('카카오뱅크')">카카오뱅크</button>
            <button type="button" onclick="selectBank('토스뱅크')">토스뱅크</button>
            <button type="button" onclick="selectBank('기업은행')">기업은행</button>

        </div>

    </div>

</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

<script src="${pageContext.request.contextPath}/js/profile.js"></script>

<script>

    const hamburgerBtn = document.querySelector('.hamburger-btn');
    const sidebar = document.querySelector('nav.sidebar');

    if (hamburgerBtn && sidebar) {

        hamburgerBtn.addEventListener('click', function () {

            sidebar.classList.toggle('open');

        });

    }
    function openBankModal() {

        document.getElementById('bankModal').style.display = 'flex';
    }

    function closeBankModal() {

        document.getElementById('bankModal').style.display = 'none';
    }

    function selectBank(bankName) {

        document.getElementById('selectedBank').innerText = bankName;

        closeBankModal();
    }
const profileInput = document.getElementById('profileImageInput');
const profilePreview = document.getElementById('profilePreview');

profileInput.addEventListener('change', function(e){

    const file = e.target.files[0];

    if(file){

        const reader = new FileReader();

        reader.onload = function(event){

            profilePreview.src = event.target.result;

        };

        reader.readAsDataURL(file);
    }

});
</script>

</body>

</html>