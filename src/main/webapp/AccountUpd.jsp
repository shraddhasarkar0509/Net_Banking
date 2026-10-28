<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Update Account</title>
<link rel="stylesheet" href="style.css">
<style>
body{
background-image:url("https://media.istockphoto.com/id/2186727701/photo/training-webinar-e-learning-skills-business-internet-technology-concept.jpg?s=612x612&w=0&k=20&c=sCZbkR-y3LnqONE_Dcw9v9msBePPR23h1NveiV-wUMI=");
background-repeat:no-repeat;
background-size:cover;
}
.container h1 {
    color: white;
}
.subtitle {
    color: white;
    text-decoration: bold;
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

        <h1>Account Update</h1>

        <p class="subtitle">
            Update an existing customer account
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
    ✓ Account Updated Successfully!<br>
    <span style="font-weight: normal;">
        The account balance has been updated successfully.
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
    ✕ Account Update Failed!<br>
    <span style="font-weight: normal;">
        The account could not be updated. Please check the account number and try again.
    </span>
</div>

<%
}
%>

            <h2>✏️ UPDATE ACCOUNT</h2>

            <form action="AccountUpdateServe" method="post">
                <label>Account Number</label>

                <input type="text" name="accno"  placeholder="Enter account number">

               <label>Balance</label>

                <input type="text" name="balance" placeholder="Enter new balance">

                <div class="buttons">

                    <a href="Account.jsp">

                       <button type="button">Back </button>
                    </a>
                    <button type="submit">Update Account</button>
                    
                </div>
            </form>
        </div>
    </div>
    <div class="footer">

        <p>© 2026 NetBanking Admin</p>

    </div>
</body>
</html>