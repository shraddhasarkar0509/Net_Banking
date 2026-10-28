<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Account Management | NetBanking</title>

    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #193550;
background:
    linear-gradient(
        135deg,
        rgba(5, 25, 47, 0.35),
        rgba(8, 76, 103, 0.20)
    ),
    url("https://static.vecteezy.com/system/resources/thumbnails/013/375/585/small_2x/accounting-business-and-finance-concept-on-virtual-screen-photo.jpg");

background-size: cover;
background-position: center;
background-repeat: no-repeat;
background-attachment: fixed;

}

        /* Header */
        .header {
            min-height: 92px;
            padding: 18px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;

            background: rgba(4, 18, 35, 0.92);
            border-bottom: 1px solid rgba(255, 255, 255, 0.13);
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.15);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 13px;
        }

        .brand-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;

            background: linear-gradient(135deg, #17a8b5, #08768b);
            color: white;
            font-size: 26px;
            box-shadow: 0 5px 15px rgba(0, 190, 210, 0.20);
        }

        .brand-text h2 {
            color: white;
            font-size: 21px;
            letter-spacing: 2px;
        }

        .brand-text p {
            color: #a9c6d8;
            font-size: 9px;
            letter-spacing: 1.7px;
            margin-top: 5px;
        }

        .admin-label {
            color: #e3f8ff;
            background: rgba(255, 255, 255, 0.07);
            border: 1px solid rgba(255, 255, 255, 0.22);
            border-radius: 30px;
            padding: 10px 17px;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.3px;
        }

        /* Main Content */
        .container {
            width: 100%;
            max-width: 1100px;
            margin: auto;
            padding: 55px 30px 45px;
        }

        .page-heading {
            text-align: center;
            margin-bottom: 45px;
        }

        .tagline {
            display: inline-block;
            padding: 9px 16px;
            border-radius: 30px;
            border: 1px solid rgba(94, 225, 232, 0.32);
            background: rgba(24, 184, 194, 0.13);
            color: #8af0f1;
            font-size: 10px;
            font-weight: 750;
            letter-spacing: 2px;
            margin-bottom: 18px;
        }

        .page-heading h1 {
            color: white;
            font-size: clamp(32px, 4vw, 44px);
            font-weight: 750;
            margin-bottom: 14px;
        }

        .page-heading h1 span {
            color: #59dbe0;
        }

        .subtitle {
            color: #d1e1ed;
            font-size: 14px;
            line-height: 1.9;
        }

        /* Account Cards */
        .box-container {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 30px;
            max-width: 790px;
            margin: 0 auto;
        }

        .box {
            min-height: 365px;
            padding: 35px 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;

            background: rgba(255, 255, 255, 0.97);
            border: 1px solid rgba(255, 255, 255, 0.7);
            border-radius: 18px;

            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.20);

            transition:
                transform 0.3s ease,
                box-shadow 0.3s ease;
        }

        .box:hover {
            transform: translateY(-8px);
            box-shadow: 0 23px 45px rgba(0, 0, 0, 0.30);
        }

        /* Card Icons */
        .card-icon {
            width: 78px;
            height: 78px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 37px;
            margin-bottom: 22px;
        }

        .create-icon {
            background: #e5f6f8;
            color: #087f91;
        }

        .update-icon {
            background: #fff4d9;
            color: #bb8100;
        }

        .operation-label {
            font-size: 9px;
            font-weight: 750;
            letter-spacing: 1.7px;
            color: #8a99aa;
            margin-bottom: 10px;
        }

        .box h2 {
            font-size: 21px;
            color: #173b59;
            margin-bottom: 13px;
        }

        .box p {
            color: #728297;
            font-size: 13px;
            line-height: 1.9;
            margin-bottom: 27px;
            flex: 1;
        }

        /* Action Buttons */
        .action-button {
            width: 100%;
            min-height: 48px;
            padding: 13px 16px;

            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;

            background: linear-gradient(135deg, #087f91, #075b7a);
            color: white;
            text-decoration: none;

            border-radius: 8px;
            font-size: 12px;
            font-weight: 750;
            letter-spacing: 0.8px;

            box-shadow: 0 6px 15px rgba(8, 100, 130, 0.18);

            transition:
                background 0.25s ease,
                transform 0.25s ease;
        }

        .action-button:hover {
            background: linear-gradient(135deg, #075b7a, #063c61);
            transform: translateY(-2px);
        }

        .arrow {
            font-size: 19px;
        }

        /* Back to Admin Menu */
        .navigation {
            display: flex;
            justify-content: center;
            margin-top: 38px;
        }

        .back-button {
            min-height: 48px;
            padding: 13px 25px;

            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 11px;

            color: white;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.50);
            border-radius: 9px;

            text-decoration: none;
            font-size: 12px;
            font-weight: 750;
            letter-spacing: 1px;

            transition:
                background 0.25s ease,
                color 0.25s ease,
                transform 0.25s ease;
        }

        .back-button:hover {
            background: white;
            color: #0b3d5c;
            transform: translateY(-3px);
        }

        .back-arrow {
            font-size: 19px;
        }

        /* Footer */
        .footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;

            padding: 22px 7%;
            background: rgba(4, 18, 35, 0.90);
            border-top: 1px solid rgba(255, 255, 255, 0.13);

            color: #b6c9d9;
            font-size: 11px;
        }

        /* Responsive Design */
        @media (max-width: 650px) {
            .header {
                padding: 16px 5%;
                min-height: 78px;
            }

            .brand {
                gap: 9px;
            }

            .brand-icon {
                width: 40px;
                height: 40px;
                font-size: 22px;
            }

            .brand-text h2 {
                font-size: 15px;
                letter-spacing: 1px;
            }

            .brand-text p {
                font-size: 7px;
                letter-spacing: 0.8px;
            }

            .admin-label {
                font-size: 9px;
                padding: 8px 10px;
                letter-spacing: 0.5px;
            }

            .container {
                padding: 38px 18px;
            }

            .page-heading {
                margin-bottom: 30px;
            }

            .page-heading h1 {
                font-size: 32px;
            }

            .subtitle {
                font-size: 12px;
            }

            .box-container {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .box {
                min-height: 330px;
                padding: 30px 24px;
            }

            .navigation {
                margin-top: 28px;
            }

            .back-button {
                width: 100%;
                max-width: 330px;
            }

            .footer {
                flex-direction: column;
                text-align: center;
                justify-content: center;
                line-height: 1.7;
            }
        }
    </style>
</head>

<body>

    <!-- Header -->
    <header class="header">

        <div class="brand">
            <div class="brand-icon">&#127974;</div>

            <div class="brand-text">
                <h2>NET BANKING</h2>
                <p>YOUR TRUST. OUR PRIORITY.</p>
            </div>
        </div>

        <div class="admin-label">
            ADMIN PANEL
        </div>

    </header>

    <!-- Main Section -->
    <main class="container">

        <section class="page-heading">

            <div class="tagline">
                BANKING MANAGEMENT SYSTEM
            </div>

            <h1>Account <span>Management</span></h1>

            <p class="subtitle">
                Manage customer bank accounts efficiently and securely.
                <br>
                Select an operation to continue.
            </p>

        </section>

        <!-- Account Operation Cards -->
        <section class="box-container">

            <!-- Create Account -->
            <div class="box">

                <div class="card-icon create-icon">
                    &#128179;
                </div>

                <span class="operation-label">
                    OPERATION 01
                </span>

                <h2>Account Create</h2>

                <p>
                    Create a new customer bank account
                    and register account details in the system.
                </p>

                <a href="AccountCreate.jsp" class="action-button">
                    CREATE ACCOUNT
                    <span class="arrow">&rarr;</span>
                </a>

            </div>

            <!-- Update Account -->
            <div class="box">

                <div class="card-icon update-icon">
                    &#9998;
                </div>

                <span class="operation-label">
                    OPERATION 02
                </span>

                <h2>Account Update</h2>

                <p>
                    Update existing account details and
                    maintain accurate account information.
                </p>

                <a href="AccountUpd.jsp" class="action-button">
                    UPDATE ACCOUNT
                    <span class="arrow">&rarr;</span>
                </a>

            </div>

        </section>

        <!-- Back to Admin Menu -->
        <div class="navigation">

            <a href="Admin_Menu.jsp" class="back-button">
                <span class="back-arrow">&larr;</span>
                BACK TO ADMIN MENU
            </a>

        </div>

    </main>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2026 NetBanking. All Rights Reserved.</p>
        <p>Account Management | Admin Panel</p>
    </footer>

</body>
</html>
