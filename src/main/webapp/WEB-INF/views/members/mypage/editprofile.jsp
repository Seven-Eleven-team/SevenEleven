<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지출메이트 - 내 정보 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editprofile.css">

    <style>
        .footer { width: 100%; background: #243864; color: white; padding: 40px 0; margin-top: 60px; }
        body.mypage { padding-top: 78px; min-height: 100vh; display: flex; flex-direction: column; background: #f5f5f5; }
        .mypage-container { flex: 1; }
        body.mypage .auth-link { display: none !important; }
        body.mypage .header-action-area { position: absolute !important; right: 36px !important; }
        body.mypage .user-profile-link { display: flex !important; }
        body.mypage .site-header {
            position: fixed !important; top: 0 !important; left: 0 !important;
            width: 100% !important; height: 78px !important;
            background: #243864 !important;
            display: flex !important; align-items: center !important; justify-content: center !important;
            z-index: 9999 !important;
        }
        body.mypage .site-logo { color: white !important; font-size: 28px !important; font-weight: 800 !important; margin: 0 !important; }
        body.mypage .hamburger-btn {
            position: absolute !important; left: 36px !important;
            width: 42px !important; height: 42px !important;
            border: none !important; border-radius: 12px !important;
            background: rgba(255,255,255,0.15) !important; color: white !important;
            font-size: 22px !important; cursor: pointer;
        }
        body.mypage .user-profile-link {
            width: 46px !important; height: 46px !important;
            border-radius: 50% !important; background: white !important;
            display: flex !important; align-items: center !important; justify-content: center !important;
            text-decoration: none !important;
        }
        body.mypage .user-avatar { color: #243864 !important; font-weight: 700 !important; }
        body.mypage nav.sidebar {
            position: fixed; top: 78px; left: -260px;
            width: 250px; height: calc(100vh - 78px);
            background: white; border-right: 1px solid #ddd;
            transition: all 0.3s ease; z-index: 9998; padding-top: 20px;
        }
        body.mypage nav.sidebar.open { left: 0; }
        body.mypage nav.sidebar ul { list-style: none; padding: 0; margin: 0; }
        body.mypage nav.sidebar li { width: 100%; }
        body.mypage nav.sidebar li a {
            display: flex; align-items: center; height: 54px; padding: 0 24px;
            color: #222; text-decoration: none; font-size: 16px; font-weight: 500;
        }
        body.mypage nav.sidebar li a:hover { background: #f5f5f5; }

        /* 비밀번호 보이기/숨기기 스타일 */
        .password-container { position: relative; width: 100%; }
        .toggle-eye {
            position: absolute; right: 12px; top: 50%;
            transform: translateY(-50%); cursor: pointer;
            font-size: 18px; color: #777;
            user-select: none;
        }

        .form-column { display: flex; flex-direction: column; gap: 15px; }
        .input-with-btn { display: flex; gap: 8px; align-items: center; }

        .btn-action-sm {
            padding: 0 16px; height: 40px; background-color: #645495; color: white;
            border: none; border-radius: 6px; font-size: 13px; font-weight: bold;
            cursor: pointer; white-space: nowrap; transition: background 0.2s;
        }
        .btn-action-sm:hover { background-color: #4f4178; }

        .btn-cancel-sm {
            padding: 0 16px; height: 40px; background-color: #adb5bd; color: white;
            border: none; border-radius: 6px; font-size: 13px; font-weight: bold;
            cursor: pointer; white-space: nowrap; transition: background 0.2s;
        }
        .btn-cancel-sm:hover { background-color: #6c757d; }

        .current-value-input {
            flex: 1; height: 40px; padding: 0 12px;
            background-color: #e9ecef; color: #495057; font-weight: 600;
            border: 1px solid #ced4da; border-radius: 6px;
            cursor: not-allowed;
        }
    </style>
</head>

<body class="mypage">

<%@ include file="/WEB-INF/views/common/layout/header.jspf" %>

<div class="mypage-container">
    <div class="profile-page">
        <div class="profile-card">
            <h3 class="inner-title">내 정보 수정</h3>

            <div class="profile-img-area">
                <label for="profileImageInput" class="profile-circle profile-upload">
                    <img id="profilePreview" src="${pageContext.request.contextPath}/images/profile.jpg" alt="프로필">
                    <div class="profile-overlay">사진 변경</div>
                </label>
                <input type="file" id="profileImageInput" accept="image/*" hidden>
            </div>

            <form class="edit-form" id="profileForm">
                <div class="form-column">
                    <!-- [이메일 섹션] -->
                    <div class="input-item">
                        <label>현재 이메일</label>
                        <div class="input-with-btn">
                            <input type="text" class="current-value-input" readonly
                                   value="${sessionScope.loginUser.loginId != null ? sessionScope.loginUser.loginId : user.loginId}">
                            <input type="hidden" id="curEmail" value="${sessionScope.loginUser.loginId != null ? sessionScope.loginUser.loginId : user.loginId}">
                            <button type="button" class="btn-action-sm" onclick="enableEmailEdit()">변경하기</button>
                        </div>
                    </div>

                    <div class="input-item" id="newEmailArea" style="display: none; margin-top: 10px;">
                        <label>새 이메일 주소 (직접 입력)</label>
                        <div class="input-with-btn">
                            <input type="text" id="emailId" placeholder="example@email.com"
                                   style="flex: 1; height: 40px; padding: 0 10px; border: 1px solid #ced4da; border-radius: 6px;">
                            <button type="button" class="btn-cancel-sm" onclick="cancelEmailEdit()">취소</button>
                        </div>
                    </div>

                    <!-- [닉네임 섹션] -->
                    <div class="input-item" style="margin-top: 10px;">
                        <label>현재 닉네임</label>
                        <div class="input-with-btn">
                            <input type="text" class="current-value-input" readonly
                                   value="${sessionScope.loginUser.nickname != null ? sessionScope.loginUser.nickname : user.nickname}">
                            <input type="hidden" id="curNickname" value="${sessionScope.loginUser.nickname != null ? sessionScope.loginUser.nickname : user.nickname}">
                            <button type="button" class="btn-action-sm" onclick="enableNicknameEdit()">변경하기</button>
                        </div>
                    </div>

                    <div class="input-item" id="newNicknameArea" style="display: none; margin-top: 10px;">
                        <label>새 닉네임 (2~5자)</label>
                        <div class="input-with-btn">
                            <input type="text" id="newNickname" placeholder="변경할 새 닉네임을 입력하세요"
                                   style="flex: 1; height: 40px; padding: 0 10px; border: 1px solid #ced4da; border-radius: 6px;">
                            <button type="button" class="btn-cancel-sm" onclick="cancelNicknameEdit()">취소</button>
                        </div>
                    </div>
                </div>

                <!-- [비밀번호 섹션] -->
                <div class="form-column" style="margin-top: 20px; border-top: 1px solid #eee; padding-top: 20px;">
                    <div class="input-item" style="margin-top: 20px;">
                        <label style="color: #d9534f; font-weight: bold;">현재 비밀번호 <span style="color:red;">*</span></label>
                        <div class="password-container">
                            <input type="password" id="curPw" placeholder="정보 수정을 위해 현재 비밀번호를 입력해주세요"
                                   style="width: 100%; height: 40px; padding: 0 10px; border: 1px solid #ced4da; border-radius: 6px;">
                            <span class="toggle-eye" onclick="togglePassword('curPw', this)">👁</span>
                        </div>
                    </div>
                    <div class="input-item">
                        <label>새 비밀번호 확인 (변경 시에만 입력)</label>
                        <div class="password-container">
                            <input type="password" id="confirmPw" placeholder="새 비밀번호를 다시 입력하세요"
                                   style="width: 100%; height: 40px; padding: 0 10px; border: 1px solid #ced4da; border-radius: 6px;">
                            <span class="toggle-eye" onclick="togglePassword('confirmPw', this)">👁</span>
                        </div>
                    </div>
                </div>
            </form>

            <div class="account-change-section" style="margin-top: 30px;">
                <h3 class="inner-title">AI 멘토 성향 (맵기 단계)</h3>
                <div class="input-item">
                    <label>AI 멘토 성향 선택</label>
                    <select id="mentorTone" class="mentor-select" style="width: 100%; height: 40px; border-radius: 6px; border: 1px solid #ced4da; padding: 0 10px;">
                        <option value="MILD" ${(sessionScope.loginUser.mentorTone == 'MILD' || user.mentorTone == 'MILD') ? 'selected' : ''}>MILD (순한맛)</option>
                        <option value="MEDIUM" ${(sessionScope.loginUser.mentorTone == 'MEDIUM' || user.mentorTone == 'MEDIUM') ? 'selected' : ''}>MEDIUM (중간맛)</option>
                        <option value="SPICY" ${(sessionScope.loginUser.mentorTone == 'SPICY' || user.mentorTone == 'SPICY') ? 'selected' : ''}>SPICY (매운맛)</option>
                    </select>
                </div>
            </div>

            <div class="form-btns">
                <button type="button" class="btn-gray" onclick="history.back()">이전으로</button>
                <button type="button" class="btn-navy" style="background-color: #645495;" onclick="saveProfile()">수정 완료</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/layout/footer.jspf" %>

<script>
    // 비밀번호 보이기/숨기기 토글 함수
    function togglePassword(id, element) {
        const input = document.getElementById(id);
        if (input.type === "password") {
            input.type = "text";
            element.textContent = "🙈"; // 보일 때 아이콘 변경
        } else {
            input.type = "password";
            element.textContent = "👁"; // 숨길 때 아이콘 변경
        }
    }

    function enableEmailEdit() {
        document.getElementById('newEmailArea').style.display = 'block';
        document.getElementById('emailId').focus();
    }
    function cancelEmailEdit() {
        document.getElementById('newEmailArea').style.display = 'none';
        document.getElementById('emailId').value = "";
    }

    function enableNicknameEdit() {
        document.getElementById('newNicknameArea').style.display = 'block';
        document.getElementById('newNickname').focus();
    }
    function cancelNicknameEdit() {
        document.getElementById('newNicknameArea').style.display = 'none';
        document.getElementById('newNickname').value = "";
    }

    function saveProfile() {
            const curEmail = document.getElementById('curEmail').value.trim();
            const curNickname = document.getElementById('curNickname').value.trim();
            const curPw = document.getElementById('curPw').value.trim();

            const emailId = document.getElementById('emailId').value.trim();
            const newNickname = document.getElementById('newNickname').value.trim();
            const confirmPw = document.getElementById('confirmPw').value.trim();
            const mentorTone = document.getElementById('mentorTone').value;

            let finalNewEmail = null;
            if (emailId !== "") finalNewEmail = emailId;

            let finalNickname = curNickname;
            if (newNickname !== "") {
                if (newNickname.length < 2 || newNickname.length > 5) {
                    alert("닉네임은 2~5자여야 합니다.");
                    return;
                }
                finalNickname = newNickname;
            }

            if (curPw === "") {
                alert("정보 수정을 위해 현재 비밀번호를 입력해주세요.");
                return;
            }

            // 1. 기존 텍스트 데이터 묶기
            const requestData = {
                loginId: curEmail,
                newEmail: finalNewEmail,
                nickname: finalNickname,
                currentPassword: curPw,
                newPassword: confirmPw === "" ? null : confirmPw,
                confirmPassword: confirmPw === "" ? null : confirmPw,
                mentorTone: mentorTone
            };

            // ★ 2. 파일과 텍스트를 함께 보낼 수 있는 FormData 생성
            const formData = new FormData();

            // 텍스트 데이터는 'userRequest'라는 이름의 JSON 문자열로 포장해서 넣음
            formData.append('userRequest', new Blob([JSON.stringify(requestData)], { type: "application/json" }));

            // 사진 파일이 선택되었다면 'profileImage'라는 이름으로 넣음
            const fileInput = document.getElementById('profileImageInput');
            if (fileInput.files.length > 0) {
                formData.append('profileImage', fileInput.files[0]);
            }

            // 3. fetch 요청 (★ headers에서 'Content-Type'을 지워야 브라우저가 알아서 Multipart로 보냅니다!)
            fetch('${pageContext.request.contextPath}/user/updateProfile', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    alert("정보가 수정되었습니다.");
                    location.href = '${pageContext.request.contextPath}/mypage';
                } else {
                    alert(data.message || "수정에 실패했습니다.");
                }
            })
            .catch(err => {
                console.error(err);
                alert("서버 연결 실패");
            });
        }

    //  프로필 사진 선택 시 미리보기 기능
        document.getElementById('profileImageInput').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profilePreview').src = e.target.result;
                }
                reader.readAsDataURL(file);
            }
        });
</script>
</body>
</html>
