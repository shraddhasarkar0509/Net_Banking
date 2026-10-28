
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>DEPOSIT FAILED</title>

<style>

body {
    margin: 0;
    padding: 0;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #fff0f0 0%, #fff8f8 100%);
}

.failed-card {
    width: 100%;
    max-width: 450px;
    background: #ffffff;
    padding: 40px;
    border-radius: 20px;
    text-align: center;
    box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12);
}

.failed-icon {
    width: 70px;
    height: 70px;
    margin: 0 auto 20px;
    border-radius: 50%;
    background: #fdeaea;
    color: #dc3545;
    font-size: 42px;
    font-weight: bold;
    line-height: 70px;
}

h2 {
    color: #dc3545;
    font-size: 28px;
    margin-bottom: 15px;
}

.message {
    color: #555;
    font-size: 15px;
    margin-bottom: 25px;
}

.warning-box {
    background: #fff4f4;
    border-left: 4px solid #dc3545;
    padding: 15px;
    border-radius: 8px;
    color: #555;
    font-size: 14px;
    margin-bottom: 25px;
    text-align: left;
}

.warning-box ul {
    margin: 8px 0 0;
    padding-left: 20px;
}

.btn {
    display: inline-block;
    text-decoration: none;
    color: white;
    background: #145da0;
    padding: 12px 28px;
    border-radius: 8px;
    font-size: 15px;
    font-weight: bold;
    transition: 0.2s;
}

.btn:hover {
    background: #0d477d;
    transform: translateY(-1px);
    box-shadow: 0 5px 12px rgba(20, 93, 160, 0.25);
}

.security-text {
    margin-top: 22px;
    color: #777;
    font-size: 12px;
}

</style>

</head>

<body>

<div class="failed-card">

    <div class="failed-icon">
        !
    </div>

    <h2>Deposit Failed</h2>

    <div class="message">
        We could not process your deposit.
    </div>

    <div class="warning-box">
        <strong>Please check:</strong>

        <ul>
            <li>Account number is valid</li>
            <li>Deposit amount is greater than zero</li>
            <li>All entered details are correct</li>
            <li>The destination account exists</li>
        </ul>
    </div>

    <a href="Depositform.jsp" class="btn">
        TRY AGAIN
    </a>

    <div class="security-text">
        🔒 Secure Banking Transaction
    </div>

</div>

</body>

</html>
