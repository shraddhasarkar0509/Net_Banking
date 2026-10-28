
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Fund Transfer Confirmation</title>
    <style>
        .success-box {
            background-color: #e6f4ea;
            color: #137333;
            padding: 18px 24px;
            border: 1px solid #ceead6;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow:0 2px 4px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>

    <!-- 1. Check if the attribute exists before displaying -->
    <% if (request.getAttribute("amt") != null) { %>
        
        <div class="success-box">
            <h2>🎉 Success!</h2>
            <p>Your Fund has been transferred successfully</p>
        </div>

        <!-- 2. Display the maturity amount using Expression Language (EL) -->
         <h3>Fund Transfer Receipt</h3>
        <p><strong>Sender Account:</strong> ${sacc}</p>
        <p><strong>Benificiary Account:</strong>  ${bacc}</p>
        <p><strong>Amount Transferred:</strong> ${amt}</p>

    <% } else { %>
        <!-- Fallback if someone tries to access the page directly without submitting the form -->
        <p style="color: red;">Error: No deposit details found. Please submit the form first.</p>
    <% } %>

</body>
</html>