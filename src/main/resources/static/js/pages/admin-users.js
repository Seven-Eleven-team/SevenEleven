document.addEventListener('DOMContentLoaded', function () {
    loadUserList();
});

function loadUserList() {
    fetch('/api/admin/users')
        .then(response => {
            if (response.status === 403) {
                alert('관리자 권한이 필요합니다.');
                window.location.href = '/';
                return;
            }
            return response.json();
        })
        .then(data => {
            if (data && data.ok) {
                renderUsers(data.users);
            } else {
                alert(data.message || '회원 목록을 불러오는데 실패했습니다.');
            }
        })
        .catch(error => console.error('Error fetching users:', error));
}

function renderUsers(users) {
    const tbody = document.getElementById('user-table-body');
    tbody.innerHTML = '';

    if (users.length === 0) {
        tbody.innerHTML = '<tr><td colspan="7" style="text-align: center; padding: 40px 0; color: #888;">등록된 회원이 없습니다.</td></tr>';
        return;
    }

    users.forEach(user => {
        const roleBadge = user.role === 'ADMIN' ? 'badge-blue' : 'badge-gray';

        let statusBadge = 'badge-red';
        if (user.accountStatus === 'ACTIVE') statusBadge = 'badge-green';
        else if (user.accountStatus === 'SUSPENDED') statusBadge = 'badge-yellow';

        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${user.userId}</td>
            <td>${user.loginId}</td>
            <td>${user.nickname}</td>
            <td><span class="admin-badge ${roleBadge}">${user.role}</span></td>
            <td><span class="admin-badge ${statusBadge}">${user.accountStatus}</span></td>
            <td>${user.isNotiEnabled}</td>
            <td class="admin-actions">
                <a class="admin-btn admin-link" href="/admin/users/detail?userId=${user.userId}">상세보기</a>
                <a class="admin-btn ghost admin-link" href="/admin/users/status?userId=${user.userId}">상태변경</a>
            </td>
        `;
        tbody.appendChild(tr);
    });
}