
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>LOGIN FORM</title>

<link rel="stylesheet"
href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    min-height: 100vh;
    font-family: Arial, sans-serif;
    background: linear-gradient(120deg, #dff3ff, #eef5ff, #ffffff);
    display: flex;
    justify-content: center;
    align-items: center;
}

/* Decorative background circles */
body::before,
body::after {
    content: "";
    position: fixed;
    border-radius: 50%;
    z-index: 0;
}

body::before {
    width: 280px;
    height: 280px;
    background: rgba(64, 158, 255, 0.15);
    top: -80px;
    left: -70px;
}

body::after {
    width: 350px;
    height: 350px;
    background: rgba(120, 190, 255, 0.12);
    bottom: -130px;
    right: -100px;
}

.login-card {
    position: relative;
    z-index: 1;
    width: 100%;
    max-width: 430px;
    padding: 42px !important;
    background: rgba(255, 255, 255, 0.96);
    border: 1px solid #e1ebf5;
    border-radius: 24px;
    box-shadow: 0 18px 45px rgba(46, 91, 130, 0.16);
}

.login-title {
    color: #1769aa;
    font-size: 30px;
    font-weight: 700;
    letter-spacing: 1px;
    margin-bottom: 8px !important;
}

.subtitle {
    text-align: center;
    color: #7b8b9a;
    font-size: 14px;
    margin-bottom: 30px;
}

.form-group {
    position: relative;
}

.form-control {
    height: 52px;
    border: 2px solid #e2eaf2;
    border-radius: 12px;
    background: #f9fcff;
    padding: 0 16px;
    font-size: 14px;
    transition: 0.25s;
}

.form-control:hover {
    border-color: #a9ccec;
}

.form-control:focus {
    border-color: #3692d4;
    background: #ffffff;
    box-shadow: 0 0 0 4px rgba(54, 146, 212, 0.12);
    outline: none;
}

.form-control::placeholder {
    color: #9aa8b5;
}

.login-btn {
    height: 52px;
    border: none;
    border-radius: 12px;
    background: linear-gradient(135deg, #2186c4, #1769aa);
    font-size: 16px;
    font-weight: bold;
    letter-spacing: 0.7px;
    transition: 0.25s;
}

.login-btn:hover {
    background: linear-gradient(135deg, #1769aa, #105487);
    transform: translateY(-2px);
    box-shadow: 0 8px 18px rgba(23, 105, 170, 0.25);
}

.security-text {
    text-align: center;
    margin-top: 25px;
    color: #8a98a5;
    font-size: 12px;
}

</style>

</head>

<body>

<div class="card login-card">

    <h2 class="text-center login-title">
        LOGIN FORM
    </h2>

    <div class="subtitle">
        Welcome back to secure banking
    </div>

    <form action="LoginServe" method="post">

        <div class="form-group mb-3">

            <input type="text"
                   name="cid"
                   class="form-control"
                   placeholder="ENTER CID"
                   required>

        </div>

        <div class="form-group mb-4">

            <input type="password"
                   name="pass"
                   class="form-control"
                   placeholder="ENTER THE PASSWORD"
                   required>

        </div>

        <input type="submit"
               class="btn btn-primary btn-block login-btn"
               value="LOGIN">
               
       <button type="button"
        class="btn btn-primary btn-block login-btn mt-3"
        onclick="window.location.href='Login_Register.jsp'">
    BACK TO DASHBOARD
</button>        

    </form>

    <div class="security-text">
        🔐 Your banking information is protected
    </div>

</div>

</body>
</html>
