
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Login Error</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    min-height: 100vh;

    display: flex;
    justify-content: center;
    align-items: center;

    font-family: Arial, Helvetica, sans-serif;

    background: linear-gradient(135deg, #fff1f2, #ffe4e6);
}

/* Error Card */

.error-container {
    width: 420px;

    background: white;

    padding: 40px 35px;

    border-radius: 16px;

    text-align: center;

    box-shadow: 0 10px 30px rgba(180, 0, 0, 0.15);

    border-top: 6px solid #dc2626;
}

/* Error Icon */

.error-icon {
    width: 70px;
    height: 70px;

    margin: 0 auto 20px;

    border-radius: 50%;

    background: #fee2e2;

    color: #dc2626;

    display: flex;
    justify-content: center;
    align-items: center;

    font-size: 38px;
    font-weight: bold;
}

/* Heading */

.error-container h2 {
    margin: 5px 0 12px;

    color: #b91c1c;

    font-size: 25px;
}

/* Message */

.error-message {
    color: #666;

    font-size: 15px;

    line-height: 1.6;

    margin-bottom: 25px;
}

/* Warning Box */

.warning-box {
    background: #fff5f5;

    border: 1px solid #fecaca;

    border-left: 5px solid #dc2626;

    border-radius: 7px;

    padding: 12px;

    color: #7f1d1d;

    font-size: 14px;

    margin-bottom: 25px;
}

/* Button */

.back-btn {
    display: inline-block;

    width: 100%;

    padding: 12px;

    background: #dc2626;

    color: white;

    text-decoration: none;

    border-radius: 7px;

    font-size: 15px;

    font-weight: bold;

    transition: 0.2s;
}

.back-btn:hover {
    background: #b91c1c;
}

/* Footer */

.footer {
    margin-top: 18px;

    font-size: 12px;

    color: #999;
}

</style>

</head>

<body>

<div class="error-container">

    <div class="error-icon">
        !
    </div>

    <h2>Invalid Username or Password</h2>

    <p class="error-message">
        We couldn't verify your login details.
        Please check your username and password
        and try again.
    </p>

    <div class="warning-box">
        <strong>Login failed.</strong><br>
        Make sure you are using the correct credentials.
    </div>

    <a href="Login.jsp" class="back-btn">
        Try Again
    </a>

    <div class="footer">
        Please contact the bank if you continue to experience problems.
    </div>

</div>

</body>
</html>
