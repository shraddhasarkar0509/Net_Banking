<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Fixed Deposit Workspace</title>

    <!-- Bootstrap 4.6.2 -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>

        body {
            min-height: 100vh;

            background: linear-gradient(
                135deg,
                #0f172a 0%,
                #1e1b4b 50%,
                #311042 100%
            );

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 40px 20px;

            font-family:
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                Roboto,
                Helvetica,
                Arial,
                sans-serif;
        }

        .premium-card {

            width: 100%;
            max-width: 560px;

            background: rgba(255, 255, 255, 0.98);

            border-radius: 24px;

            box-shadow:
                0 25px 50px -12px rgba(0, 0, 0, 0.5);

            border:
                1px solid rgba(255, 255, 255, 0.1);

            overflow: hidden;

            transition:
                transform 0.3s ease;
        }

        .form-header {

            background: linear-gradient(
                135deg,
                #4f46e5 0%,
                #7c3aed 100%
            );

            padding: 35px;

            text-align: center;

            color: #ffffff;
        }

        .form-header h2 {

            font-size: 26px;

            font-weight: 800;

            letter-spacing: 1px;

            margin: 0;

            text-transform: uppercase;
        }

        .form-header p {

            color: rgba(255, 255, 255, 0.8);

            margin-top: 8px;

            margin-bottom: 0;

            font-size: 14px;

            font-weight: 500;
        }

        .form-body {

            padding: 45px 50px;
        }

        .custom-label {

            font-weight: 700;

            color: #334155;

            font-size: 14px;

            text-transform: uppercase;

            letter-spacing: 0.5px;

            margin-bottom: 10px;
        }

        .custom-input {

            border: 2px solid #e2e8f0;

            border-radius: 12px;

            padding: 14px 18px;

            font-size: 16px;

            font-weight: 500;

            color: #1e293b;

            transition:
                all 0.2s ease-in-out;

            height: auto;
        }

        .custom-input:focus {

            border-color: #6366f1;

            box-shadow:
                0 0 0 4px rgba(99, 102, 241, 0.15);

            background-color: #ffffff;
        }

        .custom-select {

            appearance: none;

            background-image: url(
                "data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23344155' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e"
            );

            background-repeat: no-repeat;

            background-position:
                right 18px center;

            background-size: 14px;

            padding-right: 45px !important;
        }

        .payout-box {

            background-color: #f8fafc;

            border: 2px dashed #cbd5e1;

            border-radius: 14px;

            padding: 18px;

            cursor: pointer;

            transition:
                all 0.2s ease;
        }

        .payout-box:hover {

            background-color: #f1f5f9;

            border-color: #94a3b8;
        }

        .renewal-box {

            background-color: #fff7ed;

            border: 2px solid #fed7aa;

            border-radius: 14px;

            padding: 18px;

            margin-top: -5px;

            margin-bottom: 24px;
        }

        .renewal-box label {

            color: #9a3412;
        }

        .renewal-info {

            color: #9a3412;

            font-size: 13px;

            margin-top: 6px;
        }

        .test-mode-box {

            background-color: #f0fdf4;

            border: 2px solid #bbf7d0;

            border-radius: 14px;

            padding: 18px;

            display: flex;

            align-items: center;

            cursor: pointer;

            transition:
                background 0.2s ease;
        }

        .test-mode-box:hover {

            background-color: #dcfce7;
        }

        .premium-btn {

            background: linear-gradient(
                135deg,
                #4f46e5 0%,
                #7c3aed 100%
            );

            border: none;

            border-radius: 14px;

            padding: 16px;

            font-size: 18px;

            font-weight: 700;

            color: #ffffff;

            box-shadow:
                0 10px 20px -5px
                rgba(79, 70, 229, 0.4);

            transition:
                all 0.2s ease;
        }

        .premium-btn:hover {

            transform: translateY(-2px);

            box-shadow:
                0 15px 25px -5px
                rgba(79, 70, 229, 0.5);

            background: linear-gradient(
                135deg,
                #4338ca 0%,
                #6d28d9 100%
            );
        }

        .premium-btn:active {

            transform: translateY(0);
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

        .back-btn:hover {

            color: #4f46e5;

            text-decoration: none;
        }

        .security-note {

            background: #eff6ff;

            border: 1px solid #bfdbfe;

            color: #1e40af;

            border-radius: 10px;

            padding: 12px;

            margin-bottom: 25px;

            font-size: 13px;

            text-align: center;
        }

        @media (max-width: 576px) {

            .form-body {

                padding: 30px 25px;
            }

            .form-header {

                padding: 28px 20px;
            }
        }

    </style>

</head>


<body>

    <div class="premium-card">

        <!-- Header Banner -->

        <div class="form-header">

            <h2>Fixed Deposit Form</h2>

            <p>
                Secure Your Future Savings Instantly
            </p>

        </div>


        <!-- Form Body -->

        <div class="form-body">
        <%
String error = (String) request.getAttribute("error");

if (error != null) {
%>
    <div style="color: red; font-weight: bold; margin-bottom: 15px;">
        <%= error %>
    </div>
<%
}
%>
            <!-- Security Information -->

            <div class="security-note">

                🔐 Your Customer ID is taken from your
                logged-in account for security.

            </div>


            <form action="FDServe2" method="post">


                <!-- Savings Account Number -->

                <div class="form-group mb-4">

                    <label class="custom-label">

                        Savings Account Number

                    </label>

                    <input
                        type="text"
                        class="form-control custom-input"
                        name="accNo"
                        required
                        placeholder="Enter target savings account number">

                </div>


                <!-- Funding Method -->

                <div class="form-group mb-4">

                    <label class="custom-label">

                        Funding Method

                    </label>

                    <select
                        class="form-control custom-input custom-select"
                        name="fundingType"
                        id="fundingType">

                        <option value="ONLINE">

                            Debit From Savings
                            (Maintain Min ₹5,000)

                        </option>

                        <option value="CASH">

                            Hand-Carried Cash
                            (No Online Debit)

                        </option>

                    </select>

                </div>


                <!-- Principal Amount -->

                <div class="form-group mb-4">

                    <label class="custom-label">

                        Principal Amount (₹)

                    </label>

                    <input
                        type="number"
                        step="0.01"
                        min="1000"
                        class="form-control custom-input"
                        name="amt"
                        required
                        placeholder="Minimum investment value ₹1,000">

                </div>


                <!-- Interest Rate -->

                <div class="form-group mb-4">

                    <label class="custom-label">

                        Annual Interest Rate (%)

                    </label>

                    <input
                        type="number"
                        step="0.01"
                        min="0"
                        class="form-control custom-input"
                        name="rate"
                        required
                        placeholder="e.g., 7.15">

                </div>


                <!-- Time Period -->

                <div class="form-group mb-4">

                    <label class="custom-label">

                        Time Period (Years)

                    </label>

                    <input
                        type="number"
                        min="1"
                        class="form-control custom-input"
                        name="time"
                        required
                        placeholder="e.g., 3">

                </div>


                <!-- Auto Payout Configuration -->

                <div
                    class="payout-box mb-4"
                    onclick="togglePayoutBox();">

                    <div
                        class="form-check pl-0 d-flex align-items-center">

                        <input
                            type="checkbox"
                            name="autoPayout"
                            id="autoPayout"
                            value="true"
                            checked
                            onclick="event.stopPropagation();"
                            onchange="toggleRenewalField();"
                            style="
                                width:18px;
                                height:18px;
                                cursor:pointer;
                            ">

                        <div class="ml-3">

                            <label
                                class="font-weight-bold text-dark mb-0"
                                for="autoPayout"
                                style="
                                    font-size:15px;
                                    cursor:pointer;
                                    user-select:none;
                                ">

                                Credit Earnings to Savings
                                Account on Maturity

                            </label>

                            <small
                                class="form-text text-muted"
                                style="margin-top:2px;">

                                If enabled, the maturity amount
                                will be credited directly to the
                                savings account.

                            </small>

                        </div>

                    </div>

                </div>


                <!-- Auto Renewal Limit -->

                <div
                    id="renewalSection"
                    class="renewal-box"
                    style="display:none;">

                    <label class="custom-label">

                        Auto Renewal Limit

                    </label>

                    <input
                        type="number"
                        class="form-control custom-input"
                        name="renewalLimit"
                        id="renewalLimit"
                        min="1"
                        max="10"
                        placeholder="Enter maximum number of renewals">

                    <div class="renewal-info">

                        <strong>How it works:</strong>

                        If you enter <strong>3</strong>,
                        the FD can automatically renew 3 times.

                        After the renewal limit is reached,
                        the maturity amount will automatically
                        be credited to the savings account
                        and the FD will be closed.

                    </div>

                </div>


                <!-- Test Mode -->

                <div
                    class="test-mode-box mb-5"
                    onclick="toggleTestMode();">

                    <input
                        type="checkbox"
                        name="testMode"
                        id="testMode"
                        value="true"
                        checked
                        onclick="event.stopPropagation();"
                        style="
                            width:18px;
                            height:18px;
                            cursor:pointer;
                        ">

                    <label
                        class="font-weight-bold text-success mb-0 ml-3"
                        for="testMode"
                        style="
                            font-size:15px;
                            cursor:pointer;
                            user-select:none;
                        ">

                        ⚡ Test Mode Active
                        (Years as Minutes)

                    </label>

                </div>


                <!-- Submit -->

                <button
                    type="submit"
                    class="btn premium-btn btn-block">

                    Calculate & Open FD

                </button>


                <!-- Back to Home -->

                <a href="NavClient.jsp" class="back-btn">

                    ← Back to Home

                </a>

            </form>

        </div>

    </div>


    <!-- JavaScript -->

    <script>

        /*
         * Show / Hide Auto Renewal Limit
         */

        function toggleRenewalField() {

            var payout =
                document.getElementById("autoPayout");

            var renewalSection =
                document.getElementById("renewalSection");

            var renewalLimit =
                document.getElementById("renewalLimit");


            if (payout.checked) {

                // Payout selected

                renewalSection.style.display = "none";

                renewalLimit.required = false;

                renewalLimit.value = "";

            } else {

                // Payout not selected

                renewalSection.style.display = "block";

                renewalLimit.required = true;
            }
        }


        /*
         * Allows the complete payout box to act
         * like a checkbox.
         */

        function togglePayoutBox() {

            var payout =
                document.getElementById("autoPayout");

            payout.checked = !payout.checked;

            toggleRenewalField();
        }


        /*
         * Allows the complete test-mode box to
         * act like a checkbox.
         */

        function toggleTestMode() {

            var testMode =
                document.getElementById("testMode");

            testMode.checked = !testMode.checked;
        }


        /*
         * Set the correct state when page loads.
         */

        window.onload = function() {

            toggleRenewalField();

        };

    </script>

</body>

</html>