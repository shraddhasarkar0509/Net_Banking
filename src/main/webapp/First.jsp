
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>NetBanking Login</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #061a2b, #0d4668, #16809b);
        }

        .page {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .logo {
            position: absolute;
            top: 30px;
            left: 50px;
            color: white;
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 2px;
        }

        .login-box {
            width: 420px;
            padding: 40px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
        }

        .bank-icon {
            width: 70px;
            height: 70px;
            margin: 0 auto 20px;
            background: #123f5e;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 32px;
        }

        .login-box h1 {
            text-align: center;
            color: #123f5e;
            font-size: 28px;
            margin-bottom: 8px;
        }

        .login-box .welcome {
            text-align: center;
            color: #777;
            font-size: 14px;
            margin-bottom: 30px;
        }

        label {
            display: block;
            color: #333;
            font-weight: bold;
            margin-bottom: 7px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
        }

        input:focus {
            border-color: #123f5e;
        }

        .login-button {
            width: 100%;
            padding: 13px;
            background: #123f5e;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }

        .login-button:hover {
            background: #0b2f47;
        }

        .register-option {
            text-align: center;
            margin-top: 18px;
            font-size: 13px;
            color: #777;
        }

        .register-option a {
            color: #123f5e;
            font-weight: bold;
            text-decoration: none;
            margin-left: 4px;
        }

        .register-option a:hover {
            text-decoration: underline;
        }

        .security {
            text-align: center;
            color: #777;
            font-size: 12px;
            margin-top: 20px;
        }

        .error {
            text-align: center;
            color: red;
            margin-top: 15px;
            font-size: 14px;
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #123f5e;
            text-decoration: none;
            font-size: 13px;
        }

        .back:hover {
            text-decoration: underline;
        }

        .copyright {
            position: absolute;
            bottom: 15px;
            color: #d5e4eb;
            font-size: 12px;
        }

        @media (max-width: 500px) {
            .logo {
                left: 20px;
                top: 20px;
                font-size: 18px;
            }

            .login-box {
                width: 90%;
                padding: 30px 25px;
            }
        }
    </style>
</head>

<body>

    <div class="page">

        <div class="logo">
            🏦 NETBANKING
        </div>

        <div class="login-box">

            <div class="bank-icon">
                🏦
            </div>

            <h1>Welcome Back</h1>

            <p class="welcome">
                Login to access your NetBanking account
            </p>

            <form action="LoginServe2" method="post">

                <label>Customer ID</label>

                <input type="text" name="cid" placeholder="Enter your Customer ID" required>

                <label>Password</label>

                <input type="password" name="pass" placeholder="Enter your Password" required>

                <button type="submit" class="login-button"> LOGIN </button>
                
            </form>

            <div class="register-option">
                Don't have a password yet?
                <a href="Login_Register.jsp">Register Your Password</a>
            </div>

            <%
                String message = request.getParameter("message");

                if (message != null) {
            %>

                <p class="error">
                    <%= message %>
                </p>

            <%
                }
            %>

            <p class="security">
                🔒 Secure &nbsp; | &nbsp; Private &nbsp; | &nbsp; Reliable
            </p>

            <a href="FrontPage.jsp" class="back">
                ← Back to Home
            </a>

        </div>

        <p class="copyright">
            © 2026 NetBanking. All Rights Reserved.
        </p>

    </div>

</body>
</html>
