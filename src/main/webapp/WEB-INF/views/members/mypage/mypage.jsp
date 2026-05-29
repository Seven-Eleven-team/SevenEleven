<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 톰캣 11버전(스프링부트 3.x)에 맞춘 필수 태그라이브러리 선언 (중복 선언 방지용) --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="menu" value="mypage"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 대시보드</title>
    <link rel="stylesheet" href="/css/mypage.css?v=2">
    <style>
    /*풋터*/
    .footer {
        width: 100%;
        background: #243864;
        color: white;
        padding: 40px 0;
        margin-top: 60px;
    }
   body.mypage {
       padding-top: 78px;

       min-height: 100vh;

       display: flex;
       flex-direction: column;
   }
   .mypage-container {
       flex: 1;
   }
    /* 마이페이지에서는 로그인 버튼 숨김 */
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
    /* 공통 햄버거 사이드바 */
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

    /* 마이페이지에서는 공통 사이드 드롭다운 숨김 */
    body.mypage .sidebar-overlay,
    body.mypage .sidebar-drawer,
    body.mypage .sidebar-menu,
    body.mypage .mobile-sidebar {
        display: none !important;
    }
   /* 공통 헤더 */
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

   /* 우측 영역 */
  body.mypage .header-action-area {
       position: absolute;
       right: 36px;
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
   }

   body.mypage .header-action-area {
       position: absolute !important;
       right: 36px !important;
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
   /* 프로필 */
   .user-profile-link {
       width: 46px;
       height: 46px;

       border-radius: 50%;

       background: white;
       color: #243864;

       display: flex;
       align-items: center;
       justify-content: center;

       font-weight: 700;
       text-decoration: none;
   }

   /* 아바타 */
  .user-avatar {
      font-size: 18px;
  }


            /* 2. 공통 사이드바 크기 및 위아래 중앙 가로막 정렬 스타일링 */
            .mypage-sidebar {
                width: 250px !important;
                min-width: 250px !important;
                height: auto !important;
                align-self: stretch !important;
                background: #ffffff !important;
                border: 1px solid #dddddd !important;
                border-radius: 20px !important;
                padding: 0 !important;
                display: flex !important;
                align-items: center !important;
            }
            .mypage-sidebar ul {
                display: flex !important;
                flex-direction: column !important;
                justify-content: center !important;
                list-style: none !important;
                padding: 0 !important;
                margin: 0 !important;
                width: 100% !important;
            }
            .mypage-sidebar li {
                width: 100% !important;
                display: block !important;
            }
            .mypage-sidebar li a {
                display: flex !important;
                justify-content: center !important;
                align-items: center !important;
                width: 100% !important;
                height: 55px !important;
                padding: 0 !important;
                line-height: 1 !important;
                text-align: center !important;
                font-size: 16px !important;
                font-weight: 500 !important;
                color: #111111 !important;
                transition: all 0.2s ease !important;
            }

            .mypage-sidebar li a:hover {
                background: #fafafa !important;
                color: #ff4d4d !important;
            }
            .mypage-sidebar li.active a {
                color: #ff4d4d !important;
                font-weight: 700 !important;
            }
        /* 해지 안내 팝업 전용 스타일 (이미지 시안 반영) */
        .cancel-modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.3);
            z-index: 2000;
            justify-content: center;
            align-items: center;
        }

        .cancel-modal-content {
            background: white;
            padding: 50px 80px;
            border-radius: 15px; /* 이미지처럼 둥근 모서리 */
            position: relative;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .cancel-modal-content p {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
            color: #333;
        }

        .cancel-close-x {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            color: #333;
        }
    </style>
</head>
<body class="mypage">
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
<div class="mypage-container">
    <aside class="mypage-sidebar">
        <%@ include file="/WEB-INF/views/members/mypage/mypage-sidebar.jspf" %>
    </aside>

    <main class="dashboard" style="flex: 1;">
        <section class="profile-combined-card">
            <div class="info-side">
                <h3 class="card-title-center">내 정보</h3>
                <div class="info-body">
                    <div class="profile-section">
                        <div class="profile-img-box">
                            <img src="/images/profile.jpg" alt="프로필">
                        </div>
<button class="edit-info-btn"
        onclick="location.href='${pageContext.request.contextPath}/mypage/editprofile'">
    내 정보 수정
</button>
                    </div>

                    <div class="text-area">
                        <div class="info-row">
                            <span>닉네임</span>
                            <strong>똥꼬발랄</strong>
                        </div>
                        <div class="info-row">
                            <span>생년월일</span>
                            <strong>2003.03.26(여)</strong>
                        </div>
                        <div class="info-row">
                            <span>이메일</span>
                            <strong>ymd3123@naver.com</strong>
                        </div>

                        <div class="withdraw-container">
                            <a href="#" class="withdraw-link" onclick="openModal(); return false;">회원 탈퇴</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="alert-side">
                <h3 class="card-title-center">입금 계좌</h3>
                <div class="single-account-box">
                    <div class="account-top">
                        <div class="main-bank-logo">
                            신
                        </div>
                        <div class="main-bank-info">
                            <strong>신한은행</strong>
                            <span>110-482-938201</span>
                        </div>
                    </div>
                    <div class="account-notice">
                        구독 환불 및 정산 시 사용되는 대표 계좌입니다.
                    </div>
                    <button class="change-account-btn"
                            onclick="location.href='/mypage/editprofile'">
                        계좌 변경하기
                    </button>
                </div>
            </div>
        </section>

        <div class="bottom-row">
            <section class="card sub-card">
                <h3 class="card-title">내 구독</h3>
                <div class="sub-list">
                    <div class="sub-item">
                        <div class="sub-icon gpt"></div>
                        <div class="sub-info">
                            <strong>Chat GPT</strong>
                            <div class="sub-meta">
                                <span>월 결제 금액 32,000원</span>
                                <span>다음 결제일 65d</span>
                            </div>
                        </div>
                        <span class="cancel-link" style="cursor:pointer;" onclick="openCancelModal()">해지하기</span>
                    </div>

                    <div class="sub-item">
                        <div class="sub-icon netflix"></div>
                        <div class="sub-info">
                            <strong>Netflix</strong>
                            <div class="sub-meta">
                                <span>월 결제 금액 17,000원</span>
                                <span>다음 결제일 12d</span>
                            </div>
                        </div>
                        <span class="cancel-link" style="cursor:pointer;" onclick="openCancelModal()">해지하기</span>
                    </div>

                    <div class="sub-item">
                        <div class="sub-icon youtube"></div>
                        <div class="sub-info">
                            <strong>YouTube Premium</strong>
                            <div class="sub-meta">
                                <span>월 결제 금액 14,900원</span>
                                <span>다음 결제일 5d</span>
                            </div>
                        </div>
                        <span class="cancel-link" style="cursor:pointer;" onclick="openCancelModal()">해지하기</span>
                    </div>
                </div>
            </section>

            <section class="card goal-card">
                <h3 class="card-title">내 개인 소비 목표</h3>
                <div class="goal-list">
                    <div class="goal-item">
                        <p>1억모으기</p>
                        <div class="progress-bg">
                            <div class="progress-bar" data-value="80">0%</div>
                        </div>
                    </div>
                    <div class="goal-item">
                        <p>집 사기</p>
                        <div class="progress-bg">
                            <div class="progress-bar" data-value="50">0%</div>
                        </div>
                    </div>
                    <div class="goal-item">
                        <p>차 사기</p>
                        <div class="progress-bg">
                            <div class="progress-bar" data-value="20">0%</div>
                        </div>
                    </div>
                    <div class="goal-item">
                        <p>모임 돈 모으기</p>
                        <div class="progress-bg">
                            <div class="progress-bar" data-value="30">0%</div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </main>
</div>

<div id="modalOverlay" class="modal-overlay">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2 style="margin-bottom: 10px;">회원 탈퇴</h2>
        <p>정말로 탈퇴하시겠습니까?<br>회원 탈퇴시 내 정보는 30일 동안 저장 되었다 삭제됩니다.</p>
        <button class="leave-btn">탈퇴하기</button>
    </div>
</div>

<div id="cancelModalOverlay" class="cancel-modal-overlay">
    <div class="cancel-modal-content">
        <span class="cancel-close-x" onclick="closeCancelModal()">&times;</span>
        <p>직접 해지 하셔야합니다.</p>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<script>
    // 기존 회원 탈퇴 모달 함수
    function openModal() {
        document.getElementById('modalOverlay').style.display = 'flex';
    }
    function closeModal() {
        document.getElementById('modalOverlay').style.display = 'none';
    }

    // [새로 추가] 직접 해지 팝업 함수
    function openCancelModal() {
        document.getElementById('cancelModalOverlay').style.display = 'flex';
    }
    function closeCancelModal() {
        document.getElementById('cancelModalOverlay').style.display = 'none';
    }

    // 배경 클릭 시 닫기
    window.onclick = function(event) {
        const modal = document.getElementById('modalOverlay');
        const cancelModal = document.getElementById('cancelModalOverlay');
        if (event.target == modal) {
            modal.style.display = 'none';
        }
        if (event.target == cancelModal) {
            cancelModal.style.display = 'none';
        }
    }

    // 기존 프로그래스 바 애니메이션 로직 그대로 유지
    window.onload = function() {
        const progressBars = document.querySelectorAll('.progress-bar');
        progressBars.forEach((progressBar) => {
            const targetValue = parseInt(progressBar.getAttribute('data-value')) || 0;
            setTimeout(() => {
                progressBar.style.width = targetValue + '%';
                if (targetValue <= 30) {
                    progressBar.style.backgroundColor = '#ff8a80';
                } else if (targetValue <= 70) {
                    progressBar.style.backgroundColor = '#fde047';
                } else {
                    progressBar.style.backgroundColor = '#a3e635';
                }
                let count = 0;
                if (targetValue > 0) {
                    const interval = setInterval(() => {
                        if (count >= targetValue) {
                            clearInterval(interval);
                            progressBar.innerText = targetValue + '%';
                        } else {
                            progressBar.innerText = count + '%';
                            count++;
                        }
                    }, 1500 / targetValue);
                } else {
                    progressBar.innerText = '0%';
                }
            }, 200);
        });
    };
   const hamburgerBtn = document.querySelector('.hamburger-btn');
   const sidebar = document.querySelector('nav.sidebar');

   if (hamburgerBtn && sidebar) {
       hamburgerBtn.addEventListener('click', function () {
           sidebar.classList.toggle('open');
       });
   }

</script>
</body>
</html>