// 전역 변수 선언
let expenseChart = null;
let comparisonChart = null;

// ==========================================
// 1. 차트 초기화 (그라데이션 색상 자동 매핑)
// ==========================================
function getGradientColors(dataArray) {
    const palette = ['#112D4E', '#1C4272', '#285896', '#3F72AF', '#6690C4', '#8DAED9', '#B5CBEF', '#DBE2EF', '#EAECEF', '#F9F7F7'];
    let mapped = dataArray.map((val, idx) => ({ val: Number(val), idx: idx }));
    mapped.sort((a, b) => b.val - a.val);
    let colors = new Array(dataArray.length);
    mapped.forEach((item, rank) => { colors[item.idx] = palette[Math.min(rank, palette.length - 1)]; });
    return colors;
}

function initChart() {
    const ctx = document.getElementById('expenseChart');
    if (!ctx) return;
    const datasets = window.chartDataSets;
    if (!datasets || !datasets['all']) return;
    const initialData = datasets['all'];
    const dynamicColors = getGradientColors(initialData.data);

    expenseChart = new Chart(ctx.getContext('2d'), {
        type: 'doughnut',
        data: {
            labels: initialData.labels,
            datasets: [{ data: initialData.data, backgroundColor: dynamicColors, borderWidth: 2, borderColor: '#ffffff' }]
        },
        options: { responsive: true, maintainAspectRatio: false, cutout: '60%', plugins: { legend: { position: 'right' } } }
    });
}

function initComparisonChart() {
    const ctx = document.getElementById('comparisonChart');
    const barData = window.barChartData;
    const labels = window.monthLabels;
    if (!ctx || !barData) return;

    comparisonChart = new Chart(ctx.getContext('2d'), {
        type: 'bar',
        data: {
            labels: barData.labels,
            datasets: [
                { label: '저번 달 (' + (labels ? labels.last : '') + ')', data: barData.lastMonth, backgroundColor: '#DBE2EF', borderRadius: 4 },
                { label: '이번 달 (' + (labels ? labels.current : '') + ')', data: barData.thisMonth, backgroundColor: '#3F72AF', borderRadius: 4 }
            ]
        },
        options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true, ticks: { callback: v => v.toLocaleString() + '원' } } } }
    });
}

window.updateChart = function(type, event) {
    if (!expenseChart || !window.chartDataSets) return;
    document.querySelectorAll('.toggle-btn').forEach(btn => btn.classList.remove('active'));
    if (event) event.currentTarget.classList.add('active');

    const newData = window.chartDataSets[type];
    if (!newData) return;
    const newColors = getGradientColors(newData.data);

    expenseChart.data.labels = newData.labels;
    expenseChart.data.datasets[0].data = newData.data;
    expenseChart.data.datasets[0].backgroundColor = newColors;
    expenseChart.update();

    const summaryTextElement = document.getElementById('totalSummaryText');
    if (summaryTextElement) {
        summaryTextElement.innerHTML = '이번 달 ' + newData.text + '은 총 <strong>' + Number(newData.total || 0).toLocaleString() + '원</strong>입니다.';
    }
}

// ==========================================
// 2. 모달 열기/닫기 및 로직 (충돌 방지 완벽 적용)
// ==========================================
let currentTab = 'daily';
let selectedCategoryName = null;
let selectedCategoryId = null;
let editSelectedCategoryId = null;
let editSelectedCategoryName = null;
let pendingEntries = [];

function formatNumber(input) {
    let value = input.value.replace(/[^0-9]/g, '');
    input.value = value ? Number(value).toLocaleString() : '';
}

function getTodayDate() {
    return new Date().toISOString().substring(0, 10);
}

// 탭 전환
window.switchTab = function(tab, event) {
    currentTab = tab;
    document.querySelectorAll('#modalTabs .tab-btn').forEach(btn => btn.classList.remove('active'));
    if(event) event.currentTarget.classList.add('active');
    renderEnteredList();
}

// 카테고리 클릭
document.querySelectorAll('#categoryContainer .cat-box').forEach(box => {
    box.addEventListener('click', function() {
        document.querySelectorAll('#categoryContainer .cat-box').forEach(c => c.classList.remove('active'));
        this.classList.add('active');
        selectedCategoryId = this.getAttribute('data-id');
        selectedCategoryName = this.getAttribute('data-name');
    });
});

// 🎯 목표 모달 열기/닫기
window.openGoalModal = function() {
    document.getElementById('goalRegistrationModal').style.display = 'flex';
    document.body.style.overflow = 'hidden';
};

window.closeGoalModal = function() {
    document.getElementById('goalRegistrationModal').style.display = 'none';
    document.body.style.overflow = '';
};

// 💳 지출 모달 열기/닫기 (여기가 핵심입니다!)
window.openExpenseModal = function(mode) {
    const modal = document.getElementById('quickEntryModal');
    if (!modal) return;

    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';

    if (mode === 'create') {
        document.getElementById('amountInput').value = '';
        const dateInput = document.getElementById('expenseDateInput');
        if(dateInput) dateInput.value = getTodayDate();
        document.querySelectorAll('#categoryContainer .cat-box').forEach(c => c.classList.remove('active'));
        selectedCategoryId = null;
        selectedCategoryName = null;
        pendingEntries = [];

        const firstTab = document.querySelector('#modalTabs .tab-btn');
        if(firstTab) firstTab.click();
    }
};

window.closeExpenseModal = function() {
    const modal = document.getElementById('quickEntryModal');
    if(modal) {
        modal.style.display = 'none';
        document.body.style.overflow = '';
    }
};

// 배경 클릭 시 닫기
window.onclick = function(event) {
    const expenseModal = document.getElementById('quickEntryModal');
    const goalModal = document.getElementById('goalRegistrationModal');
    const editExpenseModal = document.getElementById('editExpenseModal');

    if (event.target === expenseModal) closeExpenseModal();
    if (event.target === goalModal) closeGoalModal();
    if (event.target === editExpenseModal) closeEditModal();
};

// 지출 리스트에 추가
window.addToList = function() {
    const amountVal = document.getElementById('amountInput').value.replace(/[^0-9]/g, '');
    const selectedDate = document.getElementById('expenseDateInput').value || getTodayDate();

    if (!selectedCategoryId) { alert('카테고리를 선택해 주세요.'); return; }
    if (!amountVal) { alert('금액을 입력해 주세요.'); return; }

    pendingEntries.push({
        type: currentTab,
        categoryId: selectedCategoryId,
        name: selectedCategoryName,
        amount: parseInt(amountVal),
        expenseDate: selectedDate
    });

    document.getElementById('amountInput').value = '';
    renderEnteredList();
}

// 리스트 렌더링
function renderEnteredList() {
    const container = document.getElementById('enteredList');
    container.innerHTML = '';

    const newItemsWithIndex = pendingEntries.map((e, idx) => ({ ...e, originalIndex: idx }));
    const newItems = newItemsWithIndex.filter(e => e.type === currentTab);
    const dbItems = (window.dbExpenses || []).filter(e => e.type === currentTab);

    if (newItems.length === 0 && dbItems.length === 0) {
        container.innerHTML = '<div class="empty-list">아직 입력된 내역이 없습니다.</div>';
        return;
    }

    const icon = currentTab === 'fixed' ? '🔒' : '💳';
    let html = '';

    function buildGroupHtml(items, groupTitle, isDb) {
        if (items.length === 0) return '';
        let groupHtml = '<div class="list-group-title" style="color: ' + (isDb ? '#8b95a1' : '#3182f6') + ';">' + groupTitle + '</div>';

        items.forEach((entry) => {
            const formattedAmount = Number(entry.amount).toLocaleString();
            const realId = isDb ? entry.id : entry.originalIndex;
            const clickEvent = 'onclick="openEditModal(\'' + realId + '\', ' + isDb + ')"';

            groupHtml +=
                '<div class="list-item" ' + clickEvent + ' style="cursor: pointer;">' +
                    '<div class="item-left">' +
                        '<div class="item-icon">' + icon + '</div>' +
                        '<div class="item-details">' +
                            '<div class="item-title">' + entry.name + '</div>' +
                            '<div class="item-subtitle">' + (entry.expenseDate || '날짜 없음') + '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="item-right">' +
                        '<div class="item-amount" style="color: #e57373;">' +
                            '-₩' + formattedAmount +
                        '</div>' +
                    '</div>' +
                '</div>';
        });
        return groupHtml;
    }

    html += buildGroupHtml(newItems, '✨ 새로 추가된 내역 (저장 대기중)', false);
    html += buildGroupHtml(dbItems, '🗂️ 기존 저장된 내역', true);

    container.innerHTML = html;
}

// ==========================================
// 3. 데이터 저장 및 수정 모달 로직
// ==========================================
window.saveGoalData = function() {
    const name = document.getElementById('regGoalName').value;
    const amount = document.getElementById('regGoalAmount').value.replace(/[^0-9]/g, '');

    if (!name || !amount) {
        alert("목표 이름과 금액을 모두 입력해주세요.");
        return;
    }

    fetch('/api/v1/goals', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ userId: 1, itemName: name, itemPrice: parseInt(amount) })
    }).then(res => {
        if (res.ok) {
            alert("목표가 성공적으로 설정되었습니다!");
            location.reload();
        } else {
            alert("목표 저장에 실패했습니다.");
        }
    });
};

window.saveAllData = function() {
    if (pendingEntries.length === 0) {
        alert("새로 추가된 내역이 없습니다! 하단의 '추가하기' 버튼을 눌러 먼저 리스트에 등록해주세요.");
        return;
    }

    const userId = 1;
    const requests = pendingEntries.map(entry => {
        return fetch('/api/v1/expenses', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                userId: userId,
                categoryId: parseInt(entry.categoryId),
                amount: entry.amount,
                expenseDate: entry.expenseDate,
                isFixed: entry.type === 'fixed' ? 'Y' : 'N'
            })
        });
    });

    Promise.all(requests)
        .then(responses => {
            const allOk = responses.every(r => r.ok);
            if (allOk) {
                alert('총 ' + pendingEntries.length + '건의 신규 내역이 성공적으로 저장되었습니다!');
                location.reload();
            } else {
                alert('일부 내역 저장에 실패했습니다. 백엔드 연결을 확인해주세요.');
            }
        });
};

// 수정 모달
document.querySelectorAll('#editCategoryContainer .edit-cat').forEach(box => {
    box.addEventListener('click', function() {
        document.querySelectorAll('#editCategoryContainer .edit-cat').forEach(c => c.classList.remove('active'));
        this.classList.add('active');
        editSelectedCategoryId = this.getAttribute('data-id');
        editSelectedCategoryName = this.getAttribute('data-name');
    });
});

window.openEditModal = function(id, isDb) {
    let item = isDb ? window.dbExpenses.find(e => e.id == id) : pendingEntries[id];
    if (!item) return;

    document.getElementById('editExpenseModal').style.display = 'flex';
    document.getElementById('editTargetId').value = id;
    document.getElementById('editTargetIsDb').value = isDb;

    document.getElementById('editOriginalAmountDisplay').innerText = Number(item.amount).toLocaleString() + '원';
    document.getElementById('editAmountInput').value = Number(item.amount).toLocaleString();
    document.getElementById('editExpenseDateInput').value = item.expenseDate || getTodayDate();

    document.querySelectorAll('#editCategoryContainer .edit-cat').forEach(c => {
        c.classList.remove('active');
        if (c.getAttribute('data-id') == item.categoryId) {
            c.classList.add('active');
            editSelectedCategoryId = item.categoryId;
            editSelectedCategoryName = item.name;
        }
    });
}

window.closeEditModal = function() {
    document.getElementById('editExpenseModal').style.display = 'none';
}

window.submitEdit = function() {
    const id = document.getElementById('editTargetId').value;
    const isDb = document.getElementById('editTargetIsDb').value === 'true';
    const amountVal = document.getElementById('editAmountInput').value.replace(/[^0-9]/g, '');
    const dateVal = document.getElementById('editExpenseDateInput').value;

    if (!editSelectedCategoryId || !amountVal) { alert("카테고리와 금액을 모두 입력해주세요."); return; }

    if (isDb) {
        fetch('/api/v1/expenses/' + id, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ categoryId: parseInt(editSelectedCategoryId), amount: parseInt(amountVal), expenseDate: dateVal, isFixed: currentTab === 'fixed' ? 'Y' : 'N' })
        }).then(res => {
            if(res.ok) { alert("수정되었습니다."); location.reload(); }
            else { alert("수정 실패"); }
        });
    } else {
        pendingEntries[id].categoryId = editSelectedCategoryId;
        pendingEntries[id].name = editSelectedCategoryName;
        pendingEntries[id].amount = parseInt(amountVal);
        pendingEntries[id].expenseDate = dateVal;
        closeEditModal();
        renderEnteredList();
    }
}

window.submitDelete = function() {
    const id = document.getElementById('editTargetId').value;
    const isDb = document.getElementById('editTargetIsDb').value === 'true';

    if(!confirm("정말 삭제하시겠습니까?")) return;

    if (isDb) {
        fetch('/api/v1/expenses/' + id, { method: 'DELETE' })
        .then(res => {
            if(res.ok) { alert("삭제되었습니다."); location.reload(); }
            else { alert("삭제 실패"); }
        });
    } else {
        pendingEntries.splice(id, 1);
        closeEditModal();
        renderEnteredList();
    }
}

window.onload = function() {
    initChart();
    initComparisonChart();
};