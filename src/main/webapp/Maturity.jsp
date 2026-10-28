
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>FD Created Successfully</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: linear-gradient(135deg, #eaf2ff, #f8fbff);
            min-height: 100vh;
            color: #333;
        }


        /* HEADER */

        .top-header {
            width: 100%;
            background: #0d47a1;
            color: white;
            padding: 20px 40px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.18);
        }

        .top-header h3 {
            font-size: 22px;
            letter-spacing: 1px;
        }


        /* MAIN */

        .main {
            width: 100%;
            padding: 45px 20px;
        }

        .container-box {
            width: 100%;
            max-width: 720px;
            margin: auto;
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(13,71,161,0.15);
        }


        /* SUCCESS HEADER */

        .success-header {
            text-align: center;
            padding: 30px 20px 25px;
            background: linear-gradient(135deg, #0d47a1, #1565c0);
            color: white;
        }

        .success-icon {
            width: 65px;
            height: 65px;
            margin: 0 auto 15px;
            background: white;
            color: #28a745;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 35px;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }

        .success-header h2 {
            font-size: 25px;
            margin-bottom: 8px;
        }

        .success-header p {
            font-size: 14px;
            opacity: 0.9;
        }


        /* CONTENT */

        .content {
            padding: 30px;
        }


        /* SUCCESS MESSAGE */

        .success-message {
            background: #eaf8ee;
            border: 1px solid #b8e0c2;
            color: #217a35;
            padding: 14px;
            border-radius: 8px;
            text-align: center;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 25px;
        }


        /* ACCOUNT NUMBER */

        .account-box {
            background: #f4f8ff;
            border: 1px solid #d5e3f5;
            border-left: 5px solid #0d47a1;
            border-radius: 8px;
            padding: 17px 20px;
            margin-bottom: 25px;
        }

        .account-label {
            display: block;
            color: #666;
            font-size: 12px;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .account-number {
            color: #0d47a1;
            font-size: 21px;
            font-weight: bold;
        }


        /* DETAILS */

        .section-title {
            color: #0d47a1;
            font-size: 17px;
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 2px solid #e5edf8;
        }

        .details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .detail-item {
            background: #fafcff;
            border: 1px solid #e3eaf3;
            border-radius: 8px;
            padding: 15px;
        }

        .detail-label {
            display: block;
            color: #777;
            font-size: 12px;
            margin-bottom: 7px;
        }

        .detail-value {
            color: #222;
            font-size: 16px;
            font-weight: bold;
        }


        /* STATUS */

        .status {
            display: inline-block;
            background: #d4edda;
            color: #155724;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }


        /* MATURITY */

        .maturity-box {
            margin-top: 25px;
            padding: 22px;
            background: linear-gradient(135deg, #eef5ff, #f8fbff);
            border: 1px solid #cbdcf2;
            border-radius: 10px;
            text-align: center;
        }

        .maturity-box .label {
            display: block;
            color: #555;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .maturity-amount {
            color: #0d47a1;
            font-size: 29px;
            font-weight: bold;
        }


        /* TOTALS */

        .totals {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }

        .totals-title {
            color: #0d47a1;
            font-size: 17px;
            margin-bottom: 15px;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 13px 15px;
            margin-bottom: 8px;
            background: #f7f9fc;
            border-radius: 7px;
        }

        .total-row span:first-child {
            color: #555;
            font-size: 14px;
        }

        .total-row span:last-child {
            color: #222;
            font-size: 16px;
            font-weight: bold;
        }


        /* BUTTONS */

        .btn-area {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .home-btn,
        .print-btn {
            display: inline-block;
            text-decoration: none;
            border: none;
            padding: 12px 25px;
            border-radius: 7px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .home-btn {
            background: #0d47a1;
            color: white;
        }

        .home-btn:hover {
            background: #08306b;
            transform: translateY(-2px);
            box-shadow: 0 5px 12px rgba(13,71,161,0.25);
        }

        .print-btn {
            background: #28a745;
            color: white;
        }

        .print-btn:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 5px 12px rgba(40,167,69,0.25);
        }


        /* NOTE */

        .note {
            text-align: center;
            color: #888;
            font-size: 11px;
            margin-top: 18px;
        }


        /* PRINT */

        @media print {

            body {
                background: white;
            }

            .top-header {
                background: white;
                color: black;
                box-shadow: none;
                border-bottom: 2px solid #0d47a1;
            }

            .main {
                padding: 10px;
            }

            .container-box {
                max-width: 100%;
                box-shadow: none;
                border: 1px solid #ccc;
            }

            .btn-area,
            .note {
                display: none;
            }

            .success-header {
                background: white;
                color: black;
                border-bottom: 1px solid #ccc;
            }

            .success-icon {
                border: 1px solid #28a745;
            }

            .success-message {
                color: #217a35;
            }

        }


        /* RESPONSIVE */

        @media (max-width: 600px) {

            .top-header {
                padding: 18px 20px;
                text-align: center;
            }

            .top-header h3 {
                font-size: 19px;
            }

            .main {
                padding: 25px 12px;
            }

            .content {
                padding: 20px;
            }

            .details {
                grid-template-columns: 1fr;
            }

            .success-header h2 {
                font-size: 21px;
            }

            .maturity-amount {
                font-size: 25px;
            }

            .btn-area {
                flex-direction: column;
            }

            .home-btn,
            .print-btn {
                width: 100%;
                text-align: center;
            }

        }

    </style>

</head>


<body>


    <!-- HEADER -->

    <div class="top-header">

        <h3>
            NET BANKING
        </h3>

    </div>


    <!-- MAIN -->

    <div class="main">

        <div class="container-box" id="printArea">


            <!-- SUCCESS HEADER -->

            <div class="success-header">

                <div class="success-icon">
                    ✓
                </div>

                <h2>
                    Fixed Deposit Created Successfully
                </h2>

                <p>
                    Your Fixed Deposit has been created successfully
                </p>

            </div>


            <div class="content">


                <!-- SUCCESS MESSAGE -->

                <div class="success-message">

                    ✓ Transaction Successful

                </div>


                <!-- ACCOUNT NUMBER -->

                <div class="account-box">

                    <span class="account-label">
                        FD Account Number
                    </span>

                    <span class="account-number">
                        ${fdAccNo}
                    </span>

                </div>


                <!-- DETAILS -->

                <h3 class="section-title">
                    Deposit Details
                </h3>


                <div class="details">


                    <div class="detail-item">

                        <span class="detail-label">
                            Status
                        </span>

                        <span class="status">
                            ${status}
                        </span>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Principal Amount
                        </span>

                        <span class="detail-value">
                            ₹${amt}
                        </span>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Interest Rate
                        </span>

                        <span class="detail-value">
                            ${rate}%
                        </span>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Duration
                        </span>

                        <span class="detail-value">
                            ${time} year(s)
                        </span>

                    </div>


                </div>


                <!-- MATURITY AMOUNT -->

                <div class="maturity-box">

                    <span class="label">
                        Expected Maturity Amount
                    </span>

                    <div class="maturity-amount">
                        ₹${maturityAmount}
                    </div>

                </div>


                <!-- TOTALS -->

                <div class="totals">

                    <h3 class="totals-title">
                        FD Summary
                    </h3>


                    <div class="total-row">

                        <span>
                            Total Principal Amount
                        </span>

                        <span>
                            ₹${totalPrincipal}
                        </span>

                    </div>


                    <div class="total-row">

                        <span>
                            Total Maturity Amount
                        </span>

                        <span>
                            ₹${totalMaturity}
                        </span>

                    </div>

                </div>


                <!-- BUTTONS -->

                <div class="btn-area">

                    <button type="button"
                            class="print-btn"
                            onclick="window.print();">

                        🖨 Print FD Receipt

                    </button>


                    <a href="NavClient.jsp"
                       class="home-btn">

                        Back to Home

                    </a>

                </div>


                <div class="note">

                    Please keep your FD Account Number for future reference.

                </div>


            </div>

        </div>

    </div>


</body>

</html>
