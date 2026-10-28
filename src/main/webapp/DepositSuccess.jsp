
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>DEPOSIT SUCCESS</title>

<style>

body {
    margin: 0;
    padding: 0;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #e8f0ff 0%, #f8fbff 100%);
}

.success-card {
    width: 100%;
    max-width: 450px;
    background: #ffffff;
    padding: 40px;
    border-radius: 20px;
    text-align: center;
    box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12);
}

.success-icon {
    width: 70px;
    height: 70px;
    margin: 0 auto 20px;
    border-radius: 50%;
    background: #e8f7ee;
    color: #28a745;
    font-size: 42px;
    font-weight: bold;
    line-height: 70px;
}

h2 {
    color: #145da0;
    font-size: 28px;
    margin-bottom: 15px;
}

.message {
    color: #555;
    font-size: 15px;
    margin-bottom: 25px;
}

.info-box {
    background: #f1f7ff;
    border-left: 4px solid #145da0;
    padding: 15px;
    border-radius: 8px;
    color: #444;
    font-size: 14px;
    margin-bottom: 25px;
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

<div class="success-card">

    <div class="success-icon">
        ✓
    </div>

    <h2>Deposit Successful</h2>

    <div class="message">
        Your deposit has been successfully processed.
    </div>

    <div class="info-box">
        The deposited amount has been successfully credited
        to the selected account.
    </div>

    <a href="Depositform.jsp" class="btn">
        MAKE ANOTHER DEPOSIT
    </a>

    <div class="security-text">
        🔒 Secure Banking Transaction
    </div>

</div>

</body>

</html>
