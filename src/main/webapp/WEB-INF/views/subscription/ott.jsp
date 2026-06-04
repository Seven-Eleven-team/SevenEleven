<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지출메이트 - 서비스 선택</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>

    <link rel="stylesheet"
          as="style"
          crossorigin
          href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css"/>
    <link rel="stylesheet"
          href="/css/subscription.css">


</head>
<body>

<header>
    <div class="menu-icon">☰</div>

    <h1>지출메이트</h1>

    <div class="auth-links">
        <span>로그인 / 회원가입</span>
    </div>
</header>

<div class="main-container"
     id="mainContainer">

    <!-- VIDEO -->
    <div class="column">

        <div class="category-name">Video</div>

        <div class="swiper-container-wrapper">
            <div class="swiper mySwiper">

                <div class="swiper-wrapper">


                   <div class="swiper-slide"
                        data-name="youtube"
                        onclick="showSubscription('youtube')">
                        <div class="logo-box">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg"
                                 alt="유튜브 프리미엄">
                        </div>
                    </div>

                    <div class="swiper-slide"
                         data-name="netflix"
                         onclick="showSubscription('netflix')">
                        <div class="logo-box">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg"
                                 alt="넷플릭스">
                        </div>
                    </div>

                   <div class="swiper-slide"
                        data-name="tving"
                        onclick="showSubscription('tving')">

                       <div class="logo-box">
                           <img src="/images/tving.png"
                                alt="티빙">
                       </div>

                   </div>

                    <div class="swiper-slide"
                         data-name="disney"
                         onclick="showSubscription('disney')">
                        <div class="logo-box">
                             <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Disney%2B_logo.svg/3840px-Disney%2B_logo.svg.png"
                                  alt="디즈니+">
                             </div>
                    </div>

                    <div class="swiper-slide"
                         data-name="laftel"
                         onclick="showSubscription('laftel')">
                        <div class="logo-box">
                             <img src="https://oopy.lazyrockets.com/api/rest/cdn/image/19dda27a-9593-47d3-b5de-e8f30d465142.png"
                                  alt="라프텔">
                             </div>
                    </div>

                    <div class="swiper-slide"
                         data-name="wavve"
                         onclick="showSubscription('wavve')">
                        <div class="logo-box">
                             <img src="/images/wavve.png"
                                  alt="웨이브">
                             </div>
                    </div>

                    <div class="swiper-slide"
                         data-name="watcha"
                         onclick="showSubscription('watcha')">
                        <div class="logo-box">
                            <img src="/images/watcha.png"
                                 alt="왓챠">
                            </div>
                    </div>

                    <div class="swiper-slide"
                        data-name="youtube"
                        onclick="showSubscription('youtube')">
                        <div class="logo-box">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg"
                                 alt="유튜브 프리미엄">
                        </div>
                    </div>

                    <div class="swiper-slide"
                         data-name="netflix"
                         onclick="showSubscription('netflix')">
                        <div class="logo-box">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg"
                                 alt="넷플릭스">
                        </div>
                    </div>

                   <div class="swiper-slide"
                        data-name="tving"
                        onclick="showSubscription('tving')">

                       <div class="logo-box">
                           <img src="/images/tving.png"
                                alt="티빙">
                       </div>

                   </div>

                    <div class="swiper-slide"
                         data-name="disney"
                         onclick="showSubscription('disney')">
                        <div class="logo-box">
                             <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Disney%2B_logo.svg/3840px-Disney%2B_logo.svg.png"
                                  alt="디즈니+">
                             </div>
                    </div>

                    <div class="swiper-slide"
                         data-name="laftel"
                         onclick="showSubscription('laftel')">
                        <div class="logo-box">
                             <img src="https://oopy.lazyrockets.com/api/rest/cdn/image/19dda27a-9593-47d3-b5de-e8f30d465142.png"
                                  alt="라프텔">
                             </div>
                    </div>

                    <div class="swiper-slide"
                         data-name="wavve"
                         onclick="showSubscription('wavve')">
                        <div class="logo-box">
                             <img src="/images/wavve.png"
                                  alt="웨이브">
                             </div>
                    </div>

                    <div class="swiper-slide"
                         data-name="watcha"
                         onclick="showSubscription('watcha')">
                        <div class="logo-box">
                            <img src="/images/watcha.png"
                                 alt="왓챠">
                            </div>
                    </div>




                </div>
            </div>
        </div>
    </div>

    <!-- AI -->
    <div class="column">

        <div class="category-name">AI Tech</div>

        <div class="swiper-container-wrapper">
            <div class="swiper mySwiper">

                <div class="swiper-wrapper">

                    <div class="swiper-slide"
                         data-name="chatgpt"
                         onclick="showSubscription('chatgpt')">

                        <div class="logo-box">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/4/4d/OpenAI_Logo.svg"
                            alt ="챗지피티">
                        </div>

                    </div>

                   <div class="swiper-slide"
                        data-name="gemini"
                        onclick="showSubscription('gemini')">

                       <div class="logo-box">
                           <img src="https://upload.wikimedia.org/wikipedia/commons/8/8a/Google_Gemini_logo.svg"
                           alt ="제미나이">
                       </div>

                   </div>

                   <div class="swiper-slide"
                        data-name="claude"
                        onclick="showSubscription('claude')">

                       <div class="logo-box">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Claude_AI_logo.svg/960px-Claude_AI_logo.svg.png"
                                 alt="클로드">
                            </div>

                   </div>
                    <div class="swiper-slide"
                         data-name="chatgpt"
                         onclick="showSubscription('chatgpt')">

                         <div class="logo-box">
                              <img src="https://upload.wikimedia.org/wikipedia/commons/4/4d/OpenAI_Logo.svg"
                                   alt ="챗지피티">
                         </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="gemini"
                         onclick="showSubscription('gemini')">

                         <div class="logo-box">
                              <img src="https://upload.wikimedia.org/wikipedia/commons/8/8a/Google_Gemini_logo.svg"
                                    alt ="제미나이">
                         </div>

                    </div>

                    <div class="swiper-slide"
                          data-name="claude"
                          onclick="showSubscription('claude')">

                          <div class="logo-box">
                               <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Claude_AI_logo.svg/960px-Claude_AI_logo.svg.png"
                                    alt="클로드">
                          </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="chatgpt"
                         onclick="showSubscription('chatgpt')">

                         <div class="logo-box">
                              <img src="https://upload.wikimedia.org/wikipedia/commons/4/4d/OpenAI_Logo.svg"
                                   alt ="챗지피티">
                         </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="gemini"
                         onclick="showSubscription('gemini')">

                         <div class="logo-box">
                              <img src="https://upload.wikimedia.org/wikipedia/commons/8/8a/Google_Gemini_logo.svg"
                                   alt ="제미나이">
                         </div>

                    </div>

                     <div class="swiper-slide"
                          data-name="claude"
                          onclick="showSubscription('claude')">

                          <div class="logo-box">
                          <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Claude_AI_logo.svg/960px-Claude_AI_logo.svg.png"
                               alt="클로드">
                          </div>

                     </div>

                </div>
            </div>
        </div>
    </div>

    <!-- SOFTWARE -->
    <div class="column">

        <div class="category-name">Software</div>

        <div class="swiper-container-wrapper">
            <div class="swiper mySwiper">

                <div class="swiper-wrapper">

                    <div class="swiper-slide"
                         data-name="capcut"
                         onclick="showSubscription('capcut')">

                        <div class="logo-box">
                             <img src="/images/capcut.png"
                                  alt="캡컷">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="adobe"
                         onclick="showSubscription('adobe')">

                       <div class="logo-box">
                           <img src="/images/adobe.png" alt="어도비">
                       </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="duolingo"
                         onclick="showSubscription('duolingo')">

                        <div class="logo-box">
                             <img src="/images/duolingo.png"
                                  alt="듀오링고">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="millie"
                         onclick="showSubscription('millie')">

                        <div class="logo-box">
                             <img src="/images/mille.png"
                                  alt="밀리의 서재">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="microsoft"
                         onclick="showSubscription('microsoft')">

                        <div class="logo-box">
                             <img src="data:image/png;base64,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"
                                  alt="마이크로소프트 365">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="polaris"
                         onclick="showSubscription('polaris')">

                        <div class="logo-box">
                             <img src="https://shareditassets.s3.ap-northeast-2.amazonaws.com/production/uploads/business/profile_photo/1630/low_Polaris_Office_200.106.png"                                  alt="폴라리스 오피스">
                             </div>

                    </div>
                    <div class="swiper-slide"
                         data-name="capcut"
                         onclick="showSubscription('capcut')">

                        <div class="logo-box">
                             <img src="/images/capcut.png"
                                  alt="캡컷">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="adobe"
                         onclick="showSubscription('adobe')">

                       <div class="logo-box">
                           <img src="/images/adobe.png" alt="어도비">
                       </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="duolingo"
                         onclick="showSubscription('duolingo')">

                        <div class="logo-box">
                             <img src="/images/duolingo.png"
                                  alt="듀오링고">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="millie"
                         onclick="showSubscription('millie')">

                        <div class="logo-box">
                             <img src="/images/mille.png"
                                  alt="밀리의 서재">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="microsoft"
                         onclick="showSubscription('microsoft')">

                        <div class="logo-box">
                             <img src="data:image/png;base64,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"
                                  alt="마이크로소프트 365">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="polaris"
                         onclick="showSubscription('polaris')">

                        <div class="logo-box">
                             <img src="https://shareditassets.s3.ap-northeast-2.amazonaws.com/production/uploads/business/profile_photo/1630/low_Polaris_Office_200.106.png"                                  alt="폴라리스 오피스">
                             </div>

                    </div>
                </div>

            </div>
        </div>
    </div>

</div>
<div class="modal-overlay"
     id="modalOverlay">

    <div class="modal-content">

        <div class="selected-service-preview"
             id="selectedServicePreview">

        </div>

        <div class="subscription-detail"
             id="subscriptionDetail">

            <div class="detail-header">

                <img id="detailLogo"
                     src=""
                     alt="로고">

                <div>

                    <h2 id="detailTitle">
                        서비스를 선택하세요
                    </h2>

                    <p id="detailPrice">
                        가격 정보
                    </p>

                </div>

            </div>


        <div class="detail-description">

            <p id="detailDescription">
                광고 없이 YouTube와 YouTube Music을 이용할 수 있으며,
                백그라운드 재생과 오프라인 저장 기능을 제공합니다.
                다양한 영상 콘텐츠를 더욱 편리하게 감상할 수 있는
                프리미엄 구독 서비스입니다.
            </p>

        </div>

        <div class="month-buttons">

            <button onclick="selectMonth(1, this)">
                <div>1개월</div>
                <div class="month-price">5,490원</div>
            </button>

            <button onclick="selectMonth(3, this)">
                <div>3개월</div>
                <div class="month-price">14,700원</div>
            </button>

            <button onclick="selectMonth(6, this)">
                <div>6개월</div>
                <div class="month-price">27,720원</div>
            </button>

        </div>

        <div class="detail-buttons">

            <button class="back-btn"
                    onclick="closeDetail()">
                이전으로
            </button>

            <button class="buy-btn"
                    onclick="openPaymentModal()">
                결제하기
            </button>

        </div>

        </div>
        <!-- subscription-detail 끝 -->

        </div>
        <!-- modal-content 끝 -->

        </div>
        <!-- modal-overlay 끝 -->

        <div id="paymentModal" class="payment-modal">

            <div class="payment-box">

                <h2>결제 확인</h2>

                <hr>

                <div class="payment-info">

                    <div class="payment-row">
                        <span class="label">서비스</span>
                        <span id="payService">-</span>
                    </div>

                    <div class="payment-row">
                        <span class="label">구독기간</span>
                        <span id="payMonth">-</span>
                    </div>

                    <div class="payment-row">
                        <span class="label">결제금액</span>
                        <span id="payPrice">-</span>
                    </div>

                    <div class="payment-row">
                        <span class="label">은행</span>
                        <span>마이페이지 연동 예정</span>
                    </div>

                    <div class="payment-row">
                        <span class="label">계좌번호</span>
                        <span>마이페이지 연동 예정</span>
                    </div>

                </div>

                <div class="payment-buttons">

                    <button onclick="closePaymentModal()">
                        취소
                    </button>

                    <button onclick="confirmPayment()">
                        결제하기
                    </button>

                </div>

            </div>

        </div>

        <div class="fixed-icons">

            <div class="icon-btn">
                <img src="https://cdn-icons-png.flaticon.com/512/2040/2040946.png">
            </div>

            <div class="icon-btn">
                <img src="https://cdn-icons-png.flaticon.com/512/1380/1380370.png">
            </div>

        </div>


<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<script>

   document.querySelectorAll('.mySwiper').forEach(el => {

       const category =
           el.closest('.column')
             .querySelector('.category-name')
             .innerText.trim();

       let swiperOption = {

           direction: "vertical",

           slidesPerView: 5,

           centeredSlides: true,

           centeredSlidesBounds: true,

           spaceBetween: -120,

           speed: 500,

           mousewheel: false,

           slideToClickedSlide: true
       };

       // AI 전용
      if(category === 'AI Tech') {

          swiperOption.loop = true;



          swiperOption.speed = 1000;
      }

       // OTT
       else if(category === 'Video') {

           swiperOption.loop = true;

           swiperOption.speed = 1000;
       }

       // Software
       else {

           swiperOption.loop = true;

           swiperOption.speed = 1000;
       }

       const swiper = new Swiper(el, swiperOption);

       let isLocked = false;

       el.addEventListener('wheel', (e) => {

           e.preventDefault();

           if (isLocked || swiper.animating) return;

           if (Math.abs(e.deltaY) < 15) return;

           isLocked = true;

           if (e.deltaY > 0) {
               swiper.slideNext();
           } else {
               swiper.slidePrev();
           }

           setTimeout(() => {
               isLocked = false;
           }, 350);

       }, { passive: false });

       swiper.on('click', function () {

           if (
               this.clickedSlide &&
               this.clickedSlide.classList.contains('swiper-slide-active')
           ) {

               const name =
                   this.clickedSlide.getAttribute('data-name');

               if(name) {

                   document
                       .getElementById('mainContainer')
                       .classList.add('blur-background');

                   document
                       .querySelectorAll('.swiper-slide')
                       .forEach(slide => {

                           slide.classList.remove('selected-card');
                       });

                   this.clickedSlide
                       .classList.add('selected-card');

                   showSubscription(name);
               }
           }
       });
   });

let currentPrices = {
    month1: 0,
    month3: 0,
    month6: 0
};
let selectedMonth = 1;
let selectedPrice = 0;

function showSubscription(name) {

      document
            .querySelectorAll('.month-buttons button')
            .forEach(button => {
                button.classList.remove('active');
            });

        selectedMonth = 1;
        selectedPrice = 0;

        document.getElementById('modalOverlay')
            .style.display = 'flex';

        const preview =
            document.getElementById('selectedServicePreview');
        document.querySelector('.month-buttons button').click();

    if(name === 'youtube') {

        currentPrices = {
            month1: 5490,
            month3: 14700,
            month6: 27720
        };

        updatePriceButtons();

            preview.innerHTML = `
                <img src="https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg"
                     alt="유튜브">
            `;

        document.getElementById('detailLogo').src =
        'https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg';

        document.getElementById('detailTitle').innerText =
        '유튜브 프리미엄';

        document.getElementById('detailPrice').innerText =
        '6,000원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '광고 없이 YouTube와 YouTube Music을 이용할 수 있으며, 백그라운드 재생과 오프라인 저장 기능을 제공합니다. 다양한 영상 콘텐츠를 더욱 편리하게 감상할 수 있는 프리미엄 구독 서비스입니다.';
    }
    else if(name === 'netflix') {
        currentPrices = {
            month1: 5980,
            month3: 16800,
            month6: 31920
        };

        updatePriceButtons();

        preview.innerHTML = `
            <img src="https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg"
                 alt="넷플릭스">
        `;

        document.getElementById('detailLogo').src =
        'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg';

        document.getElementById('detailTitle').innerText =
        '넷플릭스';

        document.getElementById('detailPrice').innerText =
        '5,980원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '영화, 드라마, 예능, 다큐멘터리, 애니메이션 등 다양한 콘텐츠를 광고 없이 시청할 수 있으며, 오리지널 시리즈와 최신 작품을 언제 어디서나 감상할 수 있는 글로벌 OTT 스트리밍 서비스입니다.';
    }
    else if(name === 'tving') {

        currentPrices = {
            month1: 7500,
            month3: 21000,
            month6: 40320
        };

        updatePriceButtons();

        preview.innerHTML = `
            <img src="/images/tving.png"
                 alt="티빙">
        `;

        document.getElementById('detailLogo').src =
        '/images/tving.png';

        document.getElementById('detailTitle').innerText =
        '티빙';

        document.getElementById('detailPrice').innerText =
        '7,500원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '국내 드라마, 예능, 영화, 스포츠 중계 등 다양한 콘텐츠를 제공하며, CJ ENM과 JTBC의 인기 프로그램을 실시간 및 다시보기로 즐길 수 있는 OTT 서비스입니다.';
    }
    else if(name === 'disney') {
    currentPrices = {
        month1: 3330,
        month3: 9240,
        month6: 17640
    };

    updatePriceButtons();

      preview.innerHTML = `
          <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Disney%2B_logo.svg/3840px-Disney%2B_logo.svg.png"
               alt="디즈니+">
      `;

      document.getElementById('detailLogo').src =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Disney%2B_logo.svg/3840px-Disney%2B_logo.svg.png';

        document.getElementById('detailTitle').innerText =
        '디즈니+';

        document.getElementById('detailPrice').innerText =
        '3,330원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '디즈니, 마블, 픽사, 스타워즈, 내셔널지오그래픽의 다양한 콘텐츠를 제공하며, 독점 오리지널 시리즈와 영화를 감상할 수 있는 글로벌 스트리밍 서비스입니다.';
    }
    else if(name === 'laftel') {
    currentPrices = {
        month1: 2500,
        month3: 7500,
        month6: 15000
    };

    updatePriceButtons();

        preview.innerHTML = `
                 <img src="https://oopy.lazyrockets.com/api/rest/cdn/image/19dda27a-9593-47d3-b5de-e8f30d465142.png"
                      alt="라프텔">
             `;


       document.getElementById('detailLogo').src = 'https://oopy.lazyrockets.com/api/rest/cdn/image/19dda27a-9593-47d3-b5de-e8f30d465142.png';

        document.getElementById('detailTitle').innerText =
        '라프텔';

        document.getElementById('detailPrice').innerText =
        '2,500원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '국내 최대 애니메이션 스트리밍 플랫폼으로, 다양한 인기 애니메이션과 독점 작품을 고화질로 감상할 수 있으며 편리한 시청 환경을 제공하는 구독 서비스입니다.';
    }
    else if(name === 'wavve') {
    currentPrices = {
        month1: 5360,
        month3: 14700,
        month6: 27720
    };

    updatePriceButtons();

    preview.innerHTML = `
        <img src="/images/wavve.png"
                              alt="웨이브">
        `;

        document.getElementById('detailLogo').src = '/images/wavve.png';

        document.getElementById('detailTitle').innerText =
        '웨이브';

        document.getElementById('detailPrice').innerText =
        '5,360원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '지상파 방송 콘텐츠와 드라마, 예능, 영화 등 다양한 국내 콘텐츠를 제공하며, 실시간 방송과 다시보기를 지원하는 온라인 스트리밍 서비스입니다.';
    }
    else if(name === 'watcha') {
    currentPrices = {
        month1: 3715,
        month3: 11145,
        month6: 22290
    };

    updatePriceButtons();
    preview.innerHTML = `
        <img src="/images/watcha.png"
             alt="왓챠">
        `;

    document.getElementById('detailLogo').src = '/images/watcha.png'
        document.getElementById('detailTitle').innerText =
        '왓챠';

        document.getElementById('detailPrice').innerText =
        '3,715원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '영화와 드라마를 중심으로 다양한 콘텐츠를 제공하며, 개인 취향에 맞는 작품을 추천받을 수 있는 구독형 스트리밍 서비스입니다.';
    }
    else if(name === 'claude') {
    currentPrices = {
        month1: 7690,
        month3: 21420,
        month6: 40320
    };

    updatePriceButtons();
    preview.innerHTML = `
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Claude_AI_logo.svg/960px-Claude_AI_logo.svg.png"
                              alt="클로드 Pro">
        `;

        document.getElementById('detailLogo').src = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Claude_AI_logo.svg/960px-Claude_AI_logo.svg.png';

        document.getElementById('detailTitle').innerText =
        '클로드 Pro';

        document.getElementById('detailPrice').innerText =
        '7,690원 / 1개월';

        document.getElementById('detailDescription').innerText =
        'Anthropic의 생성형 AI 서비스로, 긴 문서 분석과 자연스러운 대화에 강점을 가지고 있으며 업무, 학습, 문서 작성 등을 효율적으로 지원하는 AI 구독 서비스입니다.';
    }
    else if(name === 'chatgpt') {
    currentPrices = {
        month1: 5280,
        month3: 21294,
        month6: 45276
    };

    updatePriceButtons();
    preview.innerHTML = `
       <img src="https://upload.wikimedia.org/wikipedia/commons/4/4d/OpenAI_Logo.svg"
                             alt="챗지피티">
       `;

       document.getElementById('detailLogo').src = 'https://upload.wikimedia.org/wikipedia/commons/4/4d/OpenAI_Logo.svg';

        document.getElementById('detailTitle').innerText =
        'ChatGPT Plus';

        document.getElementById('detailPrice').innerText =
        '5,280원 / 1개월';

        document.getElementById('detailDescription').innerText =
        'OpenAI의 생성형 AI 서비스로, 문서 작성, 번역, 프로그래밍, 학습, 아이디어 정리 등 다양한 작업을 지원하며 GPT 모델을 활용한 대화형 인공지능 서비스입니다.';
    }
    else if(name === 'gemini') {
    currentPrices = {
        month1: 5140,
        month3: 14280,
        month6: 26880
    };

    updatePriceButtons();
    preview.innerHTML = `
        <img src="https://upload.wikimedia.org/wikipedia/commons/8/8a/Google_Gemini_logo.svg"
                              alt="제미나이">
        `;

        document.getElementById('detailLogo').src = 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Google_Gemini_logo.svg';

        document.getElementById('detailTitle').innerText =
        'Gemini Advanced';

        document.getElementById('detailPrice').innerText =
        '5,140원 / 1개월';

        document.getElementById('detailDescription').innerText =
        'Google의 생성형 AI 서비스로, 문서 작성, 검색, 요약, 코딩 지원, 이미지 분석 등 다양한 작업을 수행할 수 있으며 Google 서비스와 연동하여 생산성을 높여주는 AI 구독 서비스입니다.';
    }
    else if(name === 'capcut') {
    currentPrices = {
        month1: 7000,
        month3: 19500,
        month6: 36000
    };

    updatePriceButtons();
    preview.innerHTML = `
            <img src="/images/capcut.png"
                              alt="캡컷">
        `;

        document.getElementById('detailLogo').src = '/images/capcut.png';

        document.getElementById('detailTitle').innerText =
        'CapCut Pro';

        document.getElementById('detailPrice').innerText =
        '7,000원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '영상 편집, 자막 생성, AI 효과, 템플릿 기능 등을 제공하는 영상 제작 플랫폼으로 크리에이터와 일반 사용자 모두 쉽게 고품질 영상을 제작할 수 있는 서비스입니다.';
    }
    else if(name === 'adobe') {
    currentPrices = {
        month1: 14000,
        month3: 39000,
        month6: 72000
    };

    updatePriceButtons();
    preview.innerHTML = `
        <img src="/images/adobe.png"
                              alt="어도비">
        `;

        document.getElementById('detailLogo').src = '/images/adobe.png';

        document.getElementById('detailTitle').innerText =
        'Adobe Creative Cloud';

        document.getElementById('detailPrice').innerText =
        '14,000원 / 1개월';

        document.getElementById('detailDescription').innerText =
        'Photoshop, Illustrator, Premiere Pro 등 다양한 디자인 및 영상 편집 프로그램을 제공하며 전문가와 크리에이터를 위한 대표적인 구독형 소프트웨어 서비스입니다.';
    }
    else if(name === 'duolingo') {
    currentPrices = {
        month1: 2500,
        month3: 7500,
        month6: 15000
    };

    updatePriceButtons();
    preview.innerHTML = `
       <img src="/images/duolingo.png"
                             alt="듀오링고">
       `;

       document.getElementById('detailLogo').src = '/images/duolingo.png';

        document.getElementById('detailTitle').innerText =
        'Duolingo Super';

        document.getElementById('detailPrice').innerText =
        '2,500원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '영어를 포함한 다양한 외국어를 게임처럼 재미있게 학습할 수 있는 언어 교육 플랫폼으로 광고 제거와 학습 기능이 강화된 프리미엄 서비스를 제공합니다.';
    }
    else if(name === 'millie') {
    currentPrices = {
        month1: 4460,
        month3: 13380,
        month6: 26760
    };

    updatePriceButtons();
    preview.innerHTML = `
       <img src="/images/mille.png"
            alt="밀리의 서재">
       `;

       document.getElementById('detailLogo').src = '/images/mille.png'
        document.getElementById('detailTitle').innerText =
        '밀리의 서재';

        document.getElementById('detailPrice').innerText =
        '4,460원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '전자책, 오디오북, 챗북 등 다양한 독서 콘텐츠를 제공하며 언제 어디서나 독서를 즐길 수 있는 국내 대표 독서 구독 서비스입니다.';
    }
    else if(name === 'microsoft') {
    currentPrices = {
        month1: 2000,
        month3: 6000,
        month6: 12000
    };

    updatePriceButtons();
    preview.innerHTML = `
        <img src="/images/microsoft.png"
             alt="마이크로소프트 365">
        `;

        document.getElementById('detailLogo').src = '/images/microsoft.png'
        document.getElementById('detailTitle').innerText =
        'Microsoft 365';

        document.getElementById('detailPrice').innerText =
        '2,000원 / 1개월';

        document.getElementById('detailDescription').innerText =
        'Word, Excel, PowerPoint, OneDrive 등 다양한 오피스 프로그램과 클라우드 서비스를 제공하는 생산성 향상 소프트웨어 구독 서비스입니다.';
    }
    else if(name === 'polaris') {
    currentPrices = {
        month1: 3400,
        month3: 10200,
        month6: 20400
    };

    updatePriceButtons();
    preview.innerHTML = `
        <img src="https://shareditassets.s3.ap-northeast-2.amazonaws.com/production/uploads/business/profile_photo/1630/low_Polaris_Office_200.106.png"
                              alt="폴라리스 오피스">
        `;

        document.getElementById('detailLogo').src = 'https://shareditassets.s3.ap-northeast-2.amazonaws.com/production/uploads/business/profile_photo/1630/low_Polaris_Office_200.106.png';

        document.getElementById('detailTitle').innerText =
        '폴라리스 오피스';

        document.getElementById('detailPrice').innerText =
        '3,400원 / 1개월';

        document.getElementById('detailDescription').innerText =
        '문서 작성, 스프레드시트, 프레젠테이션 기능을 제공하는 오피스 소프트웨어로 다양한 기기에서 문서를 편리하게 관리할 수 있는 생산성 서비스입니다.';
    }
}

function updatePriceButtons() {

    const prices =
        document.querySelectorAll('.month-price');

    prices[0].innerText =
        currentPrices.month1.toLocaleString() + '원';

    prices[1].innerText =
        currentPrices.month3.toLocaleString() + '원';

    prices[2].innerText =
        currentPrices.month6.toLocaleString() + '원';
}

    function closeDetail() {

        document.getElementById('modalOverlay')
                .style.display = 'none';

        document
            .getElementById('mainContainer')
            .classList.remove('blur-background');

        document
            .querySelectorAll('.swiper-slide')
            .forEach(slide => {

                slide.classList.remove('selected-card');
            });
    }

    function selectMonth(month,btn) {

        document
            .querySelectorAll('.month-buttons button')
            .forEach(button => {
                button.classList.remove('active');
            });

        btn.classList.add('active');


        let price = 0;

        if(month === 1) {
            price = currentPrices.month1;
        }
        else if(month === 3) {
            price = currentPrices.month3;
        }
        else if(month === 6) {
            price = currentPrices.month6;
        }

        selectedMonth = month;
        selectedPrice = price;

        document.getElementById('detailPrice').innerText =
            price.toLocaleString() + '원 / ' + month + '개월';
    }

    function openPaymentModal() {

        const serviceName =
            document.getElementById('detailTitle').innerText;

        document.getElementById('payService').innerText =
            serviceName;

        document.getElementById('payMonth').innerText =
            selectedMonth + '개월';

        document.getElementById('payPrice').innerText =
            selectedPrice.toLocaleString() + '원';

        document.getElementById('modalOverlay').style.display =
            'none';

        document.getElementById('paymentModal').style.display =
            'flex';
    }
    function closePaymentModal() {

        document.getElementById('paymentModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'flex';
    }

    function confirmPayment() {

        location.href = "/subscription/paymentSuccess";
    }


</script>

</body>
</html>