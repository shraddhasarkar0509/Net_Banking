
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>RD Dashboard</title>

<style>

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', sans-serif;
}

body {
    min-height: 100vh;
    background: linear-gradient(135deg, #0f172a, #1e1b4b, #312e81);
    padding: 35px;
    color: #0f172a;
}

.container {
    max-width: 1200px;
    margin: auto;
}

.header {
    text-align: center;
    color: white;
    margin-bottom: 30px;
}

.header h1 {
    font-size: 32px;
    margin-bottom: 8px;
}

.header p {
    color: #cbd5e1;
    font-size: 15px;
}

.card {
    background: rgba(255,255,255,0.96);
    border-radius: 20px;
    padding: 25px;
    box-shadow: 0 20px 50px rgba(0,0,0,0.35);
    overflow-x: auto;
}

.top-buttons {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.btn {
    display: inline-block;
    padding: 11px 18px;
    border-radius: 10px;
    text-decoration: none;
    font-weight: 600;
    border: none;
    cursor: pointer;
    font-size: 14px;
}

.primary {
    background: #312e81;
    color: white;
}

.secondary {
    background: #e2e8f0;
    color: #1e293b;
}

.danger {
    background: #fee2e2;
    color: #dc2626;
}

.success {
    background: #dcfce7;
    color: #15803d;
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 1000px;
}

th {
    background: #312e81;
    color: white;
    padding: 14px 10px;
    text-align: center;
    font-size: 13px;
}

td {
    padding: 14px 10px;
    text-align: center;
    border-bottom: 1px solid #e2e8f0;
    font-size: 14px;
}

tr:hover {
    background: #f8fafc;
}

.rd-number {
    color: #312e81;
    font-weight: 700;
}

.amount {
    font-weight: 600;
}

.status {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 700;
}

.active {
    background: #dcfce7;
    color: #15803d;
}

.matured {
    background: #fef3c7;
    color: #b45309;
}

.closed {
    background: #e2e8f0;
    color: #475569;
}

.action-form {
    display: inline;
}

.empty {
    text-align: center;
    padding: 50px 20px;
    color: #64748b;
}

.empty h2 {
    color: #312e81;
    margin-bottom: 10px;
}

.error {
    background: #fee2e2;
    color: #b91c1c;
    padding: 12px;
    border-radius: 10px;
    margin-bottom: 20px;
    text-align: center;
}

.installments {
    font-weight: 600;
    color: #312e81;
}

@media(max-width: 700px) {

    body {
        padding: 15px;
    }

    .card {
        padding: 15px;
    }

    .header h1 {
        font-size: 26px;
    }

    .top-buttons {
        flex-direction: column;
        gap: 12px;
        align-items: stretch;
    }

    .top-buttons .btn {
        text-align: center;
    }
}

</style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>Recurring Deposit Dashboard</h1>

        <p>
            Manage and track all your recurring deposits
        </p>

    </div>


    <div class="card">

        <div class="top-buttons">

            <a href="RD.jsp" class="btn primary">
                + Open New RD
            </a>

            <a href="NavClient.jsp" class="btn secondary">
                Back to Home Page
            </a>

        </div>


        <%
            String error = request.getParameter("error");

            if (error != null) {
        %>

            <div class="error">
                <%= error %>
            </div>

        <%
            }
        %>


        <%
            List<Map<String, Object>> rdList =
                (List<Map<String, Object>>)
                request.getAttribute("rdList");

            if (rdList == null || rdList.isEmpty()) {
        %>

            <div class="empty">

                <h2>No Recurring Deposits Found</h2>

                <p>
                    You have not opened any recurring deposit yet.
                </p>

            </div>

        <%
            } else {
        %>


        <table>

            <thead>

                <tr>

                    <th>RD Account No.</th>

                    <th>Savings Account</th>

                    <th>Monthly Installment</th>

                    <th>Rate</th>

                    <th>Tenure</th>

                    <th>Installments</th>

                    <th>Maturity Amount</th>

                    <th>Status</th>

                    <th>Action</th>

                </tr>

            </thead>


            <tbody>

            <%
                for (Map<String, Object> rd : rdList) {

                    String rdAccNo =
                        (String) rd.get("rdAccNo");

                    String accNo =
                        (String) rd.get("accNo");

                    double monthlyAmount =
                        ((Number) rd.get("monthlyAmount"))
                        .doubleValue();

                    double rate =
                        ((Number) rd.get("rate"))
                        .doubleValue();

                    int time =
                        ((Number) rd.get("time"))
                        .intValue();

                    int paidInstallments =
                        ((Number) rd.get("paidInstallments"))
                        .intValue();

                    double maturityAmount =
                        ((Number) rd.get("maturityAmount"))
                        .doubleValue();

                    String status =
                        (String) rd.get("status");
            %>


                <tr>

                    <td class="rd-number">
                        <%= rdAccNo %>
                    </td>

                    <td>
                        <%= accNo %>
                    </td>

                    <td class="amount">
                        ₹<%= String.format("%.2f",
                                           monthlyAmount) %>
                    </td>

                    <td>
                        <%= String.format("%.2f", rate) %>%
                    </td>

                    <td>
                        <%= time %> Months
                    </td>

                    <td class="installments">
                        <%= paidInstallments %> / <%= time %>
                    </td>

                    <td class="amount">
                        ₹<%= String.format("%.2f",
                                           maturityAmount) %>
                    </td>


                    <td>

                    <%
                        if ("ACTIVE".equalsIgnoreCase(status)) {
                    %>

                        <span class="status active">
                            ACTIVE
                        </span>

                    <%
                        } else if ("MATURED".equalsIgnoreCase(status)) {
                    %>

                        <span class="status matured">
                            MATURED
                        </span>

                    <%
                        } else {
                    %>

                        <span class="status closed">
                            CLOSED
                        </span>

                    <%
                        }
                    %>

                    </td>


                    <td>

                    <%
                        if ("ACTIVE".equalsIgnoreCase(status)) {
                    %>

                        <form action="RDDashboardServe"
                              method="post"
                              class="action-form">

                            <input type="hidden"
                                   name="action"
                                   value="break">

                            <input type="hidden"
                                   name="rdAccNo"
                                   value="<%= rdAccNo %>">

                            <button type="submit"
                                    class="btn danger"
                                    onclick="return confirm('Are you sure you want to break this RD?');">

                                Break RD

                            </button>

                        </form>

                    <%
                        } else if ("MATURED".equalsIgnoreCase(status)) {
                    %>

                        <form action="RDDashboardServe"
                              method="post"
                              class="action-form">

                            <input type="hidden"
                                   name="action"
                                   value="transfer">

                            <input type="hidden"
                                   name="rdAccNo"
                                   value="<%= rdAccNo %>">

                            <button type="submit"
                                    class="btn success"
                                    onclick="return confirm('Transfer maturity amount to your savings account?');">

                                Transfer to Savings

                            </button>

                        </form>

                    <%
                        } else {
                    %>

                        —

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

</div>

</body>
</html>
