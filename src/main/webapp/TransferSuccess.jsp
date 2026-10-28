<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transfer Successful</title>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background: #f2f6fb;
    }

    .header {
        background: #0b2d4d;
        color: white;
        padding: 20px;
        text-align: center;
        font-size: 26px;
        font-weight: bold;
    }

    .container {
        width: 500px;
        margin: 70px auto;
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        text-align: center;
    }

    .success-icon {
        width: 75px;
        height: 75px;
        margin: 0 auto 20px;
        border-radius: 50%;
        background: #28a745;
        color: white;
        font-size: 50px;
        line-height: 75px;
    }

    h1 {
        color: #0b2d4d;
        margin-bottom: 10px;
    }

    .message {
        color: #555;
        font-size: 16px;
        margin-bottom: 30px;
    }

    .success-box {
        background: #f1f8f3;
        border: 1px solid #c8e6cf;
        border-radius: 8px;
        padding: 18px;
        margin-bottom: 30px;
        color: #155724;
        font-size: 16px;
    }

    .btn {
        display: inline-block;
        padding: 12px 25px;
        margin: 5px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 15px;
        font-weight: bold;
    }

    .home-btn {
        background: #0b2d4d;
        color: white;
    }

    .transfer-btn {
        background: #e9ecef;
        color: #333;
    }

    .btn:hover {
        opacity: 0.85;
    }
</style>

</head>

<body>

<div class="header">
    Net Banking
</div>

<div class="container">

    <div class="success-icon">
        ✓
    </div>

    <h1>Transfer Successful!</h1>

    <p class="message">
        Your fund transfer has been completed successfully.
    </p>

    <div class="success-box">
        <strong>Transaction Successful</strong>
        <br><br>
        The amount has been transferred successfully
        from the sender account to the beneficiary account.
    </div>

    <a href="NavClient.jsp" class="btn home-btn">
        ← Back to Home
    </a>

    <a href="Amount_Transfer.jsp" class="btn transfer-btn">
        Make Another Transfer
    </a>

</div>

</body>
</html>