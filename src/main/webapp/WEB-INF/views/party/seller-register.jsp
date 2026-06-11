<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/include/head.jspf" %>
    <title>판매자 등록</title>
    <style>
        body { background: #e8e8e8; min-height: 100vh; display: flex; flex-direction: column; margin: 0; }
        .site-header { opacity: 1 !important; transform: translateY(0) !important; background: rgba(25, 59, 96, 0.96) !important; }
        .footer { height: auto !important; }
        body { display: flex; flex-direction: column; min-height: 100vh; }
        .page-wrap { flex: 1; }
        .page-wrap { padding: 2rem 1.5rem; max-width: 900px; width: 100%; margin: 0 auto; padding-top: calc(74px + 2rem); flex: 1; box-sizing: border-box; }
        /* 변경 */
        .page-wrap {
            max-width: 900px;
            width: 100%;
            margin: 0 auto;
            padding: calc(74px + 2rem) 1.5rem 2rem;
            flex: 1;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .breadcrumb { font-size: 12px; color: #666; margin-bottom: 1rem; }
        .card { background: #f0f0f0; border-radius: 12px; padding: 1.5rem 2rem; }
        .card-title { text-align: center; font-size: 20px; font-weight: 500; margin-bottom: 1.5rem; color: #1a1a1a; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem 3rem; }
        .fg { display: flex; flex-direction: column; padding: 0.5rem 0; border-bottom: 1px solid #bbb; position: relative; }
        .fg input { background: transparent; border: none; outline: none; font-size: 14px; color: #333; padding: 4px 0; width: 100%; }
        .fg input::placeholder { color: #aaa; font-size: 13px; }
        .err { font-size: 11px; color: #e24b4a; display: none; margin-top: 3px; }
        .err.on { display: block; }
        .ok { font-size: 11px; color: #1d9e75; display: none; margin-top: 3px; }
        .ok.on { display: block; }
        .send-ok { font-size: 11px; color: #1d9e75; display: none; margin-top: 3px; }
        .send-ok.on { display: block; }
        .inline { display: flex; align-items: center; gap: 6px; }
        .inline input { flex: 1; min-width: 0; background: transparent; border: none; outline: none; font-size: 14px; color: #333; padding: 4px 0; }
        .inline input::placeholder { color: #aaa; font-size: 13px; }
        .btn-sm { background: #1e3a5f; color: #fff; border: none; border-radius: 20px; padding: 4px 12px; font-size: 12px; cursor: pointer; white-space: nowrap; }
        .bank-wrap { display: flex; align-items: center; gap: 6px; }
        .bank-name { font-size: 13px; color: #333; display: none; }
        .bank-name.on { display: block; }
        .bank-account { flex: 1; background: transparent; border: none; outline: none; font-size: 14px; color: #333; padding: 4px 0; }
        .bank-account::placeholder { color: #aaa; font-size: 13px; }
        .dropdown { position: absolute; top: 42px; left: 0; background: #fff; border: 0.5px solid #ccc; border-radius: 8px; z-index: 20; min-width: 120px; display: none; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .dropdown.on { display: block; }
        .dropdown div { padding: 7px 14px; font-size: 13px; cursor: pointer; color: #333; }
        .dropdown div:hover { background: #f5f5f5; }
        .suggest { position: absolute; top: 38px; left: 0; right: 0; background: #fff; border: 0.5px solid #ccc; border-radius: 8px; z-index: 20; display: none; }
        .suggest.on { display: block; }
        .suggest div { padding: 7px 14px; font-size: 13px; cursor: pointer; color: #333; }
        .suggest div:hover { background: #f5f5f5; }
        .warn { font-size: 11px; color: #e24b4a; display: none; margin-top: 3px; }
        .warn.on { display: block; }
        .account-err { font-size: 11px; color: #e24b4a; display: none; margin-top: 3px; }
        .account-err.on { display: block; }
        .btn-outline { background: #fff; border: 1px solid #ccc; border-radius: 30px; padding: 10px 40px; font-size: 15px; cursor: pointer; color: #333; }
        .btn-dark { background: #1e3a5f; color: #fff; border: none; border-radius: 30px; padding: 10px 40px; font-size: 15px; cursor: pointer; }
        .postcode-layer { display: none; position: fixed; z-index: 9999; left: 0; top: 0; width: 100%; height: 100vh; background: rgba(0,0,0,0.35); }
        .postcode-layer.on { display: flex; align-items: center; justify-content: center; }
        .postcode-box { position: relative; width: 520px; max-width: 92%; height: 560px; background: #fff; border-radius: 14px; overflow: hidden; box-shadow: 0 8px 24px rgba(0,0,0,0.18); }
        .postcode-close { position: absolute; right: 10px; top: 8px; z-index: 2; width: 30px; height: 30px; border: none; background: #1e3a5f; color: #fff; border-radius: 50%; font-size: 20px; line-height: 28px; cursor: pointer; }
        .postcode-frame { width: 100%; height: 516px; padding-top: 44px; box-sizing: border-box; }
        .toast { display: none; text-align: center; color: #e24b4a; font-size: 13px; margin-top: 10px; padding: 8px 0; }
        .toast.on { display: block; }
        .btn-row { display: flex; flex-direction: column; align-items: center; gap: 0.8rem; margin-top: 1.2rem; }
        .btn-group { display: flex; gap: 1rem; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>
<script>
    (function() {
        var header = document.querySelector('.site-header');
        if (header) header.classList.add('is-solid');
        document.body.classList.add('is-header-ready');
        document.body.classList.add('is-opening-loaded');
        document.body.classList.add('is-fab-ready');
    })();

</script>
<div id="postcode-layer" class="postcode-layer">
    <div class="postcode-box">
        <button type="button" class="postcode-close" onclick="closePost()">×</button>
        <div id="postcode-frame" class="postcode-frame"></div>
    </div>
</div>

<div class="page-wrap">
    <p class="breadcrumb">판매자 등록</p>

    <div class="card">
        <h2 class="card-title">개인정보 입력</h2>

        <div class="form-grid">

            <div class="fg">
                <input type="text" id="name" placeholder="이름" oninput="chkName()">
                <span class="err" id="name-err">이름을 정확히 입력해주세요.</span>
            </div>

            <div class="fg">
                <div class="inline">
                    <input type="text" id="zip" placeholder="우편번호" readonly style="flex:1;" onclick="openPost()">
                    <button type="button" class="btn-sm" id="zip-btn" onclick="openPost()" disabled style="opacity:0.5;cursor:not-allowed;">검색</button>
                </div>
            </div>

            <div class="fg">
                <input type="text" id="phone" placeholder="전화번호" oninput="chkPhone()" maxlength="13">
                <span class="err" id="phone-err">휴대폰 번호를 정확히 입력해주세요.</span>
            </div>

            <div class="fg">
                <input type="text" id="addr" placeholder="상세주소">
            </div>

            <div class="fg">
                <input type="text" id="birth" placeholder="생년월일(8자)" oninput="chkBirth()" maxlength="8">
                <span class="err" id="birth-err">생년월일 8자리를 입력해주세요.</span>
            </div>

            <div class="fg" style="position:relative;">
                <div class="bank-wrap">
                    <button type="button" class="btn-sm" id="bank-btn" onclick="toggleBank()">은행선택 ▼</button>
                    <span class="bank-name" id="bank-name"></span>
                    <input type="text" class="bank-account" id="account" placeholder="계좌번호" oninput="chkAccount()">
                </div>
                <div class="dropdown" id="bank-dd">
                    <div onclick="pickBank('국민은행')">국민은행</div>
                    <div onclick="pickBank('신한은행')">신한은행</div>
                    <div onclick="pickBank('우리은행')">우리은행</div>
                    <div onclick="pickBank('하나은행')">하나은행</div>
                    <div onclick="pickBank('농협은행')">농협은행</div>
                    <div onclick="pickBank('카카오뱅크')">카카오뱅크</div>
                    <div onclick="pickBank('토스뱅크')">토스뱅크</div>
                </div>
                <span class="account-err" id="account-err"></span>
            </div>

            <div class="fg" style="position:relative;">
                <div class="inline">
                    <input type="text" id="email" placeholder="이메일" oninput="chkEmail()" style="flex:1;">
                    <button type="button" class="btn-sm" onclick="sendCode()">인증코드 받기</button>
                </div>
                <span class="send-ok" id="send-ok">인증 메일이 발송되었습니다. 이메일을 확인해 주세요.</span>
                <div class="suggest" id="suggest"></div>
            </div>

            <div style="grid-column: 1 / -1; height: 0;"></div>

            <div class="fg">
                <div class="inline">
                    <input type="text" id="code" placeholder="인증코드 6자리를 입력해주세요." style="flex:1;">
                    <button type="button" class="btn-sm" onclick="verifyCode()">확인</button>
                </div>
                <span class="err" id="code-err">인증코드가 올바르지 않습니다. 다시 확인해주세요.</span>
                <span class="ok" id="code-ok">이메일 인증이 완료되었습니다.</span>
            </div>

        </div>

        <div class="btn-row">
            <div class="btn-group">
                <button type="button" onclick="history.back()" class="btn-outline">이전으로</button>
                <button type="button" onclick="submitForm()" class="btn-dark">OTT 판매 등록하러 가기</button>
            </div>
            <div id="toast" class="toast"></div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/layout/floatingBtn.jspf" %>
<%@ include file="/WEB-INF/views/common/modal/faqModal.jspf" %>
<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/include/scripts.jspf" %>

<script src="${pageContext.request.contextPath}/js/pages/faq.js"></script>

<script>
    const domains = ['@naver.com','@gmail.com','@daum.net','@kakao.com','@hanmail.net','@nate.com','@icloud.com','@outlook.com','@yahoo.com'];
    const ctx = '${pageContext.request.contextPath}';

    const bankRules = {
        '국민은행':   { min: 10, max: 14 },
        '신한은행':   { min: 11, max: 12 },
        '우리은행':   { min: 13, max: 13 },
        '하나은행':   { min: 10, max: 14 },
        '농협은행':   { min: 11, max: 13 },
        '카카오뱅크': { min: 13, max: 13 },
        '토스뱅크':   { min: 12, max: 12 }
    };

    let selectedBank = '';

    function showToast(msg) {
        const t = document.getElementById('toast');
        t.textContent = msg;
        t.classList.add('on');
        setTimeout(function() { t.classList.remove('on'); }, 3000);
    }

    function chkName() {
        const v = document.getElementById('name').value;
        const ok = /^[가-힣]+$/.test(v) || /^[a-zA-Z]+$/.test(v);
        document.getElementById('name-err').classList.toggle('on', v.length > 0 && !ok);
    }

    function chkPhone() {
        let v = document.getElementById('phone').value.replace(/[^0-9\-]/g,'');
        let digits = v.replace(/[^0-9]/g,'');
        if (digits.length > 11) digits = digits.slice(0,11);
        let fmt = digits;
        if (digits.length >= 8) fmt = digits.slice(0,3)+'-'+digits.slice(3,7)+'-'+digits.slice(7);
        else if (digits.length >= 4) fmt = digits.slice(0,3)+'-'+digits.slice(3);
        document.getElementById('phone').value = fmt;
        document.getElementById('phone-err').classList.toggle('on', digits.length > 0 && digits.length !== 11);
    }

    function chkBirth() {
        let v = document.getElementById('birth').value.replace(/[^0-9]/g,'');
        if (v.length > 8) v = v.slice(0,8);
        document.getElementById('birth').value = v;
        document.getElementById('birth-err').classList.toggle('on', v.length > 0 && v.length < 8);
    }

    function chkAccount() {
        let v = document.getElementById('account').value.replace(/[^0-9]/g,'');
        if (selectedBank && bankRules[selectedBank]) {
            const max = bankRules[selectedBank].max;
            if (v.length > max) v = v.slice(0, max);
        }
        document.getElementById('account').value = v;
        const errEl = document.getElementById('account-err');
        if (!selectedBank || !bankRules[selectedBank]) {
            errEl.classList.remove('on');
            return;
        }
        const rule = bankRules[selectedBank];
        if (v.length > 0 && (v.length < rule.min || v.length > rule.max)) {
            if (rule.min === rule.max) {
                errEl.textContent = selectedBank + ' 계좌번호는 ' + rule.min + '자리를 모두 입력해주세요.';
            } else {
                errEl.textContent = selectedBank + ' 계좌번호는 ' + rule.min + '~' + rule.max + '자리를 모두 입력해주세요.';
            }
            errEl.classList.add('on');
        } else {
            errEl.classList.remove('on');
        }
    }

    function chkEmail() {
        const v = document.getElementById('email').value;
        const at = v.indexOf('@');
        const s = document.getElementById('suggest');
        if (at !== -1) {
            const prefix = v.slice(0, at);
            const typed = v.slice(at);
            const filtered = domains.filter(d => d.startsWith(typed) && typed !== d);
            if (filtered.length > 0) {
                s.innerHTML = filtered.map(d => '<div onclick="fillEmail(\''+prefix+d+'\')">' + prefix + d + '</div>').join('');
                s.classList.add('on');
            } else { s.classList.remove('on'); }
        } else { s.classList.remove('on'); }
    }

    function fillEmail(val) {
        document.getElementById('email').value = val;
        document.getElementById('suggest').classList.remove('on');
    }

    function sendCode() {
        const email = document.getElementById('email').value;
        if (!email) { showToast('이메일을 입력해주세요.'); return; }
        fetch(ctx + '/api/party/sellers/send-code', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({email: email})
        }).then(() => {
            document.getElementById('send-ok').classList.add('on');
        });
    }

    function verifyCode() {
        const email = document.getElementById('email').value;
        const code = document.getElementById('code').value;
        fetch(ctx + '/api/party/sellers/verify-code', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({email: email, code: code})
        }).then(res => res.text()).then(text => {
            if (text.includes('완료')) {
                document.getElementById('code-err').classList.remove('on');
                document.getElementById('code-ok').classList.add('on');
            } else {
                document.getElementById('code-ok').classList.remove('on');
                document.getElementById('code-err').classList.add('on');
            }
        });
    }

    function toggleBank() {
        document.getElementById('bank-dd').classList.toggle('on');
    }

    function pickBank(name) {
        selectedBank = name;
        document.getElementById('bank-name').textContent = name;
        document.getElementById('bank-name').classList.add('on');
        document.getElementById('bank-dd').classList.remove('on');
        chkAccount();
    }

    function openPost() {
        const layer = document.getElementById('postcode-layer');
        const frame = document.getElementById('postcode-frame');
        if (!window.daum || !window.daum.Postcode) {
            showToast('우편번호 서비스를 불러오지 못했습니다. 잠시 후 다시 시도해주세요.');
            return;
        }
        layer.classList.add('on');
        frame.innerHTML = '';
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('zip').value = data.zonecode;
                document.getElementById('addr').value = data.roadAddress || data.jibunAddress;
                closePost();
            },
            width: '100%',
            height: '516px'
        }).embed(frame, { autoClose: false });
    }

    function closePost() {
        const layer = document.getElementById('postcode-layer');
        const frame = document.getElementById('postcode-frame');
        layer.classList.remove('on');
        frame.innerHTML = '';
    }

    function submitForm() {
        const hasExperience = new URLSearchParams(location.search).get('hasExperience') || 'N';
        const userId = '${sessionScope.LOGIN_USER_ID}';

        // [추가] 로그인 체크
        if (!userId || userId === 'null' || userId === '') {
            showToast('로그인이 필요합니다.');
            return;
        }

        const name = document.getElementById('name').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const birth = document.getElementById('birth').value.trim();
        const zip = document.getElementById('zip').value.trim();
        const addr = document.getElementById('addr').value.trim();
        const account = document.getElementById('account').value.trim();
        const bankName = document.getElementById('bank-name').textContent.trim();
        const email = document.getElementById('email').value.trim();

        if (!name) { showToast('이름을 입력해주세요.'); return; }
        if (!phone || phone.replace(/[^0-9]/g,'').length !== 11) { showToast('휴대폰 번호를 정확히 입력해주세요.'); return; }
        if (!birth || birth.length !== 8) { showToast('생년월일 8자리를 입력해주세요.'); return; }
        if (!zip) { showToast('우편번호를 검색해주세요.'); return; }
        if (!addr) { showToast('상세주소를 입력해주세요.'); return; }
        if (!selectedBank) { showToast('은행을 선택해주세요.'); return; }
        if (!account) { showToast('계좌번호를 입력해주세요.'); return; }

        if (bankRules[selectedBank]) {
            const rule = bankRules[selectedBank];
            if (account.length < rule.min || account.length > rule.max) {
                if (rule.min === rule.max) {
                    showToast(selectedBank + ' 계좌번호는 ' + rule.min + '자리를 모두 입력해주세요.');
                } else {
                    showToast(selectedBank + ' 계좌번호는 ' + rule.min + '~' + rule.max + '자리를 모두 입력해주세요.');
                }
                return;
            }
        }

        if (!email) { showToast('이메일을 입력해주세요.'); return; }

        const data = {
            // [수정] 세션 userId 직접 사용
            userId: parseInt(userId),
            name: name,
            birthDate: birth.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3'),
            phone: phone,
            zipCode: zip,
            address: addr,
            bankName: bankName,
            accountNumber: account,
            hasExperience: hasExperience,
            email: email
        };

        fetch(ctx + '/api/party/sellers', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(data)
        }).then(res => {
            if (res.ok) {
                location.href = ctx + '/party/seller-confirm';
            } else {
                showToast('작성이 완료되지 않았습니다. 입력 내용을 다시 확인해주세요.');
            }
        }).catch(() => {
            showToast('요청에 실패했습니다. 잠시 후 다시 시도해주세요.');
        });
    }
</script>
<script>
    (function() {
        var script = document.createElement('script');
        script.src = 'https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js';
        script.onload = function() {
            var btn = document.getElementById('zip-btn');
            if (btn) {
                btn.disabled = false;
                btn.style.opacity = '1';
                btn.style.cursor = 'pointer';
            }
        };
        document.body.appendChild(script);
    })();
</script>
</body>
</html>