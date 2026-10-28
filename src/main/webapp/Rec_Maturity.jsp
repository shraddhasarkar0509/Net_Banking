<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // =====================================================
    // CHECK LOGIN SESSION
    // =====================================================

    HttpSession userSession = request.getSession(false);

    if (userSession == null || userSession.getAttribute("cid") == null) {
        response.sendRedirect("Login.jsp?error=Please login first");
        return;
    }

    // =====================================================
    // GET RD DETAILS FROM REQUEST
    // =====================================================

    String rdAccNo = request.getParameter("rdAccNo");
    String amt = request.getParameter("amt");
    String timeMonths = request.getParameter("timeMonths");
    String rate = request.getParameter("rate");
    String totalInvested = request.getParameter("totalInvested");
    String maturityAmount = request.getParameter("maturityAmount");

    // Prevent null values from being displayed
    if (rdAccNo == null) rdAccNo = "";
    if (amt == null) amt = "";
    if (timeMonths == null) timeMonths = "";
    if (rate == null) rate = "";
    if (totalInvested == null) totalInvested = "";
    if (maturityAmount == null) maturityAmount = "";
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>RD Investment Receipt</title>

    <style>

        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;

            background: linear-gradient(
                135deg,
                #4f46e5 0%,
                #06b6d4 100%
            );

            display: flex;
            justify-content: center;
            align-items: center;

            min-height: 100vh;
        }

        .receipt-card {
            background-color: #ffffff;

            padding: 40px;

            border-radius: 15px;

            box-shadow:
                0 10px 30px rgba(0, 0, 0, 0.15);

            width: 500px;

            text-align: center;

            box-sizing: border-box;
        }

        .checkmark {
            font-size: 55px;

            color: #28a745;

            margin-bottom: 10px;

            font-weight: bold;
        }

        .receipt-card h2 {
            color: #28a745;

            margin-bottom: 5px;

            font-size: 26px;

            font-weight: bold;
        }

        .status-msg {
            color: #666;

            font-size: 15px;

            margin-bottom: 30px;
        }

        .info-group {
            margin: 16px 0;

            color: #333;

            font-size: 18px;

            font-weight: 500;

            border-bottom:
                1px dashed #f0f0f0;

            padding-bottom: 10px;
        }

        .info-group strong {
            color: #111;
        }

        .maturity-highlight {
            background-color: #f0fdf4;

            border: 2px solid #bbf7d0;

            padding: 15px;

            border-radius: 10px;

            color: #15803d;

            font-size: 22px;

            font-weight: bold;

            margin: 25px 0;
        }

        .actions {
            margin-top: 30px;

            display: flex;

            justify-content: space-around;

            align-items: center;

            gap: 15px;
        }

        .btn-link {
            color: #4f46e5;

            text-decoration: none;

            font-size: 16px;

            font-weight: bold;

            border: 2px solid #4f46e5;

            padding: 10px 20px;

            border-radius: 25px;

            transition: all 0.2s;
        }

        .btn-link:hover {
            background-color: #f5f3ff;
        }

        .btn-primary {
            background-color: #4f46e5;

            color: white !important;

            padding: 12px 30px;

            border-radius: 25px;

            text-decoration: none;

            font-size: 16px;

            font-weight: bold;

            box-shadow:
                0 4px 12px
                rgba(79, 70, 229, 0.3);

            transition: background 0.2s;

            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #4338ca;
        }

        @media (max-width: 600px) {

            .receipt-card {
                width: 90%;

                padding: 25px;
            }

            .actions {
                flex-direction: column;
            }

            .btn-link,
            .btn-primary {
                width: 100%;

                box-sizing: border-box;
            }
        }

    </style>

</head>

<body>

    <div class="receipt-card">

        <div class="checkmark">✓</div>

        <h2>RD Opened Successfully!</h2>

        <div class="status-msg">
            The first installment has been safely debited
            from your savings account.
        </div>


        <!-- RD ACCOUNT NUMBER -->

        <div class="info-group">

            Recurring Deposit Account Number:

            <br>

            <strong
                style="font-family: monospace; font-size: 20px;">

                <%= rdAccNo %>

            </strong>

        </div>


        <!-- MONTHLY INSTALLMENT -->

        <div class="info-group">

            Monthly Installment:

            <strong>
                ₹ <%= amt %>
            </strong>

        </div>


        <!-- TENURE -->

        <div class="info-group">

            Tenure Duration:

            <strong>
                <%= timeMonths %> Months
            </strong>

        </div>


        <!-- INTEREST RATE -->

        <div class="info-group">

            Interest Rate:

            <strong>
                <%= rate %>%
            </strong>

        </div>


        <!-- TOTAL INVESTMENT -->

        <div class="info-group">

            Total Amount Invested:

            <strong>
                ₹ <%= totalInvested %>
            </strong>

        </div>


        <!-- MATURITY -->

        <div class="maturity-highlight">

            Estimated Maturity Amount:

            <br>

            ₹ <%= maturityAmount %>

        </div>


        <!-- BUTTONS -->

        <div class="actions">

            <a href="NavClient.jsp"
               class="btn-link">

                Back to Home Page

            </a>


            <a href="javascript:window.print()"
               class="btn-primary">

                Print Receipt

            </a>

        </div>

    </div>

</body>

</html>