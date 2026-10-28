<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    List<Map<String, Object>> transactions =
        (List<Map<String, Object>>) request.getAttribute("transactions");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transaction Details</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #0f172a, #1e1b4b, #311042);
        }

        .container {
            margin-top: 40px;
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .card-header {
            font-size: 22px;
            font-weight: bold;
        }

        table {
            background: white;
        }

        .amount {
            font-weight: bold;
        }

        .back-btn {
            margin-top: 20px;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="card">

        <div class="card-header text-center">
            Transaction Details
        </div>

        <div class="card-body">

            <%
                if (transactions != null && !transactions.isEmpty()) {
            %>

            <div class="table-responsive">

                <table class="table table-bordered table-hover">

                    <thead class="thead-dark">
                        <tr>
                            <th>Transaction ID</th>
                            <th>Date</th>
                            <th>Account No</th>
                            <th>Type</th>
                            <th>Description</th>
                            <th>Amount</th>
                            <th>Mode</th>
                        </tr>
                    </thead>

                    <tbody>

                    <%
                        for (Map<String, Object> t : transactions) {
                    %>

                        <tr>

                            <td>
                                <%= t.get("transId") %>
                            </td>

                            <td>
                                <%= t.get("transDate") %>
                            </td>

                            <td>
                                <%= t.get("accNo") %>
                            </td>

                            <td>
                                <%= t.get("type") %>
                            </td>

                            <td>
                                <%= t.get("description") %>
                            </td>

                            <td class="amount">
                                ₹<%= t.get("amount") %>
                            </td>

                            <td>
                                <%= t.get("mode") %>
                            </td>

                        </tr>

                    <%
                        }
                    %>

                    </tbody>

                </table>

            </div>

            <%
                } else {
            %>

                <div class="alert alert-info text-center">
                    No transactions found.
                </div>

            <%
                }
            %>

            <div class="text-center back-btn">
                <a href="NavClient.jsp"
                   class="btn btn-primary">
                    Back to Home
                </a>
            </div>

        </div>
    </div>

</div>

</body>
</html>

