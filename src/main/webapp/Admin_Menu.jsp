<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Admin Menu | NetBanking</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            min-height: 100vh;
            background:
                linear-gradient(
                    135deg,
                    rgba(5, 22, 43, 0.88),
                    rgba(8, 71, 101, 0.78)
                ),
                url("https://i.pinimg.com/474x/c1/8a/71/c18a71501651544bce43375471ee5da6.jpg");

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            display: flex;
            flex-direction: column;
            color: #ffffff;
        }

        /* Header */
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 22px 7%;
            background: rgba(4, 18, 35, 0.88);
            border-bottom: 1px solid rgba(255, 255, 255, 0.15);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .brand-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, #19a7b5, #087b91);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            font-size: 26px;
            box-shadow: 0 5px 15px rgba(0, 190, 210, 0.2);
        }

        .brand h1 {
            font-size: 23px;
            letter-spacing: 2px;
            font-weight: 750;
        }

        .brand p {
            font-size: 10px;
            letter-spacing: 2px;
            color: #a9c6d8;
            margin-top: 5px;
        }

        .admin-label {
            padding: 10px 16px;
            border: 1px solid rgba(255, 255, 255, 0.25);
            background: rgba(255, 255, 255, 0.07);
            border-radius: 30px;
            font-size: 12px;
            color: #e6f8ff;
            letter-spacing: 1px;
        }

        /* Main Section */
        .container {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 55px 20px;
        }

        .heading {
            text-align: center;
            margin-bottom: 42px;
        }

        .heading .tagline {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 30px;
            background: rgba(24, 184, 194, 0.15);
            border: 1px solid rgba(94, 225, 232, 0.35);
            color: #8af0f1;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 2px;
            margin-bottom: 18px;
        }

        .heading h2 {
            font-size: clamp(32px, 5vw, 45px);
            font-weight: 750;
            letter-spacing: 1px;
            margin-bottom: 14px;
        }

        .heading h2 span {
            color: #58d9df;
        }

        .heading p {
            color: #d2e0ed;
            font-size: 15px;
            line-height: 1.7;
        }

        /* Cards */
        .card-container {
            display: flex;
            justify-content: center;
            align-items: stretch;
            gap: 28px;
            width: 100%;
            max-width: 760px;
        }

        .card {
            width: 320px;
            padding: 35px 28px;
            text-align: center;
            background: rgba(255, 255, 255, 0.96);
            color: #173451;
            border: 1px solid rgba(255, 255, 255, 0.65);
            border-radius: 18px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease,
                        box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 22px 45px rgba(0, 0, 0, 0.3);
        }

        .card-icon {
            width: 76px;
            height: 76px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 22px;
            border-radius: 20px;
            background: #e6f6f8;
            font-size: 37px;
        }

        .card h3 {
            color: #103957;
            font-size: 23px;
            letter-spacing: 1px;
            margin-bottom: 12px;
        }

        .card p {
            color: #718196;
            font-size: 13px;
            line-height: 1.7;
            min-height: 44px;
            margin-bottom: 23px;
        }

        /* Card Buttons */
        .button {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
            width: 100%;
            padding: 14px 20px;
            background: linear-gradient(135deg, #087f91, #075b7a);
            color: #ffffff;
            text-decoration: none;
            border-radius: 9px;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 1px;
            box-shadow: 0 6px 15px rgba(8, 100, 130, 0.18);
            transition: background 0.25s ease,
                        transform 0.25s ease;
        }

        .button:hover {
            background: linear-gradient(135deg, #075b7a, #063c61);
            transform: translateY(-2px);
        }

        .button-arrow {
            font-size: 19px;
        }

        /* Back to Home */
        .home-button {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 38px;
            padding: 14px 28px;
            border: 1px solid rgba(255, 255, 255, 0.55);
            border-radius: 9px;
            color: #ffffff;
            background: rgba(255, 255, 255, 0.09);
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 1px;
            transition: all 0.25s ease;
        }

        .home-button:hover {
            background: #ffffff;
            color: #0b3d5c;
            transform: translateY(-3px);
        }

        .home-icon {
            font-size: 17px;
        }

        /* Footer */
        .footer {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            background: rgba(4, 18, 35, 0.85);
            border-top: 1px solid rgba(255, 255, 255, 0.12);
            color: #b6c9d9;
            text-align: center;
            font-size: 12px;
            letter-spacing: 0.4px;
        }

        /* Responsive Design */
        @media (max-width: 650px) {
            .header {
                padding: 18px 5%;
            }

            .brand h1 {
                font-size: 17px;
            }

            .brand p {
                font-size: 8px;
                letter-spacing: 1px;
            }

            .brand-icon {
                width: 42px;
                height: 42px;
                font-size: 22px;
            }

            .admin-label {
                font-size: 10px;
                padding: 8px 10px;
            }

            .container {
                padding: 40px 18px;
            }

            .heading {
                margin-bottom: 30px;
            }

            .heading p {
                font-size: 13px;
            }

            .card-container {
                flex-direction: column;
                align-items: center;
                gap: 20px;
            }

            .card {
                width: 100%;
                max-width: 360px;
                padding: 30px 24px;
            }

            .home-button {
                margin-top: 28px;
            }
        }

        @media (max-width: 380px) {
            .admin-label {
                font-size: 9px;
                padding: 7px;
            }

            .brand {
                gap: 8px;
            }

            .brand h1 {
                font-size: 14px;
                letter-spacing: 1px;
            }
        }
    </style>
</head>

<body>

    <!-- Header -->
    <header class="header">

        <div class="brand">
            <div class="brand-icon">&#127974;</div>

            <div>
                <h1>NET BANKING</h1>
                <p>YOUR TRUST. OUR PRIORITY.</p>
            </div>
        </div>

        <div class="admin-label">
            ADMIN PANEL
        </div>

    </header>

    <!-- Main Content -->
    <main class="container">

        <section class="heading">

            <div class="tagline">
                BANKING MANAGEMENT SYSTEM
            </div>

            <h2>ADMIN <span>MENU</span></h2>

            <p>
                Manage your banking operations efficiently
                <br>
                Select a module to continue.
            </p>

        </section>

        <!-- Menu Cards -->
        <section class="card-container">

            <!-- Account Card -->
            <div class="card">

                <div class="card-icon">
                    &#128179;
                </div>

                <h3>ACCOUNT</h3>

                <p>
                    Manage bank accounts, review account
                    details and maintain account records.
                </p>

                <a href="Account.jsp" class="button">
                    MANAGE ACCOUNTS
                    <span class="button-arrow">&rarr;</span>
                </a>

            </div>

            <!-- Customer Card -->
            <div class="card">

                <div class="card-icon">
                    &#128100;
                </div>

                <h3>CUSTOMER</h3>

                <p>
                    Access customer details and manage
                    customer information and records.
                </p>

                <a href="Customer.jsp" class="button">
                    MANAGE CUSTOMERS
                    <span class="button-arrow">&rarr;</span>
                </a>

            </div>

        </section>

        <!-- Back to Home Button -->
        <a href="FrontPage.jsp" class="home-button">
            <span class="home-icon">&larr;</span>
            BACK TO HOME
        </a>

    </main>

    <!-- Footer -->
    <footer class="footer">
        &copy; 2026 NetBanking | Admin Panel | All Rights Reserved.
    </footer>

</body>
</html>
