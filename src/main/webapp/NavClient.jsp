
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Net Banking - Customer Dashboard</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Nav2.css">
</head>

<body>

<div class="page-wrapper">

    <!-- HEADER -->
    <header class="header">

        <div class="brand">
            <div class="brand-icon">N</div>

            <div class="brand-name">
                <h2>NET BANKING</h2>
                <span>YOUR TRUSTED BANKING PARTNER</span>
            </div>
        </div>

        <div class="panel-label">
            <span class="status-dot"></span>
            CUSTOMER PANEL
        </div>

    </header>


    <!-- MAIN CONTENT -->
    <main class="main-content">

        <!-- WELCOME SECTION -->
        <section class="welcome-section">

            <div class="welcome-content">
                <span class="welcome-tag">WELCOME TO DIGITAL BANKING</span>

                <h1>Your Banking, <span>Your Way.</span></h1>

                <p>
                    Manage your finances effortlessly. Access your accounts,
                    transfer funds, and explore banking services from one place.
                </p>
            </div>

            <div class="welcome-decoration">
                <div class="decoration-circle circle-one"></div>
                <div class="decoration-circle circle-two"></div>

                <div class="welcome-symbol">₹</div>
            </div>

        </section>


        <!-- SERVICES -->
        <section class="services-section">

            <div class="section-heading">
                <div>
                    <span class="section-tag">EXPLORE</span>
                    <h2>Our Banking Services</h2>
                </div>

                <div class="section-line"></div>
            </div>


            <div class="service-grid">

                <!-- FUND TRANSFER -->
                <a href="FundTransfer.jsp" class="service-card">

                    <div class="card-top">
                        <div class="service-icon transfer-icon">↗</div>
                        <span class="service-number">01</span>
                    </div>

                    <h3>Fund Transfer</h3>

                    <p>
                        Transfer money conveniently between bank accounts.
                    </p>

                    <div class="service-button">
                        <span>Transfer Funds</span>
                        <span class="arrow">→</span>
                    </div>

                </a>


                <!-- FIXED DEPOSIT -->
                <a href="FD.jsp" class="service-card">

                    <div class="card-top">
                        <div class="service-icon fd-icon">▤</div>
                        <span class="service-number">02</span>
                    </div>

                    <h3>Fixed Deposit</h3>

                    <p>
                        Invest your savings and plan for your financial future.
                    </p>

                    <div class="service-button">
                        <span>Open Fixed Deposit</span>
                        <span class="arrow">→</span>
                    </div>

                </a>


                <!-- FD DASHBOARD -->
                <a href="FDDashboardServe" class="service-card">

                    <div class="card-top">
                        <div class="service-icon dashboard-icon">▦</div>
                        <span class="service-number">03</span>
                    </div>

                    <h3>FD Dashboard</h3>

                    <p>
                        View and manage your existing fixed deposits.
                    </p>

                    <div class="service-button">
                        <span>Manage Deposits</span>
                        <span class="arrow">→</span>
                    </div>

                </a>


                <!-- RECURRING DEPOSIT -->
                <a href="RD.jsp" class="service-card">

                    <div class="card-top">
                        <div class="service-icon rd-icon">◷</div>
                        <span class="service-number">04</span>
                    </div>

                    <h3>Recurring Deposit</h3>

                    <p>
                        Grow your savings through regular monthly deposits.
                    </p>

                    <div class="service-button">
                        <span>Start Saving</span>
                        <span class="arrow">→</span>
                    </div>

                </a>


                <!-- RD DASHBOARD -->
                <a href="RDDashboardServe" class="service-card">

                    <div class="card-top">
                        <div class="service-icon rd-dashboard-icon">▣</div>
                        <span class="service-number">05</span>
                    </div>

                    <h3>RD Dashboard</h3>

                    <p>
                        Monitor and manage your recurring deposits.
                    </p>

                    <div class="service-button">
                        <span>Manage Deposits</span>
                        <span class="arrow">→</span>
                    </div>

                </a>


                <!-- ACCOUNT BALANCE -->
                <a href="AccountBalance.jsp" class="service-card">

                    <div class="card-top">
                        <div class="service-icon balance-icon">₹</div>
                        <span class="service-number">06</span>
                    </div>

                    <h3>Account Balance</h3>

                    <p>
                        Check your available account balance.
                    </p>

                    <div class="service-button">
                        <span>Check Balance</span>
                        <span class="arrow">→</span>
                    </div>

                </a>


                <!-- TRANSACTION DETAILS -->
                <a href="TransactionDetailsServe" class="service-card">

                    <div class="card-top">
                        <div class="service-icon transaction-icon">⇄</div>
                        <span class="service-number">07</span>
                    </div>

                    <h3>Transaction Details</h3>

                    <p>
                        Review your transaction history and account activity.
                    </p>

                    <div class="service-button">
                        <span>View Transactions</span>
                        <span class="arrow">→</span>
                    </div>

                </a>

            </div>

        </section>


        <!-- BOTTOM NAVIGATION -->
        <div class="bottom-navigation">

            <div class="bottom-message">
                <span class="bottom-icon">✓</span>

                <div>
                    <h3>Banking Made Simple</h3>
                    <p>Your financial services, all in one place.</p>
                </div>
            </div>

            <a href="FrontPage.jsp" class="home-button">
                <span>⌂</span>
                Back to Home
            </a>

        </div>

    </main>


    <!-- FOOTER -->
    <footer class="footer">
        <p>© 2026 Net Banking. All Rights Reserved.</p>

        <div class="footer-links">
            <span>Secure</span>
            <span class="footer-dot">•</span>
            <span>Reliable</span>
            <span class="footer-dot">•</span>
            <span>Convenient</span>
        </div>
    </footer>

</div>

</body>
</html>