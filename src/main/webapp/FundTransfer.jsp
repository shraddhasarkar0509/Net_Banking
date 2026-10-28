<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fund Transfer</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: Arial, Helvetica, sans-serif;
        min-height: 100vh;
        background: linear-gradient(135deg, #061a2b, #0d4668, #16809b);
        color: #ffffff;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    /* Header */
    .header {
        width: 100%;
        padding: 25px 50px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: rgba(3, 18, 32, 0.35);
        border-bottom: 1px solid rgba(255, 255, 255, 0.15);
    }

    .logo {
        font-size: 24px;
        font-weight: bold;
        letter-spacing: 2px;
        color: #ffffff;
    }

    .header-text {
        font-size: 14px;
        color: #bceef2;
        letter-spacing: 1px;
    }

    /* Main container */
    .container {
        width: 90%;
        max-width: 950px;
        margin: 70px auto;
        text-align: center;
    }

    .container h1 {
        font-size: 34px;
        margin-bottom: 15px;
        color: #ffffff;
    }

    .subtitle {
        font-size: 16px;
        color: #c5e5ed;
        margin-bottom: 45px;
        line-height: 1.6;
    }

    /* Service cards */
    .card-container {
        display: flex;
        justify-content: center;
        align-items: stretch;
        gap: 30px;
        flex-wrap: wrap;
    }

    .service-card {
        width: 280px;
        min-height: 230px;
        padding: 35px 25px;
        background: rgba(255, 255, 255, 0.97);
        color: #123047;
        border-radius: 16px;
        text-decoration: none;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }

    .service-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 18px 35px rgba(0, 0, 0, 0.35);
    }

    .card-icon {
        width: 65px;
        height: 65px;
        border-radius: 50%;
        background: #d8f5f5;
        color: #087b8a;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 30px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .service-card h2 {
        font-size: 21px;
        margin-bottom: 12px;
        color: #0d4668;
    }

    .service-card p {
        font-size: 14px;
        color: #5b7180;
        line-height: 1.6;
    }

    /* Back button */
    .back-button {
        display: inline-block;
        margin-top: 45px;
        padding: 13px 30px;
        background: transparent;
        border: 2px solid #50d9df;
        border-radius: 30px;
        color: #ffffff;
        text-decoration: none;
        font-size: 15px;
        font-weight: bold;
        transition: all 0.3s ease;
    }

    .back-button:hover {
        background: #50d9df;
        color: #061a2b;
    }

    /* Footer */
    .footer {
        margin-top: auto;
        width: 100%;
        padding: 18px;
        text-align: center;
        font-size: 12px;
        color: #bceef2;
        background: rgba(3, 18, 32, 0.3);
    }

    /* Responsive design */
    @media (max-width: 600px) {
        .header {
            padding: 20px;
            flex-direction: column;
            gap: 10px;
        }

        .container {
            margin: 45px auto;
        }

        .container h1 {
            font-size: 28px;
        }

        .card-container {
            gap: 20px;
        }

        .service-card {
            width: 100%;
            max-width: 320px;
        }
    }
</style>

</head>

<body>

    <header class="header">
        <div class="logo">NET BANKING</div>
        <div class="header-text">SECURE BANKING SERVICES</div>
    </header>

    <main class="container">

        <h1>Fund Transfer</h1>

        <p class="subtitle">
            Manage your money easily with our secure banking services.
            Choose an option below to continue.
        </p>

        <div class="card-container">

            <a href="Amount_Transfer.jsp" class="service-card">
                <div class="card-icon">&#8596;</div>
                <h2>Amount Transfer</h2>
                <p>Transfer funds from your account to another account securely.</p>
            </a>

            <a href="Depositform.jsp" class="service-card">
                <div class="card-icon">&#8377;</div>
                <h2>Deposit Form</h2>
                <p>Access the deposit form to manage your banking transactions.</p>
            </a>

        </div>

        <a href="NavClient.jsp" class="back-button">
            &#8592; Back to Dashboard
        </a>

    </main>

    <footer class="footer">
        &copy; 2026 Net Banking System | Secure Banking Experience
    </footer>

</body>
</html>
