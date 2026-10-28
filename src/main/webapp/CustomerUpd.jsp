
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Customer</title>
    <link rel="stylesheet" href="style2.css">

    <style>
        body {
            background-image: url("https://media.istockphoto.com/id/2186727701/photo/training-webinar-e-learning-skills-business-internet-technology-concept.jpg?s=612x612&w=0&k=20&c=sCZbkR-y3LnqONE_Dcw9v9msBePPR23h1NveiV-wUMI=");
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

        .message-box {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px 18px;
            margin: 18px 0;
            border-radius: 12px;
            font-size: 14px;
            line-height: 1.5;
            font-weight: 500;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.12);
            animation: slideDown 0.4s ease;
            overflow-wrap: anywhere;
        }

        .success-message {
            color: #126b43;
            background: linear-gradient(135deg, #e6fff1, #c9f7df);
            border-left: 5px solid #16a05d;
        }

        .error-message {
            color: #a51d2d;
            background: linear-gradient(135deg, #fff0f0, #ffdada);
            border-left: 5px solid #dc3545;
        }

        .message-icon {
            flex-shrink: 0;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
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
        <h1>Customer Update</h1>
        <p class="subtitle">Update Customer Details</p>

        <div class="form-box">
            <h2>✏️ UPDATE CUSTOMER</h2>

            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="message-box success-message" role="status">
                    <span class="message-icon">&#10003;</span>
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

            <form action="CustomerUpdateServe" method="post">
                <label>Customer ID</label>
                <input type="text" name="cid"
                       placeholder="Enter Customer ID" required>

                <label>Phone Number</label>
                <input type="text" name="phno"
                       placeholder="Enter Phone Number" required>

                <label>Email</label>
                <input type="email" name="email"
                       placeholder="Enter Email" required>

                <div class="buttons">
                    <button type="button"
                        onclick="window.location.href='Customer.jsp'">
                        Back
                    </button>

                    <button type="submit">Update Customer</button>
                </div>
            </form>
        </div>
    </div>

    <div class="footer">
        <p>© 2026 Net Banking</p>
    </div>
</body>
</html>
