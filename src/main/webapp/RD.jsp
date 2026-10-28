
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recurring Deposit</title>

<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        min-height: 100vh;
        font-family: 'Segoe UI', Arial, sans-serif;
        background: linear-gradient(135deg, #0f172a, #1e1b4b, #311042);
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 30px 15px;
    }

    .premium-card {
        width: 100%;
        max-width: 560px;
        background: rgba(255,255,255,0.97);
        border-radius: 24px;
        overflow: hidden;
        box-shadow: 0 25px 60px rgba(0,0,0,0.35);
    }

    .card-header {
        background: linear-gradient(135deg, #4f46e5, #7c3aed);
        color: white;
        text-align: center;
        padding: 30px 20px;
    }

    .card-header h2 {
        margin: 0;
        font-weight: 700;
        font-size: 28px;
    }

    .card-header p {
        margin: 8px 0 0;
        font-size: 14px;
        opacity: 0.9;
    }

    .form-body {
        padding: 45px 50px;
    }

    .form-group {
        margin-bottom: 22px;
    }

    label {
        display: block;
        font-size: 13px;
        font-weight: 700;
        color: #374151;
        text-transform: uppercase;
        margin-bottom: 8px;
        letter-spacing: 0.5px;
    }

    .custom-input,
    .custom-select {
        width: 100%;
        padding: 13px 15px;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        font-size: 15px;
        outline: none;
        transition: 0.3s;
    }

    .custom-input:focus,
    .custom-select:focus {
        border-color: #6366f1;
        box-shadow: 0 0 0 3px rgba(99,102,241,0.12);
    }

    .info-box {
        background: #f5f3ff;
        border: 1px solid #ddd6fe;
        border-radius: 12px;
        padding: 15px;
        margin-bottom: 22px;
        color: #4c1d95;
        font-size: 13px;
    }

    .payout-box {
        background: #f8fafc;
        border: 2px dashed #cbd5e1;
        border-radius: 14px;
        padding: 16px;
        margin-bottom: 18px;
    }

    .test-mode-box {
        background: #ecfdf5;
        border: 1px solid #a7f3d0;
        border-radius: 14px;
        padding: 16px;
        margin-bottom: 25px;
    }

    .check-row {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .check-row input {
        width: 18px;
        height: 18px;
        cursor: pointer;
    }

    .check-row label {
        margin: 0;
        text-transform: none;
        font-size: 14px;
        color: #374151;
        cursor: pointer;
    }

    .test-mode-title {
        font-weight: 700;
        color: #047857;
    }

    .test-mode-text {
        display: block;
        margin-top: 6px;
        margin-left: 28px;
        font-size: 12px;
        color: #065f46;
    }

    .submit-btn {
        width: 100%;
        border: none;
        padding: 15px;
        border-radius: 14px;
        background: linear-gradient(135deg, #4f46e5, #7c3aed);
        color: white;
        font-size: 16px;
        font-weight: 700;
        cursor: pointer;
        transition: 0.3s;
    }

    .submit-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(79,70,229,0.35);
    }
    
     .back-btn {

            display: block;

            text-align: center;

            margin-top: 18px;

            color: #475569;

            font-size: 14px;

            font-weight: 600;

            text-decoration: none;
        }
    

    @media (max-width: 600px) {
        .form-body {
            padding: 35px 25px;
        }

        .card-header h2 {
            font-size: 24px;
        }
    }
</style>
</head>

<body>

<div class="premium-card">

    <div class="card-header">
        <h2>Recurring Deposit Form</h2>
        <p>Build Your Savings Through Monthly Investments</p>
    </div>

    <div class="form-body">
    <%
    String error = request.getParameter("error");

    if (error != null && !error.trim().isEmpty()) {
%>
    <div style="background-color: #f8d7da;
                color: #842029;
                padding: 12px;
                margin-bottom: 15px;
                border: 1px solid #f5c2c7;
                border-radius: 5px;">
        <strong>Error:</strong> <%= error %>
    </div>
<%
    }
%>

        <div class="info-box">
            <strong>RD Information:</strong><br>
            A fixed amount will be deducted from your savings account
            every month until the selected tenure is completed.
        </div>

        <form action="RDServe" method="post">

            <!-- Savings Account Number -->
            <div class="form-group">
                <label for="accNo">Savings Account No.</label>

                <input type="text"
                       id="accNo"
                       name="accNo"
                       class="custom-input"
                       placeholder="Enter Savings Account Number"
                       required>
            </div>

            <!-- Booking Date -->
            <div class="form-group">
                <label for="bookdt">Booking Date</label>

                <input type="date"
                       id="bookdt"
                       name="bookdt"
                       class="custom-input"
                       required>
            </div>

            <!-- Monthly Amount -->
            <div class="form-group">
                <label for="monthlyAmount">Monthly Installment Amount</label>

                <input type="number"
                       id="monthlyAmount"
                       name="monthlyAmount"
                       class="custom-input"
                       placeholder="Enter monthly amount"
                       min="1"
                       step="0.01"
                       required>
            </div>

            <!-- Tenure -->
            <div class="form-group">
                <label for="time">Tenure Period (Months)</label>

                <input type="number"
                       id="time"
                       name="time"
                       class="custom-input"
                       placeholder="Enter tenure in months"
                       min="1"
                       required>
            </div>

            <!-- Auto Payout -->
            <div class="payout-box">

                <div class="check-row">

                    <input type="checkbox"
                           id="autoPayout"
                           name="autoPayout"
                           value="true"
                           checked>

                    <label for="autoPayout">
                        Auto Payout
                    </label>

                </div>

                <small style="display:block; margin-top:8px; margin-left:28px; color:#64748b;">
                    Automatically credit the maturity amount to your savings account.
                </small>

            </div>

            <!-- Test Mode -->
            <div class="test-mode-box">

                <div class="check-row">

                    <input type="checkbox"
                           id="testMode"
                           name="testMode"
                           value="true"
                           checked>

                    <label for="testMode" class="test-mode-title">
                        ⚡ Test Mode Active
                    </label>

                </div>

                <span class="test-mode-text">
                    (Months as Minutes) — Each month will be simulated as one minute
                    for testing purposes.
                </span>

            </div>

            <!-- Submit -->
            <button type="submit" class="submit-btn">
                Calculate &amp; Open RD
            </button>

                <!-- Back to Home -->

                <a href="NavClient.jsp" class="back-btn">

                    ← Back to Home

                </a>
        </form>

    </div>
</div>

</body>
</html>
