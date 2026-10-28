<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Customer</title>
    <link rel="stylesheet" href="style2.css">

    <style>
    body {
            background-image: url("https://static.vecteezy.com/system/resources/previews/008/550/952/non_2x/delete-user-icons-set-neon-vector.jpg");
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

        .message-box {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px 18px;
            margin: 18px 0;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 500;
            box-shadow: 0 5px 15px rgba(0,0,0,0.12);
            animation: slideDown 0.4s ease;
            overflow-wrap: anywhere;
        }

        .success-message {
            background: linear-gradient(135deg, #e7fff0, #c8f7d8);
            border-left: 5px solid #16a05d;
            color: #126b43;
        }

        .error-message {
            background: linear-gradient(135deg, #fff0f0, #ffd6d9);
            border-left: 5px solid #dc3545;
            color: #a51d2d;
        }

        .message-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 34px;
            height: 34px;
            border-radius: 50%;
            font-size: 18px;
            font-weight: bold;
        }

        .success-message .message-icon {
            background: #b5efc9;
        }

        .error-message .message-icon {
            background: #ffc4ca;
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
        <h2>🏦 NET BANKING</h2>
        <p>Admin Panel</p>
    </div>

    <div class="container">
        <h1>DELETE CUSTOMER</h1>
        <p class="subtitle">Delete Customer Details</p>

        <div class="form-box">
            <h2>🗑️ DELETE CUSTOMER</h2>

            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="message-box success-message">
                    <span class="message-icon">✓</span>
                    <span><%= request.getAttribute("successMessage") %></span>
                </div>
            <% } %>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="message-box error-message">
                    <span class="message-icon">!</span>
                    <span><%= request.getAttribute("errorMessage") %></span>
                </div>
            <% } %>

            <form action="CustomerDeleteServe" method="post">
                <label>Customer ID</label>
                <input type="text" name="cid"
                       placeholder="Enter Customer ID" required>

                <div class="buttons">
                    <a href="Customer.jsp">
                        <button type="button">Back</button>
                    </a>

                    <button type="submit"
                        onclick="return confirm('Are you sure you want to delete this customer?');">
                        Delete
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="footer">
        <p>© 2026 Net Banking</p>
    </div>
</body>
</html>
