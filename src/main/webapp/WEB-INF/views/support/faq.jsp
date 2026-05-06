<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자주 묻는 질문 - 지출메이트</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Apple SD Gothic Neo', sans-serif; background: #f5f5f5; }

        .header {
            background: #1a237e;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 { font-size: 18px; }
        .header a { color: white; text-decoration: none; font-size: 14px; }

        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        h2 { font-size: 18px; margin-bottom: 15px; color: #333; }

        .category-tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        .category-tabs button {
            padding: 6px 14px;
            border: 1px solid #1a237e;
            background: white;
            color: #1a237e;
            border-radius: 20px;
            cursor: pointer;
            font-size: 13px;
        }
        .category-tabs button.active {
            background: #1a237e;
            color: white;
        }

        .faq-list { display: flex; flex-direction: column; gap: 8px; }

        .faq-item {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .faq-question {
            padding: 15px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
            font-weight: 500;
        }
        .faq-question .q-label { color: #1a237e; font-weight: bold; margin-right: 8px; }
        .faq-answer {
            display: none;
            padding: 15px;
            background: #f8f9ff;
            font-size: 13px;
            color: #555;
            line-height: 1.6;
            border-top: 1px solid #eee;
        }
        .faq-item.open .faq-answer { display: block; }
        .arrow { font-size: 12px; color: #999; transition: transform 0.3s; }
        .faq-item.open .arrow { transform: rotate(180deg); }

        .bot-btn {
            position: fixed;
            bottom: 80px;
            right: 20px;
            width: 50px;
            height: 50px;
            background: #1a237e;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.3);
        }
        .chat-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            background: #5c6bc0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.3);
        }
        .loading { text-align: center; padding: 30px; color: #999; }
    </style>
</head>
<body>

<div class="header">
    <span>☰</span>
    <h1>지출메이트</h1>
    <a href="#">로그인/회원가입</a>
</div>

<div class="container">
    <h2>자주 묻는 질문</h2>

    <div class="category-tabs">
        <button class="active" onclick="loadFaqs(this, null)">전체</button>
        <button onclick="loadFaqs(this, '회원가입')">회원가입</button>
        <button onclick="loadFaqs(this, '가계부')">가계부</button>
        <button onclick="loadFaqs(this, '구독관리')">구독관리</button>
        <button onclick="loadFaqs(this, '게시판')">게시판</button>
        <button onclick="loadFaqs(this, '기타')">기타</button>
    </div>

    <div class="faq-list" id="faqList">
        <div class="loading">로딩 중...</div>
    </div>
</div>

<div class="bot-btn">🤖</div>
<div class="chat-btn">💬</div>

<script>
    window.onload = function() {
        loadFaqs(null, null);
    }

    function loadFaqs(btn, category) {
        if (btn) {
            document.querySelectorAll('.category-tabs button')
                .forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
        }

        const url = category
            ? '/support/api/faqs/category?category=' + encodeURIComponent(category)
            : '/support/api/faqs';

        fetch(url)
            .then(res => res.json())
            .then(data => renderFaqs(data))
            .catch(() => {
                document.getElementById('faqList').innerHTML =
                    '<div class="loading">데이터를 불러올 수 없습니다.</div>';
            });
    }

    function renderFaqs(faqs) {
        const list = document.getElementById('faqList');
        if (faqs.length === 0) {
            list.innerHTML = '<div class="loading">등록된 FAQ가 없습니다.</div>';
            return;
        }
        list.innerHTML = faqs.map(faq => `
            <div class="faq-item" onclick="this.classList.toggle('open')">
                <div class="faq-question">
                    <div><span class="q-label">Q</span>${faq.question}</div>
                    <span class="arrow">▼</span>
                </div>
                <div class="faq-answer">
                    <strong>A.</strong> ${faq.answer}
                </div>
            </div>
        `).join('');
    }
</script>

</body>
</html>