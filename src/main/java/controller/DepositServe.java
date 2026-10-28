package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DepositDao;

@WebServlet("/DepositServe")
public class DepositServe extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        // Check logged-in session
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("cid") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Get form values
        String accNo = request.getParameter("accNo");
        String depositdt = request.getParameter("depositdt");
        String amountStr = request.getParameter("amount");

        try {

            // Validate empty fields
            if (accNo == null || accNo.trim().isEmpty()
                    || depositdt == null || depositdt.trim().isEmpty()
                    || amountStr == null || amountStr.trim().isEmpty()) {

                response.sendRedirect("DepositFailed.jsp");
                return;
            }

            // Convert amount
            double amount = Double.parseDouble(amountStr);

            // Amount must be positive
            if (amount <= 0) {
                response.sendRedirect("DepositFailed.jsp");
                return;
            }

            DepositDao dao = new DepositDao();

            /*
             * Session CID is used ONLY for login/security.
             * Destination account can belong to ANY customer.
             */
            boolean result = dao.depositAmount(
                    accNo,
                    depositdt,
                    amount
            );

            if (result) {
                response.sendRedirect("DepositSuccess.jsp");
            } else {
                response.sendRedirect("DepositFailed.jsp");
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();
            response.sendRedirect("DepositFailed.jsp");

        } catch (Exception e) {

            e.printStackTrace();
            response.sendRedirect("DepositFailed.jsp");
        }
    }
}