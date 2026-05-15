<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>구독 구매</title>

    <script>

        function calculateTotal() {

            const monthlyFee =
                document.getElementById("monthlyFee").value;

            const periodMonths =
                document.getElementById("periodMonths").value;

            const total =
                monthlyFee * periodMonths;

            document.getElementById("totalAmount").value =
                total;
        }

    </script>

</head>

<body>

<h2>OTT 구독 구매</h2>

<form action="/subscription/buy" method="post">

    <!-- OTT 서비스 ID -->
    <div>
        <label>OTT 서비스 ID</label>
        <input
                type="number"
                name="partyId"
                required
        >
    </div>

    <br>

    <!-- 월 요금 -->
    <div>
        <label>월 결제 금액</label>
        <input
                type="number"
                id="monthlyFee"
                name="monthlyFee"
                onkeyup="calculateTotal()"
                required
        >
    </div>

    <br>

    <!-- 구독 개월 수 -->
    <div>

        <label>구독 개월 수</label>

        <select
                id="periodMonths"
                name="periodMonths"
                onchange="calculateTotal()"
        >

            <option value="1">
                1개월
            </option>

            <option value="3">
                3개월
            </option>

            <option value="6">
                6개월
            </option>

        </select>

    </div>

    <br>

    <!-- 총 결제 금액 -->
    <div>

        <label>총 결제 금액</label>

        <input
                type="number"
                id="totalAmount"
                readonly
        >

    </div>

    <br>

    <button type="submit">

        구독 등록

    </button>

</form>

</body>
</html>