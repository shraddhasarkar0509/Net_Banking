
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Customer</title>
    <link rel="stylesheet" href="style2.css">

    <style>
        body {
            background-image: url("https://informationage-production.s3.amazonaws.com/uploads/2022/10/shutterstock_322668026-1-e1750840214717.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

          .container h1 {
    display: inline-block;
    padding: 15px 35px;
    margin-bottom: 15px;
    color: white;
    background: rgba(255, 255, 255, 0.12);
    border: 2px solid rgba(255, 255, 255, 0.7);
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    text-align: center;
    letter-spacing: 2px;
    text-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
}
       .container .subtitle {
    color: #ffffff;
    font-size: 20px;
    font-weight: 800;
    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.9);
    letter-spacing: 1px;
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
        
/* Common message design */
.message-box {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 16px 18px;
    margin: 18px 0;
    border-radius: 12px;
    font-size: 15px;
    font-weight: 600;
    line-height: 1.5;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.12);
    animation: slideDown 0.45s ease;
    border-left: 5px solid;
}

/* Success message */
.success-message {
    background: linear-gradient(135deg, #e6fff1, #c9f7df);
    color: #126b43;
    border-left-color: #16a05d;
}

/* Error message */
.error-message {
    background: linear-gradient(135deg, #fff0f0, #ffdada);
    color: #a51d2d;
    border-left-color: #dc3545;
}

/* Icon circle */
.message-icon {
    min-width: 34px;
    height: 34px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 19px;
    font-weight: bold;
}

.success-message .message-icon {
    background: #b8f0d0;
    color: #126b43;
}

.error-message .message-icon {
    background: #ffc8ce;
    color: #a51d2d;
}

/* Message animation */
@keyframes slideDown {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

    </style>
</head>

<body>
    <div class="header">
        <h2>🏦 NET BANKING</h2>
        <p>Admin Panel</p>
    </div>

    <div class="container">
        <h1>CREATE CUSTOMER</h1>
        <p class="subtitle">Enter Customer Details</p>

        <div class="form-box">
            <h2>👤 CREATE CUSTOMER</h2>
            
<% if (request.getAttribute("successMessage") != null) { %>
    <div class="message-box success-message" role="status">
        <span class="message-icon">✓</span>
        <div>
            <strong>Success!</strong><br>
            <%= request.getAttribute("successMessage") %>
        </div>
    </div>
<% } %>

<% if (request.getAttribute("errorMessage") != null) { %>
    <div class="message-box error-message" role="alert">
        <span class="message-icon">!</span>
        <div>
            <strong>Oops! Something went wrong.</strong><br>
            <%= request.getAttribute("errorMessage") %>
        </div>
    </div>
<% } %>
            

            <form action="CustomerAddServe" method="post">
                <label>Customer ID</label>
                <input type="text" name="cid"
                       placeholder="Enter Customer ID" required>

                <label>Name</label>
                <input type="text" name="name"
                       placeholder="Enter Name" required>

                <label>Phone Number</label>
                <input type="text" name="phno"
                       placeholder="Enter Phone Number" required>

                <label>Email</label>
                <input type="email" name="email"
                       placeholder="Enter Email" required>

                <label>PAN Number</label>
                <input type="text" name="panno"
                       placeholder="Enter PAN Number" required>

                <label>Aadhaar Number</label>
                <input type="text" name="adharno"
                       placeholder="Enter Aadhaar Number" required>

                <div class="buttons">
                    <button type="button"
                        onclick="window.location.href='Customer.jsp'">
                        Back
                    </button>

                    <button type="submit">Save Customer</button>
                </div>
            </form>
        </div>
    </div>

    <div class="footer">
        <p>© 2026 Net Banking</p>
    </div>
</body>
</html>
