document.addEventListener('DOMContentLoaded', function () {
    // 1. URL에서 userId 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    const userId = urlParams.get('userId');

    // 2. 정보 가져오기
    fetch(`/api/admin/users/${userId}`)
        .then(res => res.json())
        .then(data => {
            if (data.ok) {
                const user = data.user;
                // 정보 채우기
                document.getElementById('display-userId').innerText = user.userId;
                document.getElementById('display-loginId').innerText = user.loginId;
                document.getElementById('display-nickname').innerText = user.nickname;
                document.getElementById('display-status').innerText = user.accountStatus;

                // 드롭박스 현재값 설정
                document.getElementById('status-select').value = user.accountStatus;
            }
        });
});