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

    <style>
        :root {
            --header-bg: #1e293b;
            --bg-white: #ffffff;
            --accent-blue: #3b82f6;
            --border-line: #e2e8f0;
            --text-gray: #64748b;
        }

        * {
            box-sizing: border-box;
        }

        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Pretendard', sans-serif;
            background-color: var(--bg-white);
           overflow-x: hidden;
        }

        /* 헤더 */
        header {
            background-color: var(--header-bg);
            color: white;
            height: 60px;

            display: flex;
            justify-content: space-between;
            align-items: center;

            padding: 0 20px;

            position: sticky;
            top: 0;
            z-index: 1000;
        }

        header .menu-icon {
            font-size: 24px;
            cursor: pointer;
        }

        header h1 {
            font-size: 18px;
            font-weight: 700;
            margin: 0;
            flex-grow: 1;
            text-align: center;
        }

        header .auth-links {
            font-size: 12px;
            opacity: 0.8;
        }

        header .auth-links span {
            cursor: pointer;
            margin-left: 10px;
        }

        .main-container {
            display: flex;
            height: calc(100vh - 60px);
            width: 100%;
            background-color: transparent;
        }

        .column {
            flex: 1;
            height: 100%;

            display: flex;
            flex-direction: column;

            border-right: 1px solid var(--border-line);
            position: relative;
        }

        .column:last-child {
            border-right: none;
        }

        /* 카테고리 제목 */
        .category-name {
            position: absolute;
            top: 40px;
            left: 0;

            width: 100%;

            text-align: center;

            z-index: 10;

            font-size: 36px;
            font-weight: 800;
            color: var(--header-bg);
            letter-spacing: -0.5px;
        }

        .swiper-container-wrapper {
            flex: 1;
            width: 100%;

            margin-top: 80px;

            overflow: hidden;

            -webkit-mask-image: linear-gradient(
                    to bottom,
                    transparent,
                    black 25%,
                    black 75%,
                    transparent
            );

            mask-image: linear-gradient(
                    to bottom,
                    transparent,
                    black 25%,
                    black 75%,
                    transparent
            );
        }

        .swiper {
            width: 100%;
            height: 100% !important;
        }

        .swiper-slide {

            display: flex;
            align-items: center;
            justify-content: center;

            height: 33.33% !important;

            transition: all 0.5s ease;

            filter: grayscale(1) opacity(0.2);

            transform: scale(0.7);

            opacity: 0.4;
        }

        .swiper-slide-active {

            filter: grayscale(0) opacity(1);

            opacity: 1;
        }

        .swiper-slide-active .logo-box {

            transform: scale(1.4);

            transition: all 0.5s ease;
        }

        .selected-card {

            transform: translateX(-120px) scale(1.1);

            opacity: 1 !important;

            transition: all 0.5s ease;

            z-index: 50;
        }

        .logo-box {
            width: 100%;
            height: 100%;

            display: flex;
            justify-content: center;
            align-items: center;

            cursor: pointer;
        }

        .logo-box img {
            max-width: 70%;
            max-height: 70%;
            object-fit: contain;
        }

        /* 우측 하단 아이콘 */
        .fixed-icons {
            position: fixed;
            bottom: 30px;
            right: 30px;

            display: flex;
            flex-direction: column;
            gap: 15px;

            z-index: 2000;
        }

        .icon-btn {
            width: 50px;
            height: 50px;

            background: white;
            border-radius: 50%;

            display: flex;
            justify-content: center;
            align-items: center;

            box-shadow: 0 4px 15px rgba(0,0,0,0.1);

            cursor: pointer;
        }

        .icon-btn img {
            width: 28px;
            height: 28px;
        }
    </style>
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
                           <img src="https://www.brandb.net/_next/image?url=https%3A%2F%2Fapi.brandb.net%2Fapi%2Fv2%2Fcommon%2Fimage%3FfileId%3D2196&w=1920&q=75"
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
                             <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSieZNJoMfQQhYK4eWBI1IcKSlVXVzYNjfTPQ&s"
                                  alt="웨이브">
                             </div>
                    </div>

                    <div class="swiper-slide"
                         data-name="watcha"
                         onclick="showSubscription('watcha')">
                        <div class="logo-box">
                            <img src="data:image/png;base64,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"
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
                             <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1qbsIazYTPIuZToJRVXA-l77ASMPHFv7wwg&s"
                                  alt="캡컷">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="adobe"
                         onclick="showSubscription('adobe')">

                       <div class="logo-box">
                           <img src="/images/Adobe.png" alt="어도비">
                       </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="duolingo"
                         onclick="showSubscription('duolingo')">

                        <div class="logo-box">
                             <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Duolingo_logo_%282019%29.svg/1280px-Duolingo_logo_%282019%29.svg.png"
                                  alt="듀오링고">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="millie"
                         onclick="showSubscription('millie')">

                        <div class="logo-box">
                             <img src="data:image/png;base64,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"
                                  alt="밀리의 서재">
                             </div>

                    </div>

                    <div class="swiper-slide"
                         data-name="microsoft"
                         onclick="showSubscription('microsoft')">

                        <div class="logo-box">
                             <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAioAAABbCAMAAABqD17MAAAArlBMVEX///9zc3P/uQDyUCJ/ugAApO9qampubm5ra2tnZ2f/tQDxRADU1NTw8PB4eHjl5eX//PKeylT5/PLP47XK6fv/7soAn+653fn1fmLySxjzYjz6xbzg7ch2tgAAp/ClpaXGxsZ/f38lrfCUlJS2tratra319fXe3t6MjIyfn5+Xl5ezs7PX19e/v79+fn5dXV32inH0d1n70cnn8dSZx0jzWS3xNgD96OTy+Onr9v0LrwbSAAAP10lEQVR4nO2d6aKkthGFm8SWUAy0ncRJbMcGzNLQ22Rf3v/Fwqaq0gbq8e1p7kTnjz2NEFo+pFKpxD0cgoJ89Zc/eeqvfxtS//0f3/jqt6+uWdAb6/vvPPXVD0PqP//4had+DKh8bvr+u1/76UFUvgiofG4KqAR5KqAS5KmASpCnAipBngqoBHkqoBLkqYBKkKcCKkGeCqgEeSqgEuSpgEqQpwIqL1bSdFkUReX51r66KBsKqLxS7SVmnEej+Ifjq0uzoXeLSnpMn/yE5yvhcQQSAZWnKLkLJqLiqc94uhoRRb8MlWNxOZcZZ9H9fEm2J7C0aKp7xHh27/LaI72qF6CSCI5iG2NDHmNakchf67mRRfNgbXcllZTHUUn6SMTL9BUNLSmqZC15W5c0+ZC+I22ffhAOfSiWJK9AhZEGim/r7UHTMtkUV9nIYrVx9q1CJeVRVOphdFAziLgo3Xk0cawlV1rvKPSr0EPFkuTVqETZaoPcaP0AlQ4aqfRq1j2qJa0wDpkPonKxd62o7cmLWOdqbM8rJjgx8/reUBGntRYplapJVJAf7t22e1MOfcd5X9dNqayANk322tL1Uxv1ttS9FSyKSvIOUOHWui06KVUEVDCD94sK1IwtBheu6K55vNYok1yoRCw30ralPTFFpTCmp/2hErEVS7xX6vg5TUDQCLFqmqfFeXS1mP2taUGF85gxMFYnGfZbm5HL9AaKyu09oAJFMdVqUMlGSMCsdd+7c+H8Q389lWwyKvxQ4YxVdXG9FnUlKCxa0jtei0V1GW5I6jwTsYLKBZdGmqCNX4/KyshQq6gDKnKdKTbH6d1KDoz8Qn8tlqbxQYWzinQ1aSpWWJ80gJKRK23RfSDjz4Iur3JdvTQmd4CK2/RX0xFUDkU2rPhpzd+b7madDmgxeKAiOrXZjtBMvFMSQmsLhcpBJ5LDMtWzlUXGDlDhLkfaVUuoNOs7d+xnsk5Kh/ujcin0X9AzwsivKfy6vtRcxp61FfsOUFGqRlVphjt7xw43XRIV8ZGoWATmD80Tpp+18eIAXgmx8v69EhX7IAxKl3RZtp7uXeoJqIAXjVBx8l0AyGQry9EXosJv0rTrrOkWo5zXZUDFSxZUwHreWgAs94qVJC9EhaUwXFiHvchIFlB5ME+wX9acV5Pk67uS5IWoiFSu8Lhum5NkvDo8iMq41V5mWXbvmsI99aZF3Vxu2gSeJnXflWXZVU2xYuCdbn03PSDXM8CMLnNGZ0dG0K1KCX8ZKpExi4C3ZGsLXnqw1nbkXopKC+a5Jdkydg58mKhIW818CdIL7sxzHot7vfSFXArwqTWu3ZiKxx/oPnx9F4zP94638tzaye2Fixh9paIyaDk22ZQ7ZNSQjK7OLVybhhfFX2Zryh+2Qj3ALrSbArNeicrxcF76nPoNF8HYeXgAlfQstFVTFC/vLawaR1RymQxf6rRnum+b676LUbW+98+0IfFoloGLM27wOPflbHoEFZkz2iWyDR3GIC00237ca1GRr5iliM3y4l4eQKU2OglpoKhUsXbxcLjZbh36WBu5287oaa7u+zeOjGRczvNQkb4FbCa5sbMVFASrp1Xr97Wo4JRtmF2y3qk/KpW1F0xUGqZfdNw6trLyQio7b7IMFJW2c227yU2Ip6ECG2N3bBDZiJuhMNIwXLNpXoyKk/vFwJuGTk9UHFvtOip3GvC1XHTcCiWQ6izpKCo2lKTiudefhUoiGSU7yzIX8HGeitvtlljAkc3tiIya9GJUWvNVmFUulRzr7YeK1o2cq+YIoFJSJ/B8Ub2Vc/Wf2Fu4nxINBm08G7e0eTMtI6VE8bSseQ4qKQQvkXgVaasuG7JFJ4YyDxJmFO7yyvK+bkbVxclcXb8YFYhI0XYowCCbOkC2whoqDRn5ueDduT+X00pFRwX6kcuL9NZhzdRV3bhFD2I3/bFRnDVFktz6bDBMCCpnZIMzUVZVF1HLZXrfrx+m7sKEMRHXfxWbBunwuh1vFdja7IwXTtTOrelBEs60rVY9BmFY2ZUXbfR5NSrS86wZVAtB89zpgwqJl+NMLk7bpBPcikrMz3l+jth4kdzKyuXIQ3qLsI/lUhN2JBjQccwZbtiSwGrWLWVNazK2jMVNi0myTrwuiOQ2Dq/kL2uuJLFQxRAxxQwv0G3VlsbGW0fHjdw2s4pOeX//+ZWn/jWj4i1PVA6lrCRN0i6VnLvZB5UMasjOtA1O3QcLKryYrx6rlMbvKlFWOTSuxBg6kjrI2hx6hzBBerg9w+sc47r6LVxwuoeGi1LpWxlUORiCkYkCj8iocbbaWFzQcvzgrX8Pqf/zO2+5a6iiAoZtQZLciFHrhUoB/WpEZdQWVGj/4Ea3tvl6wTzn9J1Mp3qBJJkYc8hVj1ePrMBvb+HY16fUs+adkmjHic0cV4ppTzDcWr70JLWKCoTf02C4u8KGBypQN90hBiKoxEpPlgCEPtiD/buYI/AMuzc/c16HjsD34Qmo1PpjYajoiCVCUUE3fhk5xLNXsqKhItkni/8TempHbaMCywq3XxJRURfm8Lu52MDQ3kwph92jBR57s59heY7Fe8aowkRX0Ovawk5kVd9X1NDGEPD53eQaS+st+gmkoQKLHbTIzlz5ZRsViOx3b3aQUUX5HaYNSwAYBgvNa2p7DosaSGy+hzA+wQz0BFQmWiIyNCqoiH550qnC+8BSigXLyq6q+nNVxkzZu4AF4O+99d8h9dffestdQw2VQ6l3gHS2yIpsowJN5XZM4+iheiShFy3R4BAsFE9PBnL43eLFktWwuULQPyYnibdAZV52awOBwNVySX8nsxNaZ9AWyhuWJj09jBgv6P/0B1/9cUj97W+89bWzhjoqsn2ABGm5y6FvExXAwLLtCPUXRi6ToNVsRo56kUR6st6AReZvO6zSGhffApV61K1uzuOOOPYszBgEFdXQhj0AZ3xKmxPTbnEN/PylpxZUfuUrf1Rkx3MNDTiksIkKvrTudgVU1OUpeDStlMkph5+Vx0aT00FFDuwRayQzuFEa7Ye3CW1qkzPCAsMaoiIca6OV2Owr8djNv+wBFVnwpRMhoFLesIlKvTKJSOEEpJgSGCdms3LABpopvlE/FmcZNW/RP2d7uhG4+OZRcEfc8ZRxtGCrGHMivCAre87omVzKuAdUwLC90BqiTbGJSq53hEVKvIpZGHtI4UVjUHM/xBxbGg79WgPJJHPQaU8ImLzo0wqYYeaICeiuPAjs9GXW3AMquLQY/yH7FC9votJ7VNyBCvRwbLvppg9XpRZjwDJZSlhJ6Rufagl1++stY2thWlmmblwXGklrvTwWtdDKc2l2gYr0tU70S5hxMtlEBd6RlXCLj0PF8A/m+gpVOu7MpFSfBBW0wmfTCoYFc6CDwXTt+wCVOhTuApUDraL0yBVw1R+Vtx5V9Alo0Omun6OdS+U5qsil7FNQ0diAuplDx5EpKe3STMB9oCLrKFoYYUjXbaJy1jvCoo+yVRrbOJ2Uakzk7HLDHSDb0ysd5qeggk7rVvmnBRV7a6gq1IFyH6hIi3wwyKVRSxrL21bxWgGpjYNH8mxrXOhh1V4+KZHWc1FxwW5jrpRpZfjCU1DRHAKpe+gAVNYmoF2iAlPI3TRqH1ks+/hV1HbDZWNhucm565Pm1Ok1wmE7BooCF5yswqdAxQyYBEF0/9oOz22Ptgoxs5b/0ipsu+BUB/x6M2qvmGxOW++s+edSDLieygUOWVt8KnAEdX4KKid1AoLR1hwxbz4POquz5k5QOSizv/aO+zv2V14SFyroKjHvua1OKrglNMEhD+vb7NrGeMhTUCk0ewmyM1aGkoLVYx/QGXOivaByUVlRhszt7cIS7nNuArlQgc8daR87GiV730GgfOjcsegsN8sA5QWbZwOVj/scVadZ4c7Tm21sfbwqfFHmKXUvqKihr+pbtY0Kgua06F2okKMe+i3Fqh1D1kdaKL5hKiKOQNEGKhtBIvYOhnkY5kCYQrRh5aI2oDV6CTxwspX3gor63R310jYqCJrZyInlICpVCbdqOyUpBkDOP+hGSK12BETBxdr0AU4M8mw7KsmqlwfVdJbeTTEYW2aKn1dRRjoMtVpKbjPx4GyU5Gw3qCjnY9T30iNgknwwuFR3jns9DFtHBXfkY8Utgx9Xk7vwXGtSSfcy6KBnRf127AnKZnErOhph5bObo2rGLjosWF7SfBiqSdZlR2Rqbpu7eTj7mOmJ9oMK/Uag1lAeqJDPlvK4AViOeWwc7jCmKDxaSFkgx8PkzJRxVpKSXfVlDalACW9xi8deOXkD7KiQqM6la+1LumE843FPR4oUDxjQIQS3hzHomISLLyZRGXGmxFTQ3MBu2g8q5HOaapyA1+EO+scNuLiPJ7qKfIoj3USFHkxlcX9LkqSuyJkxaPmxHLGoimPbtmmCHyOXBNDvYTCeDxkVdUecdcziK3K+L6K7DTVwHBmbpr4xlvaSnI7HU6I8RvFZ53haIM6L6ylpuNnO5fj/MeR2UdzR0Mb7QQXNdd3+9zpdiCcopgt4Vm8TlcNNGHeSpsLXMVsSsPFvn6ALDj+z1rC1jJTPsTlQIZ//5tPt9oOoYCVNhVFjYblawYzmyBiNhIR3oCS5qUlo8NN+UMGzCHpolueZZcc3CLZR0f8yjyLy9w0yawJqSJ8dZZjKoURkOlA5aSXZQMVWHO0QUupMCt/xOJQrpcZ5aUeoQDPpPizPLyGc7QfHPVBx/cmU8W7LXpQi9aCM/U9kTBmp6ycHKsYh/UdRie+GuWuc11ieXECS0pWbcjZqR6hIj5fhQfT9voq9w31QGUwda3ty66ShdI12/M7+SZ9h7NfsUxcq2il8ByoX+1sxlNfiu0szy1jHORm6XZ/6YMrJhD2hspjmsf5eeH+16ViaHRUv2a2jcmjNz3Ip3+WanmpJYbjM086WUe+qk9EI6iDgQMVW0cg4jw4yviSlHkY+XK3Z0XDQUa9AZfkzecZfi23nC8aLweVf0QNU4A/rGXl3IqZ2nChldeGP87nOMxx7zrCb+PAP/bOBpzxSch+WS7bY7dOZ2pmci6gxk0GdDMcr/Z4dF67vq5yau6BG8/h1wt4OymH6YAOJ6Gex8UHE45RdRLMr9cH9Bai0x0VmjSYZjkiZHq8cnVkc0iK/D2b8oLjs6cdIV+6Rul46Pt3Kou5i3U06Fvl4+m7MvWuc29ht0kBGlXGUeLM0x7pcKtC4zzXNH13N5qewsrc/hhQpl5nmjo+PQ9XGNJbPuL4AlU+gdtAT7/XL/ZcU4oGbH3iKR9KV536eqAQ9QQGVIE8FVII8FVAJ8lRAJchTAZUgTwVUgjwVUAnyVEAlyFMBlSBPBVSCPBVQCfJUQCXIUwGVIE89C5WV79YGvU/9/JOnvpxQ8R5UwqgSFPR/qf8BWpXZ21W0qxAAAAAASUVORK5CYII="
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

            <button onclick="selectMonth(1)">
                <div>1개월</div>
                <div class="month-price">5,490원</div>
            </button>

            <button onclick="selectMonth(3)">
                <div>3개월</div>
                <div class="month-price">14,700원</div>
            </button>

            <button onclick="selectMonth(6)">
                <div>6개월</div>
                <div class="month-price">27,720원</div>
            </button>

        </div>

        <div class="detail-buttons">

            <button class="back-btn"
                    onclick="closeDetail()">
                이전으로
            </button>

            <button class="buy-btn">
                결제하기
            </button>

        </div>

        </div>
        <!-- subscription-detail 끝 -->

        </div>
        <!-- modal-content 끝 -->

        </div>
        <!-- modal-overlay 끝 -->

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

           slidesPerView: 3,

           centeredSlides: true,

           speed: 1000,

           mousewheel: false,

           slideToClickedSlide: true
       };

       // AI 전용
      if(category === 'AI Tech') {

          swiperOption.loop = true;



          swiperOption.speed = 1200;
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
           }, 700);

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

function showSubscription(name) {

    document.getElementById('modalOverlay')
        .style.display = 'flex';

    const preview =
        document.getElementById('selectedServicePreview');

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
            <img src="https://www.brandb.net/_next/image?url=https%3A%2F%2Fapi.brandb.net%2Fapi%2Fv2%2Fcommon%2Fimage%3FfileId%3D2196&w=1920&q=75"
                 alt="티빙">
        `;

        document.getElementById('detailLogo').src =
        'https://www.brandb.net/_next/image?url=https%3A%2F%2Fapi.brandb.net%2Fapi%2Fv2%2Fcommon%2Fimage%3FfileId%3D2196&w=1920&q=75';

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
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Claude_AI_logo.svg/960px-Claude_AI_logo.svg.png"
                              alt="웨이브">
        `;

        document.getElementById('detailLogo').src = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Claude_AI_logo.svg/960px-Claude_AI_logo.svg.png';

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
        <img src="data:image/png;base64,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"
                              alt="왓챠">
        `;

    document.getElementById('detailLogo').src = 'data:image/png;base64,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';

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
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1qbsIazYTPIuZToJRVXA-l77ASMPHFv7wwg&s"
                              alt="캡컷">
        `;

        document.getElementById('detailLogo').src = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1qbsIazYTPIuZToJRVXA-l77ASMPHFv7wwg&s';

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
        <img src="https://w7.pngwing.com/pngs/724/773/png-transparent-adobe-logo-landscape-tech-companies-thumbnail.png"
                              alt="어도비">
        `;

        document.getElementById('detailLogo').src = 'https://w7.pngwing.com/pngs/724/773/png-transparent-adobe-logo-landscape-tech-companies-thumbnail.png';

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
       <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3tDbaE8niB1q1r90T0468StH2PNdCZ8teEg&s"
                             alt="듀오링고">
       `;

       document.getElementById('detailLogo').src = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3tDbaE8niB1q1r90T0468StH2PNdCZ8teEg&s';

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
       <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAWEAAACPCAMAAAAcGJqjAAAAk1BMVEX///+kUfejTvefRPeiTfehSvfn0/2tZvjgyP2fRveiS/e3e/nt3v6gSPfjy/yeQffcv/zz6/79+//69v/38P6mVPepW/eoV/f17f7z6P68gvnq2v3fw/z59P7Vsvu4ePmybfjYuPvBjPnv4v7QqfusYfjJm/q/h/nDkvqzbvjIl/rOo/vRrPvjz/20c/jUsPuaNvY7Kw4sAAASeklEQVR4nO1daXuyPBOtgYhG44KKivuC2mrt8/9/3esKM2ECUbTie/d86XVVluSQTGbL5OPjbrSbi8FsO/crn07QKXQDZzqZb2fFan90/zP/cMWottxUnIIlubAZY4UjDn8Fl5ZwKptlzX11C98Zo8XPlNmc22diYzj9VvhcDtqvbulbwv1eTqTUcAthy/p0NWy+ur1vhlb1K+gcxqchGGeeX2y9utXvg/5sb3GD0YtIFta+8TeQjTD6ccxHL4QtnN2fRE5Ff2yXbxy+YCCXxXLx6h7kG+7YuVU8KODB9k8ea+EOu1Y2fo/jWIrxn6ygUV2LzPyeOd7XXt2XPKK54uIR/B5hy1Xv1f3JHYpB+VH8HiE/q6/uUb7gLgt3KWh6iM7PEzwWbnG7/mokOJx6jfnU3w4e/+aMaM6tx/J7AKvPH26ADHxLCm4FM90FNccSTEiRNyE1CB4mgSFEUHxsO4seP388vqUvKHUuHZGVx745I8biwRLiCluMH9nO9ud1IDBWIi8Iwo6In0e+OSO2OudkdjCmGWx3YSjDB4s1JeTHkayzp7nRyVvzh+oQKsrzx8VBJkCWSYrAObhA9B/23oyY82cSfLCi/Yc1tQvmWp1yf+yBtKvnRJ8YrWWclMdC+ubztbpybG+tczTDp1rUIuqAT2CRkvrjY/Hzybr+8NcijP6TR/ARvGKqGG8Lkh0UBU4K2ccwXOqU7aMvu/I7QqQ1f/oIPkL6ZiNmeXU7leckxQ9g+LtzuUQEv+IBfLYMvoJvTFpT7IQEcdKkyM7wyAnXQrm6hak7sX2qFgEhlwbNAd+bOdQF8In3MTyL1DkWPD9UMH6KIUeDae3cCB3Az3+UXIEPvI/hDZi05QcbnHEMCk8zNOJgnXRXG1wTSGUMPvA+hn2RcsEj0QyeZCrTsINUnQ2pu9TV8Hn3MbyGDH/fzNlNcOe/KCOOEKmrXSVqEStQF8DH3cfwFswTg1mVCcv60zlVYO1SmlSKhCS9MqKn3cVwL1rbBa0RPgyD5zMaA0sZNK31daXnDulZhg+7Ux9eXV9hy+cO4d7+V4XwGWKSJornhWMqgdBdCB92r023E8eZwqTzZE3i61dsORXpSn5t3q2LSuOZfonSvFyvd7dPNpqLLyFYQwuCOyr2tPIx9VEmDH+4vWL12X6f0f6X9YgrxCRT1+Cj7mf4NzAj3BHHZGvOb8xIOd90g0in/Q2meBuGR/HMNFbuTlbb7cr3TFKyrzdZXuV4U6VrfBPjWWLAb8PwUpXCB6pmi9PyPVoMg7oZXcxyGovR+aaGZ5juxv7LErd7F4arnsKG7aGI8NAzkdIC5yzMOiaygk+HWVr+LgyvFCksAiWiNZimu4256vv7Nki5kLQhYYw3YbivZPfYnzH13k3VNUQlphT0PtNu4uuMStKbMKwMYRYQund/msyWcAija6FKH5XgfVYt9D0Y7juYB0kaAcVOElusQNr0pUSCmZPZjHoPhhVdWJcAtkvKFLQ1uVLJUans7ti3YLiFXT6EPL1cV9HLCeFr7NpWglOfz7M3/i0YLuKxWde68IpdPVna6V7TyhbWeUC66VswvEZDU+z1V/q6QZwQmncnukEsDS2N791mW9K5fh7E8KL2xN2rzS4aZSwht2ugkcSsm+C6rmkiJ6TGQrxzX5dc1j0NOQ9heNatW1Z9/6xQ/hARLPyEb+l+0uNRrJNeoIlfm0nhavc8bxhv0A/PznDv67wdU3gPzWwO4W6QJiHojlzQoC27eqKP94f2PJdNhnA7NHSYR06uBzD8dZ2ZLN1XfQ96AR5iieJI1ZwvLeskvoE2O+wEeR9hFn0dWtZnZ7gZiT46xzsrsCaRPN8P35saxGlL1oZaIKWRWxiswqxLXZCd4Z0Er3hGKBQLCStl42aVWrZ4yuQqUd79rlG2NJxgdWp6ZWfYf3ZGCprCrIuFY833Fd8iYTqzKb5p6Pv4O7UIhm3FIzGskLMHZVVRAyw7w9COshJXofvQT9IkSv8JUccLLJEWpGTuzCwhlJYSeQL8C12xtIRF2R+/wTBoXPkJDA8RYxzl4JwyKFiAHLjDuErM0TdoHic289CSEYugHDqL5kbzoNFxaob+HzCMHZcd1Mszm5jAWDTkMIaRpn7eXYW112pcTNTRJ1hJ9ete8P4Mu8hkZjgZ8vybWEPJ0a6oM17R1c49wqpVb6p+FiXd+niTIjfOeH+Gm6jv9gT9eHE8dpCYUANOioLXu+yBRaufG9PXsId00Dm9nHDhvz/Diw7qN0pxumpmuOEzVaZKtJf1qpnhlL+l+llwXxvHTpIp/u/PMLY3sDZ8tXaxQVFVlzoLdXx74bKMDIqSKiWwan+eF4Ig6P0ZxiNSIoXpaosIvKddYVhxkV21OSyI8VQ53PQJ39Q6K/0WYeXlmWF3URsOh7ViNdHNjaQqc5AVcDV2mKdtckENiYyu7VWWMsX5gVOhLwshllFn5JRht1VaTRyvw1ih0/WC/brR1nk0fKgZ4H63P8O2kUP7AsxL5Bqy8HvwUocXuv719fH25ZLhxXgvLG5fitYWGLOFJfcN2lf4CccWzuOvhuOOoZaP8VLH0UJXDcUB3teiaCBYXb449gVRYSOHDPe/Airx0RYBWYQl0Pf7O/y/QAJSDXSgVtfCH/GqqZiCHLl9Lt+MfcbblzuGF+u6rrwf49YqPo7RCqRYdGHvOBrbyqrVQWRFrkCJTUHsk5NI4F9coiyIdyhvDG+9xOwyHq82hL4BVki34bPEBspnbKQwD/mKIhMRm2g99FkUMzCMTcV7lC+GB59p+aTMmihaPfp1ikZWRJaN1QW0ahHm7+WzoCodI2w74vjGNRSLF8cTcsXwsGOQgcqnmGL4m41WGjdqmqLyojgHJvIjEgZsj1Re5P9Qxvf1RfV4p3LEsLsyq69qd9FbEPvISHBB57AJvIMMY72rBxgOSFvvBCyji9cu1uPJRvlhuPVlup+TIeMU/iKR+3ABHoiDKw2oq+A2fUOVQe/OwFQ0rsO7Hl+Jc8Nwax1f4g56sOAivs+FdYEehRqI3g/1K8x9Ed6EN8zDwD32sQ9RG+glNccMuxvVHcOknFb8+WbjB+Wyoh8z4DKHmWiYLLihGjsom1AvEEjLhiIaO4wG4E1KUmvo2qzHNfa8MPyjZFhzNt1V26OW67qt3mI26QglNS30+EKbzkKmNdQYFE0VpGGxAMpOF96E18Am8ExgT3B7kn85XFLs2GCltKXd8NE6KMNKUevo8ayLGEb2NNajHEgWVId78Cb8WYBqovg/IldGbnWJFnJcCYsqj9oaImPEui7mYInHAY4FeqiFBAiIN3NkjAxQEA+H4kBHlABH2IS86sMuqi4lVZsiBBiuB6Pq0pgGKK6AlDWcK1xGTQOfBTuLvpG0whX6gEsO1xYNl1QqOSsXDKOyEHKtdQe7S2DyXXPWgRsHK6kNHOVHRAI1AzuLsNsNhzlg8hLSMsLVkSpGlQuG4R6h5AyyBkjYuehSwI0j0etxigMe39CNg27CAU9suZWAuoMGd5iuIohqmHlgGHZXplRRAbYCc05LVDNqQAe2D0f5ldW/GT0Fp5zi8Af29/ajdnbRPItceDmNcYBxI1IrHQIl9+z0DaM+imdthMnCP7bDH5mDnA9YK2dT9GMoh3FUqhkyX85nnK4KlFOZmvPcipLYz6l5USYD9tT01HgnbHzkXbOR03yALXc8wFthV7FnLZIeVOJjDhgGo9KkzCHYUnDWD8JMBiwFGwrDeHyFMSEcWtthvbzA4YoWyR0snyPFhErezQHDkQaKI+Q6RLmcZzEZ6gxYCirhTsVuHl9/xR91rbhP8bobrp04MTOcD2qS7AmvZziSYuRCEQccnMe1rhrGhpEKpe4mwAno31cNBPVppGan2Xu48JauVFqQyUX4JjLF//UMA6XKMtusFKln57UubD+0BPuxDEsUOg5/RvG2Qewm1iJ+xumHxfAecoS8nmHgahHE3QRAJO3UpYvYwIN0qHKlCOKLDmtP4LCLlwpC8ebr5l6OVMpIdnOq+y9nGEUlibsJRC5ce38cTBexoVt+wu+H1rTL+lqGuRKuKrvVYXkx3nBuQNQ/SZXyeDnDcGJaZsXrwajvHOVK/6zuochHO74tACu355IfeLfLKJ67zabwzecsROZBaRbFqpTcrQteznAN/Cr8RTMVC5h8c27RaWiJChSZCyopAGqr7immgg99KBJxLLzh6FQOXKLJELk4yATt1zM8g9UbRN0A8YDkwuNM4A1bxL4LRTEreuJwE1pbqa12eIdCrXC4qUumamroeT3DcXl5Cy7+nOLE2+MnB7H5flQBkDL1vfcqyAZrqQre6Q0VvLfJ8SpoVEfed80+8pczHF9cbsE1QWLUxyK8SiZeKO1v95UNcWQygVJvtqfcFO2Txq78EC9nOFvRa7wQRSC31pLOxQgt1aA7I3kDPtjrb9Pxm1cz7GpLapiB3Cms2R5+WOyTNv0u6LoIrJuk4UR7HFiHvu7lDGvrj5iBVJBQHB8isVQwkbBxAk9yR0UHc1HZ2Ue8nOFsY5imbKST7eqmZ4iF7h3Yg4xRjCx4XWUHlCn0dnKYdUlPxkpb6plrSyO4tBQ+3UTquUeA2lf2XlPW4tVjWLMmmYEXyJKe3x39LUxXHKCR8KXJoXcEOC5He7LlyxmG+rCwbkGdr0m6Wk6CaNfV+GsnHUWjq5FfjeKy+qJKL2cYZOKJee0WaEqrt/zEcvCcLFw3Sih1d4Aky8f0QKlS/Rr6cjkMqo9Yjzih0Z2nKCdyEw+2pmo0chX/Lm1Y1lVfRfvlYxhk5piFOJLRq6SenSYddXksOqmLQTmWiFSCpYl1hTY/csAw8A+nFIwywdAxUE2UQtnuT9dkc4ODmt5C58UnmTIvlxKwSI1hFEmD3mJsWLidWZ3doN92P9x2f7C1y4Y3dceDo1PCbS+KKwvvpk5IVHr5GIb2l17xNMG6Y0bViS7Jncp8Na8E0vyYFFYWTmWzWk8CqWQ7iwTD+vUMg90WOHhwK74LN4HZgotbzyWnb0qsUvh6huEDspXzzeYIvR+KC1nB6+XwxxKs/plOuWyzG0fkg6A1+U7IwRiGeWs2lTVjjFh5mV9BytleOWAYze5M59G7OgfkM2GnpILlgWFUjMDoSGdXk2TcSzna4RmwUyzRPDCM6jYerNqU+q6txkT+59NFvxu/f05oWrpoLhguIq9Ailbc96U4nglJuBcO2P72Wbep9X5zwbBSzKyccNql2+AXDi3S39VKOTfmwbC91DOR8sGwiw94Ep2lZrPBYB7tcuZk5+I5l08EK6S7A/PBMNLYji3nfBs379zBmoMvgZL6ItBZD8+B7hgaiJww/DFWJ7fsroZIN+7P5gIJE528VncKPA9Gx3HkheH4ScCMMy+orBq1UqnW2M0dTygfQeuTjVUOfRLMbPzcMExZC4wJXj6G5MpSxC1iS3eyobtJ9cI/AnJudIZLbhj+aK1vm912V29L/YZtZ2p95odhzZEMOggvwUnUev4olqZHK8KW/ALDiZX23aXhgbTHDgaJDq2P1ZPVYn1qiwqoJdUpTz1UL8lPANP5yWgxOi0i+fCvWnpI8gRRWKaYUu7W8CTg+2CZyeAjYBhbkhfAffPUJ4BpUYzyPULXmUjR0Ht+PT1TUNQrBm7kWeKRlZnA2A3nM8ON2OQxP0MQRiNtcJBZRBww+4GKXNuV1L0wpWnKUd/C9lNOjbk+qfAkSWGLW05xB6VaGDmDR59heQpG9qwdJTFpcrcm4UeqGzStNw4s3ThmdtnSeNUIVE1C+7dDOLdlzsyuQ8bSOGYXzpkgoct9q10zByRRffeI/iVLxBZmKSduY9LlsfqBTEgWVH7MNoSd0duYL53GqFNFiBIx7lrcFmW+0snuxZxLwet7rRpQ8o5PkNZGp6C2N4XDEyzHfHIVG5uprEsuzuDSsrzKqnRzKPrHpJLmLbALu9uPJ+sderMeJzTeXWzXX7WExbNd+5r6P9WEV/eW883wluH34Y56xZ+Nf8J8NS7123edglndP9RLIW+UEP8C2kvVn3E/bPl1q4T4J1CtpGgnppB7MyXm38Oo0clufjBZ3t0k5v4tuLsgoy+Ie6s/fhOx2PH7ZQWTllqH8w9xtJfBfWueEM7yAYe3/wvozyZls0LocPhyv/GnQBjDrX55Beo4FQ29vONs+884APn/GaPadlKWBiQzbk1X33/03oNRdTwp2Jzr0rOZ4IIVnNXgT3vIAPd791VxhCUPZMITrri0bKeymhXvstH/gDHqV79n2/lk6gTdQsFzPif+/GtcXPQNI3D/CP4HAc1SXro12UMAAAAASUVORK5CYII="
            alt="밀리의 서재">
       `;

       document.getElementById('detailLogo').src = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAWEAAACPCAMAAAAcGJqjAAAAk1BMVEX///+kUfejTvefRPeiTfehSvfn0/2tZvjgyP2fRveiS/e3e/nt3v6gSPfjy/yeQffcv/zz6/79+//69v/38P6mVPepW/eoV/f17f7z6P68gvnq2v3fw/z59P7Vsvu4ePmybfjYuPvBjPnv4v7QqfusYfjJm/q/h/nDkvqzbvjIl/rOo/vRrPvjz/20c/jUsPuaNvY7Kw4sAAASeklEQVR4nO1daXuyPBOtgYhG44KKivuC2mrt8/9/3esKM2ECUbTie/d86XVVluSQTGbL5OPjbrSbi8FsO/crn07QKXQDZzqZb2fFan90/zP/cMWottxUnIIlubAZY4UjDn8Fl5ZwKptlzX11C98Zo8XPlNmc22diYzj9VvhcDtqvbulbwv1eTqTUcAthy/p0NWy+ur1vhlb1K+gcxqchGGeeX2y9utXvg/5sb3GD0YtIFta+8TeQjTD6ccxHL4QtnN2fRE5Ff2yXbxy+YCCXxXLx6h7kG+7YuVU8KODB9k8ea+EOu1Y2fo/jWIrxn6ygUV2LzPyeOd7XXt2XPKK54uIR/B5hy1Xv1f3JHYpB+VH8HiE/q6/uUb7gLgt3KWh6iM7PEzwWbnG7/mokOJx6jfnU3w4e/+aMaM6tx/J7AKvPH26ADHxLCm4FM90FNccSTEiRNyE1CB4mgSFEUHxsO4seP388vqUvKHUuHZGVx745I8biwRLiCluMH9nO9ud1IDBWIi8Iwo6In0e+OSO2OudkdjCmGWx3YSjDB4s1JeTHkayzp7nRyVvzh+oQKsrzx8VBJkCWSYrAObhA9B/23oyY82cSfLCi/Yc1tQvmWp1yf+yBtKvnRJ8YrWWclMdC+ubztbpybG+tczTDp1rUIuqAT2CRkvrjY/Hzybr+8NcijP6TR/ARvGKqGG8Lkh0UBU4K2ccwXOqU7aMvu/I7QqQ1f/oIPkL6ZiNmeXU7leckxQ9g+LtzuUQEv+IBfLYMvoJvTFpT7IQEcdKkyM7wyAnXQrm6hak7sX2qFgEhlwbNAd+bOdQF8In3MTyL1DkWPD9UMH6KIUeDae3cCB3Az3+UXIEPvI/hDZi05QcbnHEMCk8zNOJgnXRXG1wTSGUMPvA+hn2RcsEj0QyeZCrTsINUnQ2pu9TV8Hn3MbyGDH/fzNlNcOe/KCOOEKmrXSVqEStQF8DH3cfwFswTg1mVCcv60zlVYO1SmlSKhCS9MqKn3cVwL1rbBa0RPgyD5zMaA0sZNK31daXnDulZhg+7Ux9eXV9hy+cO4d7+V4XwGWKSJornhWMqgdBdCB92r023E8eZwqTzZE3i61dsORXpSn5t3q2LSuOZfonSvFyvd7dPNpqLLyFYQwuCOyr2tPIx9VEmDH+4vWL12X6f0f6X9YgrxCRT1+Cj7mf4NzAj3BHHZGvOb8xIOd90g0in/Q2meBuGR/HMNFbuTlbb7cr3TFKyrzdZXuV4U6VrfBPjWWLAb8PwUpXCB6pmi9PyPVoMg7oZXcxyGovR+aaGZ5juxv7LErd7F4arnsKG7aGI8NAzkdIC5yzMOiaygk+HWVr+LgyvFCksAiWiNZimu4256vv7Nki5kLQhYYw3YbivZPfYnzH13k3VNUQlphT0PtNu4uuMStKbMKwMYRYQund/msyWcAija6FKH5XgfVYt9D0Y7juYB0kaAcVOElusQNr0pUSCmZPZjHoPhhVdWJcAtkvKFLQ1uVLJUans7ti3YLiFXT6EPL1cV9HLCeFr7NpWglOfz7M3/i0YLuKxWde68IpdPVna6V7TyhbWeUC66VswvEZDU+z1V/q6QZwQmncnukEsDS2N791mW9K5fh7E8KL2xN2rzS4aZSwht2ugkcSsm+C6rmkiJ6TGQrxzX5dc1j0NOQ9heNatW1Z9/6xQ/hARLPyEb+l+0uNRrJNeoIlfm0nhavc8bxhv0A/PznDv67wdU3gPzWwO4W6QJiHojlzQoC27eqKP94f2PJdNhnA7NHSYR06uBzD8dZ2ZLN1XfQ96AR5iieJI1ZwvLeskvoE2O+wEeR9hFn0dWtZnZ7gZiT46xzsrsCaRPN8P35saxGlL1oZaIKWRWxiswqxLXZCd4Z0Er3hGKBQLCStl42aVWrZ4yuQqUd79rlG2NJxgdWp6ZWfYf3ZGCprCrIuFY833Fd8iYTqzKb5p6Pv4O7UIhm3FIzGskLMHZVVRAyw7w9COshJXofvQT9IkSv8JUccLLJEWpGTuzCwhlJYSeQL8C12xtIRF2R+/wTBoXPkJDA8RYxzl4JwyKFiAHLjDuErM0TdoHic289CSEYugHDqL5kbzoNFxaob+HzCMHZcd1Mszm5jAWDTkMIaRpn7eXYW112pcTNTRJ1hJ9ete8P4Mu8hkZjgZ8vybWEPJ0a6oM17R1c49wqpVb6p+FiXd+niTIjfOeH+Gm6jv9gT9eHE8dpCYUANOioLXu+yBRaufG9PXsId00Dm9nHDhvz/Diw7qN0pxumpmuOEzVaZKtJf1qpnhlL+l+llwXxvHTpIp/u/PMLY3sDZ8tXaxQVFVlzoLdXx74bKMDIqSKiWwan+eF4Ig6P0ZxiNSIoXpaosIvKddYVhxkV21OSyI8VQ53PQJ39Q6K/0WYeXlmWF3URsOh7ViNdHNjaQqc5AVcDV2mKdtckENiYyu7VWWMsX5gVOhLwshllFn5JRht1VaTRyvw1ih0/WC/brR1nk0fKgZ4H63P8O2kUP7AsxL5Bqy8HvwUocXuv719fH25ZLhxXgvLG5fitYWGLOFJfcN2lf4CccWzuOvhuOOoZaP8VLH0UJXDcUB3teiaCBYXb449gVRYSOHDPe/Airx0RYBWYQl0Pf7O/y/QAJSDXSgVtfCH/GqqZiCHLl9Lt+MfcbblzuGF+u6rrwf49YqPo7RCqRYdGHvOBrbyqrVQWRFrkCJTUHsk5NI4F9coiyIdyhvDG+9xOwyHq82hL4BVki34bPEBspnbKQwD/mKIhMRm2g99FkUMzCMTcV7lC+GB59p+aTMmihaPfp1ikZWRJaN1QW0ahHm7+WzoCodI2w74vjGNRSLF8cTcsXwsGOQgcqnmGL4m41WGjdqmqLyojgHJvIjEgZsj1Re5P9Qxvf1RfV4p3LEsLsyq69qd9FbEPvISHBB57AJvIMMY72rBxgOSFvvBCyji9cu1uPJRvlhuPVlup+TIeMU/iKR+3ABHoiDKw2oq+A2fUOVQe/OwFQ0rsO7Hl+Jc8Nwax1f4g56sOAivs+FdYEehRqI3g/1K8x9Ed6EN8zDwD32sQ9RG+glNccMuxvVHcOknFb8+WbjB+Wyoh8z4DKHmWiYLLihGjsom1AvEEjLhiIaO4wG4E1KUmvo2qzHNfa8MPyjZFhzNt1V26OW67qt3mI26QglNS30+EKbzkKmNdQYFE0VpGGxAMpOF96E18Am8ExgT3B7kn85XFLs2GCltKXd8NE6KMNKUevo8ayLGEb2NNajHEgWVId78Cb8WYBqovg/IldGbnWJFnJcCYsqj9oaImPEui7mYInHAY4FeqiFBAiIN3NkjAxQEA+H4kBHlABH2IS86sMuqi4lVZsiBBiuB6Pq0pgGKK6AlDWcK1xGTQOfBTuLvpG0whX6gEsO1xYNl1QqOSsXDKOyEHKtdQe7S2DyXXPWgRsHK6kNHOVHRAI1AzuLsNsNhzlg8hLSMsLVkSpGlQuG4R6h5AyyBkjYuehSwI0j0etxigMe39CNg27CAU9suZWAuoMGd5iuIohqmHlgGHZXplRRAbYCc05LVDNqQAe2D0f5ldW/GT0Fp5zi8Af29/ajdnbRPItceDmNcYBxI1IrHQIl9+z0DaM+imdthMnCP7bDH5mDnA9YK2dT9GMoh3FUqhkyX85nnK4KlFOZmvPcipLYz6l5USYD9tT01HgnbHzkXbOR03yALXc8wFthV7FnLZIeVOJjDhgGo9KkzCHYUnDWD8JMBiwFGwrDeHyFMSEcWtthvbzA4YoWyR0snyPFhErezQHDkQaKI+Q6RLmcZzEZ6gxYCirhTsVuHl9/xR91rbhP8bobrp04MTOcD2qS7AmvZziSYuRCEQccnMe1rhrGhpEKpe4mwAno31cNBPVppGan2Xu48JauVFqQyUX4JjLF//UMA6XKMtusFKln57UubD+0BPuxDEsUOg5/RvG2Qewm1iJ+xumHxfAecoS8nmHgahHE3QRAJO3UpYvYwIN0qHKlCOKLDmtP4LCLlwpC8ebr5l6OVMpIdnOq+y9nGEUlibsJRC5ce38cTBexoVt+wu+H1rTL+lqGuRKuKrvVYXkx3nBuQNQ/SZXyeDnDcGJaZsXrwajvHOVK/6zuochHO74tACu355IfeLfLKJ67zabwzecsROZBaRbFqpTcrQteznAN/Cr8RTMVC5h8c27RaWiJChSZCyopAGqr7immgg99KBJxLLzh6FQOXKLJELk4yATt1zM8g9UbRN0A8YDkwuNM4A1bxL4LRTEreuJwE1pbqa12eIdCrXC4qUumamroeT3DcXl5Cy7+nOLE2+MnB7H5flQBkDL1vfcqyAZrqQre6Q0VvLfJ8SpoVEfed80+8pczHF9cbsE1QWLUxyK8SiZeKO1v95UNcWQygVJvtqfcFO2Txq78EC9nOFvRa7wQRSC31pLOxQgt1aA7I3kDPtjrb9Pxm1cz7GpLapiB3Cms2R5+WOyTNv0u6LoIrJuk4UR7HFiHvu7lDGvrj5iBVJBQHB8isVQwkbBxAk9yR0UHc1HZ2Ue8nOFsY5imbKST7eqmZ4iF7h3Yg4xRjCx4XWUHlCn0dnKYdUlPxkpb6plrSyO4tBQ+3UTquUeA2lf2XlPW4tVjWLMmmYEXyJKe3x39LUxXHKCR8KXJoXcEOC5He7LlyxmG+rCwbkGdr0m6Wk6CaNfV+GsnHUWjq5FfjeKy+qJKL2cYZOKJee0WaEqrt/zEcvCcLFw3Sih1d4Aky8f0QKlS/Rr6cjkMqo9Yjzih0Z2nKCdyEw+2pmo0chX/Lm1Y1lVfRfvlYxhk5piFOJLRq6SenSYddXksOqmLQTmWiFSCpYl1hTY/csAw8A+nFIwywdAxUE2UQtnuT9dkc4ODmt5C58UnmTIvlxKwSI1hFEmD3mJsWLidWZ3doN92P9x2f7C1y4Y3dceDo1PCbS+KKwvvpk5IVHr5GIb2l17xNMG6Y0bViS7Jncp8Na8E0vyYFFYWTmWzWk8CqWQ7iwTD+vUMg90WOHhwK74LN4HZgotbzyWnb0qsUvh6huEDspXzzeYIvR+KC1nB6+XwxxKs/plOuWyzG0fkg6A1+U7IwRiGeWs2lTVjjFh5mV9BytleOWAYze5M59G7OgfkM2GnpILlgWFUjMDoSGdXk2TcSzna4RmwUyzRPDCM6jYerNqU+q6txkT+59NFvxu/f05oWrpoLhguIq9Ailbc96U4nglJuBcO2P72Wbep9X5zwbBSzKyccNql2+AXDi3S39VKOTfmwbC91DOR8sGwiw94Ep2lZrPBYB7tcuZk5+I5l08EK6S7A/PBMNLYji3nfBs379zBmoMvgZL6ItBZD8+B7hgaiJww/DFWJ7fsroZIN+7P5gIJE528VncKPA9Gx3HkheH4ScCMMy+orBq1UqnW2M0dTygfQeuTjVUOfRLMbPzcMExZC4wJXj6G5MpSxC1iS3eyobtJ9cI/AnJudIZLbhj+aK1vm912V29L/YZtZ2p95odhzZEMOggvwUnUev4olqZHK8KW/ALDiZX23aXhgbTHDgaJDq2P1ZPVYn1qiwqoJdUpTz1UL8lPANP5yWgxOi0i+fCvWnpI8gRRWKaYUu7W8CTg+2CZyeAjYBhbkhfAffPUJ4BpUYzyPULXmUjR0Ht+PT1TUNQrBm7kWeKRlZnA2A3nM8ON2OQxP0MQRiNtcJBZRBww+4GKXNuV1L0wpWnKUd/C9lNOjbk+qfAkSWGLW05xB6VaGDmDR59heQpG9qwdJTFpcrcm4UeqGzStNw4s3ThmdtnSeNUIVE1C+7dDOLdlzsyuQ8bSOGYXzpkgoct9q10zByRRffeI/iVLxBZmKSduY9LlsfqBTEgWVH7MNoSd0duYL53GqFNFiBIx7lrcFmW+0snuxZxLwet7rRpQ8o5PkNZGp6C2N4XDEyzHfHIVG5uprEsuzuDSsrzKqnRzKPrHpJLmLbALu9uPJ+sderMeJzTeXWzXX7WExbNd+5r6P9WEV/eW883wluH34Y56xZ+Nf8J8NS7123edglndP9RLIW+UEP8C2kvVn3E/bPl1q4T4J1CtpGgnppB7MyXm38Oo0clufjBZ3t0k5v4tuLsgoy+Ie6s/fhOx2PH7ZQWTllqH8w9xtJfBfWueEM7yAYe3/wvozyZls0LocPhyv/GnQBjDrX55Beo4FQ29vONs+884APn/GaPadlKWBiQzbk1X33/03oNRdTwp2Jzr0rOZ4IIVnNXgT3vIAPd791VxhCUPZMITrri0bKeymhXvstH/gDHqV79n2/lk6gTdQsFzPif+/GtcXPQNI3D/CP4HAc1SXro12UMAAAAASUVORK5CYII='
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
        <img src="data:image/png;base64,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"
                              alt="마이크로소프트 365">
        `;

        document.getElementById('detailLogo').src = 'data:image/png;base64,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';

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

    function selectMonth(month) {

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

        document.getElementById('detailPrice').innerText =
            price.toLocaleString() + '원 / ' + month + '개월';
    }

</script>

</body>
</html>