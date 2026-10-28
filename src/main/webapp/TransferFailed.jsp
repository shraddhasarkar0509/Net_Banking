
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
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transfer Failed</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    background: #fff5f5;
    min-height: 100vh;

    display: flex;
    justify-content: center;
    align-items: center;
}

.failed-container {
    width: 450px;
    background: white;
    padding: 40px 35px;
    border-radius: 16px;

    box-shadow: 0 8px 30px rgba(180, 0, 0, 0.15);

    text-align: center;

    border-top: 6px solid #dc2626;
}

/* Warning icon */

.warning-icon {
    width: 70px;
    height: 70px;

    margin: 0 auto 20px;

    background: #fee2e2;
    color: #dc2626;

    border-radius: 50%;

    display: flex;
    justify-content: center;
    align-items: center;

    font-size: 38px;
    font-weight: bold;
}

/* Heading */

h2 {
    margin: 5px 0 10px;

    color: #b91c1c;

    font-size: 27px;
}

/* Main message */

.main-message {
    color: #555;
    font-size: 15px;
    margin-bottom: 25px;
}

/* Warning box */

.warning-box {
    background: #fff1f2;

    border: 1px solid #fecaca;
    border-left: 5px solid #dc2626;

    border-radius: 8px;

    padding: 15px;

    text-align: left;

    color: #7f1d1d;

    font-size: 14px;

    line-height: 1.6;

    margin-bottom: 25px;
}

.warning-box strong {
    color: #b91c1c;
}

/* Button */

.back-btn {
    display: inline-block;

    width: 100%;

    padding: 13px;

    background: #dc2626;

    color: white;

    text-decoration: none;

    border-radius: 7px;

    font-size: 16px;
    font-weight: bold;

    transition: 0.2s;
}

.back-btn:hover {
    background: #b91c1c;
}

/* Bottom note */

.note {
    margin-top: 18px;

    color: #888;

    font-size: 12px;
}

</style>

</head>

<body>

<div class="failed-container">

    <div class="warning-icon">
        !
    </div>

    <h2>Transfer Failed</h2>

    <p class="main-message">
        Your fund transfer could not be completed.
        Please check the details and try again.
    </p>

    <div class="warning-box">

        <strong>Please check:</strong>

        <ul>
            <li>The sender account belongs to your account.</li>
            <li>Your balance remains at least <strong>₹5,000</strong> after the transfer.</li>
            <li>The beneficiary account number is valid.</li>
            <li>The transfer amount is greater than zero.</li>
            <li>The sender and beneficiary accounts are different.</li>
        </ul>

    </div>

    <a href="Amount_Transfer.jsp" class="back-btn">
        Try Again
    </a>

    <div class="note">
        For your security, transfers are processed only after
        all account validations are successful.
    </div>

</div>

</body>
</html>
