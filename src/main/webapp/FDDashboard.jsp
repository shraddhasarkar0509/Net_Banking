<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>FD Dashboard</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
             background: linear-gradient(135deg, #0f172a, #1e1b4b, #312e81);
             min-height: 100vh;
            color: #333;
        }

        /* HEADER */

        .header {
            width: 100%;
            background: #0d47a1;
            color: white;
            padding: 22px 40px;
            text-align: center;
            box-shadow: 0 3px 10px rgba(0,0,0,0.15);
        }

        .header h2 {
            font-size: 25px;
            letter-spacing: 1px;
        }

        /* MAIN CONTAINER */

        .container {
            width: 95%;
            max-width: 1300px;
            margin: 30px auto;
        }

        .page-title {
            text-align: center;
            color:white;
            margin-bottom: 20px;
            font-size: 24px;
        }

        /* MESSAGE */

        .message {
            width: 90%;
            max-width: 1100px;
            margin: 20px auto;
            padding: 13px 18px;
            background: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
            border-radius: 6px;
            text-align: center;
            font-weight: bold;
        }

        /* CARD */

        .card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.10);
            overflow-x: auto;
        }

        /* TABLE */

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 950px;
        }

        th {
            background: #0d47a1;
            color: white;
            padding: 13px 10px;
            text-align: center;
            font-size: 13px;
        }

        td {
            padding: 12px 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            font-size: 13px;
        }

        tr:hover {
            background: #f5f9ff;
        }

        /* STATUS */

        .active {
            display: inline-block;
            background: #d4edda;
            color: #155724;
            padding: 6px 12px;
            border-radius: 15px;
            font-weight: bold;
            font-size: 12px;
        }

        .renewed {
            display: inline-block;
            background: #fff3cd;
            color: #856404;
            padding: 6px 12px;
            border-radius: 15px;
            font-weight: bold;
            font-size: 12px;
        }

        .closed {
            display: inline-block;
            background: #e2e3e5;
            color: #383d41;
            padding: 6px 12px;
            border-radius: 15px;
            font-weight: bold;
            font-size: 12px;
        }

        /* BREAK FD BUTTON */

        .break-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .break-btn:hover {
            background: #b02a37;
            transform: translateY(-1px);
        }

        .no-action {
            color: #999;
            font-size: 18px;
        }

        /* NO DATA */

        .no-data {
            text-align: center;
            padding: 40px;
            color: #777;
            font-size: 16px;
        }

        /* BACK BUTTON */

        .back-btn {
            display: block;
            width: 180px;
            margin: 25px auto 0;
            padding: 11px;
            text-align: center;
            text-decoration: none;
            background: #0d47a1;
            color: white;
            border-radius: 6px;
            font-weight: bold;
            transition: 0.3s;
        }

        .back-btn:hover {
            background: #08306b;
            transform: translateY(-1px);
        }

        /* RESPONSIVE */

        @media (max-width: 768px) {

            .header {
                padding: 18px 20px;
            }

            .header h2 {
                font-size: 21px;
            }

            .container {
                width: 96%;
                margin-top: 20px;
            }

            .page-title {
                font-size: 21px;
            }

            .card {
                padding: 10px;
            }
        }

    </style>

</head>


<body>


    <!-- HEADER -->

    <div class="header">

        <h2>FIXED DEPOSIT DASHBOARD</h2>

    </div>


    <!-- MESSAGE -->

    <%
        String fdMessage =
                (String) session.getAttribute("fdMessage");

        if (fdMessage != null) {
    %>

        <div class="message">

            <%= fdMessage %>

        </div>

    <%
            session.removeAttribute("fdMessage");
        }
    %>


    <!-- MAIN CONTAINER -->

    <div class="container">


        <h2 class="page-title">
            My Fixed Deposits
        </h2>


        <div class="card">


            <%
                List<Map<String, Object>> fdList = (List<Map<String, Object>>) request.getAttribute("fdList");


                if (fdList == null || fdList.isEmpty()) {
            %>


                <!-- NO FD -->

                <div class="no-data">

                    No Fixed Deposits found.

                </div>


            <%
                } else {
            %>


                <!-- FD TABLE -->

                <table>

                    <thead>

                        <tr>

                            <th>FD Account No.</th>

                            <th>Principal Amount</th>

                            <th>Interest Rate</th>

                            <th>Time</th>

                            <th>Maturity Amount</th>

                            <th>Status</th>

                            <th>Renewals</th>

                            <th>Action</th>

                        </tr>

                    </thead>


                    <tbody>


                    <%
                        for (Map<String, Object> fd : fdList) {

                            String status =
                                    (String) fd.get("status");
                    %>


                        <tr>


                            <!-- FD ACCOUNT NUMBER -->

                            <td>
                                <%= fd.get("fdAccNo") %>
                            </td>


                            <!-- PRINCIPAL AMOUNT -->

                            <td>
                                ₹<%= fd.get("amt") %>
                            </td>


                            <!-- INTEREST RATE -->

                            <td>
                                <%= fd.get("rate") %>%
                            </td>


                            <!-- TIME -->

                            <td>
                                <%= fd.get("time") %> years
                            </td>


                            <!-- MATURITY AMOUNT -->

                            <td>
                                ₹<%= fd.get("maturityAmount") %>
                            </td>


                            <!-- STATUS -->

                            <td>

                                <%
                                    if ("ACTIVE".equalsIgnoreCase(status)) {
                                %>

                                    <span class="active">
                                        ACTIVE
                                    </span>

                                <%
                                    }
                                    else if
                                    ("RENEWED".equalsIgnoreCase(status)) {
                                %>

                                    <span class="renewed">
                                        RENEWED
                                    </span>

                                <%
                                    }
                                    else {
                                %>

                                    <span class="closed">
                                        CLOSED
                                    </span>

                                <%
                                    }
                                %>

                            </td>


                            <!-- RENEWAL COUNT -->

                            <td>
                                <%= fd.get("renewal_count") %>
                            </td>


                            <!-- ACTION -->

                            <td>

                                <%
                                    if ("ACTIVE".equalsIgnoreCase(status)
                                        || "RENEWED".equalsIgnoreCase(status)) {
                                %>


                                    <form action="FDDashboardServe"
                                          method="post">

                                        <input type="hidden"
                                               name="action"
                                               value="breakFD">


                                        <input type="hidden"
                                               name="fdAccNo"
                                               value="<%= fd.get("fdAccNo") %>">


                                        <button type="submit"
                                                class="break-btn"
                                                onclick="return confirm('Are you sure you want to break this Fixed Deposit?');">

                                            Break FD

                                        </button>

                                    </form>


                                <%
                                    }
                                    else {
                                %>


                                    <span class="no-action">
                                        —
                                    </span>


                                <%
                                    }
                                %>

                            </td>


                        </tr>


                    <%
                        }
                    %>


                    </tbody>

                </table>


            <%
                }
            %>


        </div>


        <!-- BACK TO HOME -->

        <a href="NavClient.jsp"
           class="back-btn">

            Back to Home

        </a>


    </div>


</body>

</html>