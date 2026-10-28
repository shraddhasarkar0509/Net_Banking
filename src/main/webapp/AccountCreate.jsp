<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Create Account</title>
<link rel="stylesheet" href="style.css">
<style>
body{
background-image:url("https://informationage-production.s3.amazonaws.com/uploads/2022/10/shutterstock_322668026-1-e1750840214717.jpg");
background-repeat:no-repeat;
background-size:cover;
}
.container h1 {
    color: white;
}

.container p{
    color: white;
}

 .footer {
    text-align: center;
    color: white;
    margin-top: 50px;
    padding: 5px;
    font-size: 16px;
    font-weight: 900;
    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.9);
    letter-spacing: 0.5px;
}
</style>
</head>

<body>

    <div class="header">

        <h2>🏦 NetBanking</h2>

        <p>Admin Panel</p>

    </div>
    
     <div class="container">

        <h1>CREATE CUSTOMER ACCOUNT</h1>

        <p class="subtitle">
            Create a new customer account
        </p>
        
        <div class="form-box">
        <%
String msg = request.getParameter("msg");

if ("success".equals(msg)) {
%>

<div style="
    background-color: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
    padding: 12px 18px;
    border-radius: 8px;
    width: 90%;
    margin: 15px auto;
    font-family: Arial, sans-serif;
    font-weight: bold;
">
    ✓ Account Created Successfully!<br>
    <span style="font-weight: normal;">
        The new account has been added successfully.
    </span>
</div>

<%
} else if ("error".equals(msg)) {
%>

<div style="
    background-color: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
    padding: 12px 18px;
    border-radius: 8px;
    width: 90%;
    margin: 15px auto;
    font-family: Arial, sans-serif;
    font-weight: bold;
">
    ✕ Account Creation Failed!<br>
    <span style="font-weight: normal;">
        The account could not be added. Please check the details and try again.
    </span>
</div>

<%
}
%>

            <h2>👤 CREATE ACCOUNT</h2>
            
            <form action="AccountAddServe" method="post">
                <label>Account Number</label>

                <input type="text" name="accno" placeholder="Enter account number">

                <label>Open Date</label> 

                <input type="date" name="opdate">

                <label>Balance</label>

                <input type="number" name="balance" placeholder="Enter balance">

               <label>Account Type</label>

                <select name="acctype">

                    <option value="">Select account type</option>

                    <option value="Saving">Saving</option>

                    <option value="Current">Current</option>

                </select>
 
                <label>Customer ID</label>

                <input type="text" name="cid" placeholder="Enter customer ID">

                <div class="buttons">

                    <a href="Account.jsp">
                        <button type="button">Back</button>
                    </a>
                    <button type="submit">Add Account </button>

                </div>
            </form>
        </div>
    </div>
    <div class="footer">

        <p>© 2026 NetBanking Admin</p>

    </div>
</body>
</html>