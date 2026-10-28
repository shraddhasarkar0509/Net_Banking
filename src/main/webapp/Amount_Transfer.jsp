
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Check logged-in session
    javax.servlet.http.HttpSession userSession =
            request.getSession(false);

    if (userSession == null ||
        userSession.getAttribute("cid") == null) {

        response.sendRedirect("Login.jsp");
        return;
    }

    String cid = (String) userSession.getAttribute("cid");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fund Transfer</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
   background: linear-gradient(135deg, #061a2b, #0d4668, #16809b);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.transfer-container {
    width: 450px;
    background: white;
    padding: 35px;
    border-radius: 16px;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
}

.header {
    text-align: center;
    margin-bottom: 25px;
}

.header h2 {
    margin: 0;
    color: #173b67;
    font-size: 28px;
}

.header p {
    margin-top: 8px;
    color: #777;
    font-size: 14px;
}

/* Minimum balance warning */

.balance-warning {
    background: #fff4e5;
    border-left: 5px solid #f39c12;
    padding: 13px 15px;
    margin-bottom: 25px;
    border-radius: 7px;
    color: #7a4b00;
    font-size: 14px;
    line-height: 1.5;
}

.balance-warning strong {
    color: #c26d00;
}

/* Form */

.form-group {
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
    color: #333;
    font-size: 14px;
}

.form-group input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccd5e0;
    border-radius: 7px;
    font-size: 15px;
    outline: none;
    transition: 0.2s;
}

.form-group input:focus {
    border-color: #2878d0;
    box-shadow: 0 0 0 3px rgba(40, 120, 208, 0.12);
}

/* Transfer button */

.transfer-btn {
    width: 100%;
    padding: 13px;
    margin-top: 8px;
    background: #1769aa;
    color: white;
    border: none;
    border-radius: 7px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
}

.transfer-btn:hover {
    background: #0f4f82;
}

/* Bottom note */

.note {
    text-align: center;
    margin-top: 18px;
    color: #777;
    font-size: 12px;
    line-height: 1.5;
}
.dashboard-btn {
    display: block;
    width: 100%;
    margin-top: 20px;
    padding: 12px;
    background: transparent;
    color: #0d4668;
    border: 2px solid #16809b;
    border-radius: 7px;
    font-size: 15px;
    font-weight: bold;
    text-align: center;
    text-decoration: none;
    transition: 0.3s;
}

.dashboard-btn:hover {
    background: #16809b;
    color: white;
}

</style>

</head>

<body>

<div class="transfer-container">

    <div class="header">
        <h2>Fund Transfer</h2>
        <p>Transfer money securely to another account</p>
    </div>

    <!-- Minimum balance information -->

    <div class="balance-warning">
        <strong>Important:</strong><br>
        A minimum balance of <strong>₹5,000</strong> must be
        maintained in your account after the transfer.
        Please make sure you have sufficient balance before
        proceeding.
    </div>

    <form action="TransferServe" method="post">

        <div class="form-group">
            <label for="sacc">Sender Account Number</label>

            <input type="text"
                   id="sacc"
                   name="sacc"
                   placeholder="Enter your account number"
                   required>
        </div>

        <div class="form-group">
            <label for="bacc">Beneficiary Account Number</label>

            <input type="text"
                   id="bacc"
                   name="bacc"
                   placeholder="Enter beneficiary account number"
                   required>
        </div>

        <div class="form-group">
            <label for="transdt">Transfer Date</label>

            <input type="date"
                   id="transdt"
                   name="transdt"
                   required>
        </div>

        <div class="form-group">
            <label for="amount">Transfer Amount (₹)</label>

            <input type="number"
                   id="amount"
                   name="amount"
                   placeholder="Enter amount"
                   min="0.01"
                   step="0.01"
                   required>
        </div>

        <button type="submit" class="transfer-btn">
            Transfer Money
        </button>

    </form>

    <div class="note">
        Your sender account must belong to your logged-in account.
        <br>
        The beneficiary account can belong to another customer.
    </div>
    <a href="FundTransfer.jsp" class="dashboard-btn">
    &#8592; GO BACK</a>

</div>

</body>
</html>
