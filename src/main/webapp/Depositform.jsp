
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Check whether the client is logged in
    javax.servlet.http.HttpSession userSession =
            request.getSession(false);

    if (userSession == null ||
        userSession.getAttribute("cid") == null) {

        response.sendRedirect("Login.jsp");
        return;
    }

    // Get logged-in customer's CID from session
    String cid = (String) userSession.getAttribute("cid");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deposit Money</title>

<style>
body {
    font-family: Arial, sans-serif;
   background: linear-gradient(135deg, #061a2b, #0d4668, #16809b);
    margin: 0;
    padding: 0;
}

.container {
    width: 400px;
    margin: 80px auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.15);
}

h2 {
    text-align: center;
    margin-bottom: 25px;
}

label {
    display: block;
    margin-top: 15px;
    margin-bottom: 5px;
    font-weight: bold;
}

input {
    width: 100%;
    padding: 10px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 5px;
}

button {
    width: 100%;
    padding: 12px;
    margin-top: 25px;
    border: none;
    border-radius: 5px;
    background-color: #007bff;
    color: white;
    font-size: 16px;
    cursor: pointer;
}

button:hover {
    background-color: #0056b3;
}

.info {
    font-size: 13px;
    color: #666;
    margin-top: 15px;
    text-align: center;
}

.dashboard-btn {
    display: block;
    width: 70%;
    margin: 20px auto 0;
    padding: 9px;
    background: transparent;
    color: #0d4668;
    border: 2px solid #16809b;
    border-radius: 7px;
    font-size: 13px;
    font-weight: bold;
    text-align: center;
    text-decoration: none;
    transition: 0.3s;
}

.dashboard-btn:hover {
    background: #16809b;
    color: white;
}

</style>

</head>

<body>

<div class="container">

    <h2>Deposit Money</h2>

    <form action="DepositServe" method="post">

        <label for="accNo">Destination Account Number</label>
        <input type="text"
               id="accNo"
               name="accNo"
               placeholder="Enter account number"
               required>

        <label for="depositdt">Deposit Date</label>
        <input type="date"
               id="depositdt"
               name="depositdt"
               required>

        <label for="amount">Amount</label>
        <input type="number"
               id="amount"
               name="amount"
               step="0.01"
               min="0.01"
               placeholder="Enter amount"
               required>

        <button type="submit">Deposit</button>

    </form>

    <div class="info">
        Please verify the destination account number carefully before submitting the deposit.
    </div>
<a href="FundTransfer.jsp" class="dashboard-btn">
    &#8592; GO BACK</a>
</div>

</body>
</html>
