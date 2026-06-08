document.addEventListener('DOMContentLoaded', function () {
    loadAuditLogs();
});

function loadAuditLogs() {
    fetch('/api/admin/audit-logs')
        .then(response => response.json())
        .then(data => {
            if (data && data.ok) {
                renderAuditLogs(data.logs);
            } else {
                alert('활동 로그를 불러오는데 실패했습니다.');
            }
        })
        .catch(error => console.error('Error fetching audit logs:', error));
}

function renderAuditLogs(logs) {
    const tbody = document.getElementById('audit-table-body');
    tbody.innerHTML = '';

    if (logs.length === 0) {
        tbody.innerHTML = '<tr><td colspan="7" style="text-align: center; padding: 40px 0; color: #888;">활동 로그가 없습니다.</td></tr>';
        return;
    }

    logs.forEach((log, index) => {
        // 날짜 포맷팅 (예: 2026-06-02 12:00)
        const date = new Date(log.createdAt);
        const formattedDate = date.getFullYear() + '-' +
            String(date.getMonth() + 1).padStart(2, '0') + '-' +
            String(date.getDate()).padStart(2, '0') + ' ' +
            String(date.getHours()).padStart(2, '0') + ':' +
            String(date.getMinutes()).padStart(2, '0');

        const tr = document.createElement('tr');
        // 호영님의 애니메이션 효과 추가
        tr.style.animation = 'adminEnter 420ms cubic-bezier(.16, 1, .3, 1) both';
        tr.style.animationDelay = (index * 35) + 'ms';

        tr.innerHTML = `
            <td>${log.logId}</td>
            <td style="font-weight: bold; color: #0b2c5f;">${log.adminNickname}</td>
            <td><span class="admin-badge badge-gray">${log.actionType}</span></td>
            <td>${log.targetTable}</td>
            <td>${log.targetId}</td>
            <td>${log.ipAddress}</td>
            <td>${formattedDate}</td>
        `;
        tbody.appendChild(tr);
    });
}