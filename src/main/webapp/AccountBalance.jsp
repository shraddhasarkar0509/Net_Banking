
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Check login session
    javax.servlet.http.HttpSession userSession =
            request.getSession(false);

    if (userSession == null ||
        userSession.getAttribute("cid") == null) {

        response.sendRedirect("Login.jsp");
        return;
    }

    // CID comes only from login session
    String cid = (String) userSession.getAttribute("cid");

    String accountNo =
            (String) request.getAttribute("accountNo");

    Object balance =
            request.getAttribute("balance");

    String errorMessage =
            (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>ACCOUNT BALANCE</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    min-height: 100vh;
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #dff6ff, #eef8ff, #ffffff);
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 30px;
}

/* Decorative circles */

body::before {
    content: "";
    position: fixed;
    width: 260px;
    height: 260px;
    border-radius: 50%;
    background: rgba(38, 149, 199, 0.12);
    top: -90px;
    left: -80px;
}

body::after {
    content: "";
    position: fixed;
    width: 320px;
    height: 320px;
    border-radius: 50%;
    background: rgba(83, 190, 150, 0.10);
    bottom: -130px;
    right: -100px;
}

/* Main card */

.balance-card {
    position: relative;
    z-index: 1;
    width: 100%;
    max-width: 500px;
    background: rgba(255, 255, 255, 0.97);
    padding: 40px;
    border-radius: 24px;
    border: 1px solid #e1edf5;
    box-shadow: 0 18px 45px rgba(45, 85, 120, 0.16);
}

/* Heading */

h1 {
    text-align: center;
    color: #1769aa;
    font-size: 30px;
    margin: 0 0 8px;
    letter-spacing: 0.5px;
}

.subtitle {
    text-align: center;
    color: #7c8b97;
    font-size: 14px;
    margin-bottom: 28px;
}

/* Logged-in customer */

.session-box {
    background: #eef8ff;
    border: 1px solid #d6eaf7;
    border-radius: 10px;
    padding: 13px 16px;
    margin-bottom: 25px;
    color: #555;
    font-size: 14px;
}

.session-box strong {
    color: #1769aa;
}

/* Form */

label {
    display: block;
    margin-bottom: 8px;
    color: #405563;
    font-size: 14px;
    font-weight: bold;
}

.account-input {
    width: 100%;
    height: 52px;
    padding: 0 16px;
    border: 2px solid #e0e9f0;
    border-radius: 11px;
    background: #fbfdff;
    font-size: 14px;
    outline: none;
    transition: 0.25s;
}

.account-input:hover {
    border-color: #b7d5e8;
}

.account-input:focus {
    border-color: #2695c7;
    background: #ffffff;
    box-shadow: 0 0 0 4px rgba(38, 149, 199, 0.12);
}

/* Button */

.check-btn {
    width: 100%;
    height: 52px;
    margin-top: 20px;
    border: none;
    border-radius: 11px;
    background: linear-gradient(135deg, #2695c7, #1769aa);
    color: white;
    font-size: 16px;
    font-weight: bold;
    letter-spacing: 0.5px;
    cursor: pointer;
    transition: 0.25s;
}

.check-btn:hover {
    background: linear-gradient(135deg, #1769aa, #105487);
    transform: translateY(-2px);
    box-shadow: 0 8px 18px rgba(23, 105, 170, 0.25);
}

/* Balance result */

.balance-box {
    margin-top: 25px;
    padding: 23px;
    text-align: center;
    background: #effbf4;
    border: 1px solid #ccebd8;
    border-radius: 14px;
}

.account-number {
    color: #1769aa;
    font-size: 16px;
    font-weight: bold;
}

.balance-label {
    color: #71808a;
    font-size: 13px;
    margin-top: 12px;
}

.balance {
    color: #168447;
    font-size: 30px;
    font-weight: bold;
    margin-top: 5px;
}

/* Error */

.error-box {
    margin-top: 20px;
    padding: 14px;
    background: #fff1f1;
    border-left: 4px solid #dc3545;
    border-radius: 8px;
    color: #c82333;
    text-align: center;
    font-size: 14px;
}

/* Security note */

.security {
    text-align: center;
    margin-top: 25px;
    color: #8997a3;
    font-size: 12px;
}

</style>

</head>

<body>

<div class="balance-card">

    <h1>ACCOUNT BALANCE</h1>

    <div class="subtitle">
        Check the balance of your account
    </div>

    <div class="session-box">

        <strong>Logged-in Customer ID:</strong>
        <%= cid %>

    </div>

    <form action="AccountBalanceServe" method="post">

        <label for="accNo">
            Account Number
        </label>

        <input type="text"
               id="accNo"
               name="accNo"
               class="account-input"
               placeholder="ENTER YOUR ACCOUNT NUMBER"
               required>

        <input type="submit"
               value="CHECK BALANCE"
               class="check-btn">
               
         <button type="button"
            class="check-btn"
            onclick="window.location.href='NavClient.jsp'">
        BACK TO DASHBOARD
    </button>

    </form>

    <% if (balance != null) { %>

        <div class="balance-box">

            <div class="account-number">
                Account: <%= accountNo %>
            </div>

            <div class="balance-label">
                Available Balance
            </div>

            <div class="balance">
                ₹ <%= balance %>
            </div>

        </div>

    <% } %>

    <% if (errorMessage != null) { %>

        <div class="error-box">
            <%= errorMessage %>
        </div>

    <% } %>

    <div class="security">
        🔒 Balance can be viewed only for accounts linked to your CID
    </div>

</div>

</body>

</html>
