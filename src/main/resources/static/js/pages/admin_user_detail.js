document.addEventListener('DOMContentLoaded', function () {
    const urlParams = new URLSearchParams(window.location.search);
    const userId = urlParams.get('userId');

    fetch(`/api/admin/users/${userId}`)
        .then(res => res.json())
        .then(data => {
            if (data.ok) {
                const user = data.user;
                document.getElementById('detail-userId').innerText = user.userId;
                document.getElementById('detail-loginId').innerText = user.loginId;
                document.getElementById('detail-nickname').innerText = user.nickname;
                document.getElementById('detail-gender').innerText = user.gender;
                document.getElementById('detail-birthDate').innerText = user.birthDate;
                document.getElementById('detail-provider').innerText = user.provider;
                document.getElementById('detail-is2fa').innerText = user.is2faEnabled;
                document.getElementById('detail-mentorTone').innerText = user.mentorTone;

                // 배지는 innerHTML로 처리
                document.getElementById('detail-role').innerHTML = `<span class="admin-badge ${user.role === 'ADMIN' ? 'badge-blue' : 'badge-gray'}">${user.role}</span>`;

                const statusClass = user.accountStatus === 'ACTIVE' ? 'badge-green' : 'badge-yellow';
                document.getElementById('detail-status').innerHTML = `<span class="admin-badge ${statusClass}">${user.accountStatus}</span>`;

                document.getElementById('detail-noti').innerText = user.isNotiEnabled;
            } else {
                alert(data.message);
            }
        });
});