
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>REGISTER FORM</title>

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
    background: linear-gradient(120deg, #fff4df, #f1f8ff, #ffffff);
    display: flex;
    justify-content: center;
    align-items: center;
}

/* Decorative background shapes */
body::before {
    content: "";
    position: fixed;
    width: 300px;
    height: 300px;
    border-radius: 50%;
    background: rgba(255, 193, 87, 0.14);
    top: -100px;
    right: -80px;
}

body::after {
    content: "";
    position: fixed;
    width: 260px;
    height: 260px;
    border-radius: 50%;
    background: rgba(79, 170, 230, 0.12);
    bottom: -90px;
    left: -80px;
}

/* Registration card */
.register-card {
    position: relative;
    z-index: 1;
    width: 100%;
    max-width: 430px;
    padding: 42px !important;
    background: rgba(255, 255, 255, 0.97);
    border: 1px solid #e7edf3;
    border-radius: 24px;
    box-shadow: 0 18px 45px rgba(65, 85, 105, 0.15);
}

.register-title {
    color: #1976a8;
    font-size: 30px;
    font-weight: 700;
    letter-spacing: 1px;
    margin-bottom: 8px !important;
}

.subtitle {
    text-align: center;
    color: #7d8b98;
    font-size: 14px;
    margin-bottom: 30px;
}

.form-control {
    height: 52px;
    border: 2px solid #e3eaf0;
    border-radius: 12px;
    background: #fbfdff;
    padding: 0 16px;
    font-size: 14px;
    transition: 0.25s;
}

.form-control:hover {
    border-color: #b4d2e8;
}

.form-control:focus {
    border-color: #3695c8;
    background: #ffffff;
    box-shadow: 0 0 0 4px rgba(54, 149, 200, 0.12);
    outline: none;
}

.form-control::placeholder {
    color: #9aa7b2;
}

/* Register button */
.register-btn {
    height: 52px;
    border: none;
    border-radius: 12px;
    background: linear-gradient(135deg, #2695c7, #1876a7);
    font-size: 16px;
    font-weight: bold;
    letter-spacing: 0.7px;
    transition: 0.25s;
}

.register-btn:hover {
    background: linear-gradient(135deg, #1876a7, #105b82);
    transform: translateY(-2px);
    box-shadow: 0 8px 18px rgba(24, 118, 167, 0.25);
}

/* Backend alerts */
.alert {
    border-radius: 10px;
    font-size: 14px;
    border: none;
}

/* Footer */
.security-text {
    text-align: center;
    margin-top: 25px;
    color: #8997a3;
    font-size: 12px;
}
.back-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    margin-top: 15px;
    padding: 12px 28px;
    border: none;
    border-radius: 30px;
    background: linear-gradient(135deg, #0d6efd, #084298);
    color: white;
    font-size: 15px;
    font-weight: 600;
    letter-spacing: 0.5px;
    cursor: pointer;
    box-shadow: 0 5px 15px rgba(13, 110, 253, 0.3);
    transition: all 0.3s ease;
}

.back-btn:hover {
    background: linear-gradient(135deg, #084298, #052c65);
    box-shadow: 0 8px 20px rgba(13, 110, 253, 0.45);
    transform: translateY(-3px);
}

.back-btn:active {
    transform: translateY(0);
}

</style>

</head>

<body>

<div class="card register-card">

    <h2 class="text-center register-title">
        REGISTER FORM
    </h2>

    <div class="subtitle">
        Create your secure banking account
    </div>

    <%-- 📢 DYNAMIC ALERTS TO DISPLAY BACKEND MESSAGES --%>

    <% if (request.getAttribute("successMessage") != null) { %>

        <div class="alert alert-success text-center font-weight-bold"
             role="alert">

            <%= request.getAttribute("successMessage") %>

        </div>

    <% } %>

    <% if (request.getAttribute("errorMessage") != null) { %>

        <div class="alert alert-danger text-center font-weight-bold"
             role="alert">

            <%= request.getAttribute("errorMessage") %>

        </div>

    <% } %>

    <form action="RegisterServe" method="post">

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
               class="btn btn-primary btn-block register-btn"
               value="REGISTER">
               
       <button type="button"
        class="btn btn-primary btn-block register-btn mt-3"
        onclick="window.location.href='Login_Register.jsp'">
    BACK TO DASHBOARD
</button>
    <div class="security-text">
        🔐 Secure banking registration
    </div>

</div>

</body>
</html>