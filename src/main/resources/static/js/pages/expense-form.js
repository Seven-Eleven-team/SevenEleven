const todayString = new Date().toISOString().split('T')[0];

function addExpenseRow(type) {
    const container = type === 'fixed'
        ? document.getElementById('fixedExpenseContainer')
        : document.getElementById('dailyExpenseContainer');

    const rowHtml = `
        <div class="expense-row" style="display: flex; align-items: center; margin-bottom: 10px;">
            <select class="category-input" style="flex: 1; margin-right: 10px;">
                <option value="1">주거비 (월세 등)</option>
                <option value="2">통신비</option>
                <option value="3">식비 (카페, 음식)</option>
                <option value="4">교통비</option>
                <option value="5">오락/문화</option>
            </select>
            <input type="number" class="amount-input" placeholder="금액 입력" style="flex: 1; margin-right: 10px;">
            <button type="button" onclick="this.parentElement.remove()">-</button>
        </div>
    `;
    container.insertAdjacentHTML('beforeend', rowHtml);
}

function addGoalRow() {
    const container = document.getElementById('goalContainer');

    const rowHtml = `
        <div class="goal-row" style="display: flex; align-items: center; margin-bottom: 10px;">
            <input type="text" class="name-input" placeholder="목표 이름 (예: 1억모으기)" style="flex: 1; margin-right: 10px;">
            <input type="number" class="amount-input" placeholder="목표 금액" style="flex: 1; margin-right: 10px;">
            <button type="button" onclick="this.parentElement.remove()">-</button>
        </div>
    `;
    container.insertAdjacentHTML('beforeend', rowHtml);
}

function submitAllData() {
    const expenseData = [];
    const goalData = [];

    document.querySelectorAll('#fixedExpenseContainer .expense-row').forEach(row => {
        expenseData.push({
            categoryId: parseInt(row.querySelector('.category-input').value),
            amount: parseInt(row.querySelector('.amount-input').value),
            expenseDate: todayString,
            isFixed: "Y"
        });
    });

    document.querySelectorAll('#dailyExpenseContainer .expense-row').forEach(row => {
        expenseData.push({
            categoryId: parseInt(row.querySelector('.category-input').value),
            amount: parseInt(row.querySelector('.amount-input').value),
            expenseDate: todayString,
            isFixed: "N"
        });
    });

    document.querySelectorAll('#goalContainer .goal-row').forEach(row => {
        goalData.push({
            itemName: row.querySelector('.name-input').value,
            itemPrice: parseInt(row.querySelector('.amount-input').value)
        });
    });

    const expensePromise = expenseData.length > 0
        ? fetch('/api/v1/expenses', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(expenseData)
          })
        : Promise.resolve();

    const goalPromise = goalData.length > 0
        ? fetch('/api/v1/goals', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(goalData)
          })
        : Promise.resolve();

    Promise.all([expensePromise, goalPromise])
        .then(() => {
            alert("지출 및 목표가 성공적으로 등록되었습니다! 🎉");
            window.location.href = "/dashboard";
        })
        .catch(error => {
            console.error("데이터 저장 중 오류:", error);
            alert("저장에 실패했습니다. 다시 시도해 주세요.");
        });
}

window.onload = function() {
    addExpenseRow('fixed');
    addExpenseRow('daily');
    addGoalRow();
};