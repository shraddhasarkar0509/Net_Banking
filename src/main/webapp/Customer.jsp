
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management | NetBanking</title>

    <link rel="stylesheet" href="Customer.css">
</head>
<style>
       .container .subtitle {
    color: #ffffff;
    font-size: 20px;
    font-weight: 800;
    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.9);
    letter-spacing: 1px;
}
</style>
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

    <!-- Main Content -->
    <main class="container">

        <section class="page-heading">
            <span class="tagline">BANKING MANAGEMENT SYSTEM</span>

            <h1>Customer <span>Management</span></h1>

            <p class="subtitle">
                Manage customer information efficiently and securely.
                <br>
                Select an operation to continue.
            </p>
        </section>

        <!-- Customer Operation Cards -->
        <section class="box-container">

            <!-- Create Customer -->
            <div class="box">

                <div class="card-icon create-icon">
                    &#128100;
                    <span class="icon-plus">+</span>
                </div>

                <span class="operation-label">OPERATION 01</span>

                <h2>Customer Create</h2>

                <p>
                    Register a new customer and add their
                    information to the banking system.
                </p>

                <a href="CustomerCreate.jsp" class="action-button">
                    CREATE CUSTOMER
                    <span class="arrow">&rarr;</span>
                </a>

            </div>

            <!-- Update Customer -->
            <div class="box">

                <div class="card-icon update-icon">
                    &#9998;
                </div>

                <span class="operation-label">OPERATION 02</span>

                <h2>Customer Update</h2>

                <p>
                    Update existing customer information
                    and keep customer records accurate.
                </p>

                <a href="CustomerUpd.jsp" class="action-button">
                    UPDATE CUSTOMER
                    <span class="arrow">&rarr;</span>
                </a>

            </div>

            <!-- Delete Customer -->
            <div class="box">

                <div class="card-icon delete-icon">
                    &#128465;
                </div>

                <span class="operation-label">OPERATION 03</span>

                <h2>Customer Delete</h2>

                <p>
                    Remove a customer record when permitted
                    by your banking system's rules.
                </p>

                <a href="CustomerDel.jsp" class="action-button">
                    DELETE CUSTOMER
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
        <p>Customer Management | Admin Panel</p>
    </footer>

</body>
</html>
