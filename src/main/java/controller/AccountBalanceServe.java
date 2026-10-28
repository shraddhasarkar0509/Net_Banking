package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AccountBalanceDao;

@WebServlet("/AccountBalanceServe")
public class AccountBalanceServe extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing login session
        HttpSession session = request.getSession(false);

        // User must be logged in
        if (session == null ||
            session.getAttribute("cid") == null) {

            response.sendRedirect("Login.jsp");
            return;
        }

        // CID comes ONLY from session
        String cid = (String) session.getAttribute("cid");

        // Account number entered by user
        String accNo = request.getParameter("accNo");

        if (accNo == null || accNo.trim().isEmpty()) {

            request.setAttribute(
                "errorMessage",
                "Please enter an account number."
            );

            request.getRequestDispatcher(
                "AccountBalance.jsp"
            ).forward(request, response);

            return;
        }

        try {

            AccountBalanceDao dao =
                    new AccountBalanceDao();

            // Check balance only if account belongs
            // to the logged-in CID
            Double balance =
                    dao.getAccountBalance(accNo, cid);

            if (balance == null) {

                request.setAttribute(
                    "errorMessage",
                    "Account not found or this account does not belong to your CID."
                );

            } else {

                request.setAttribute(
                    "accountNo",
                    accNo
                );

                request.setAttribute(
                    "balance",
                    balance
                );
            }

            request.getRequestDispatcher(
                "AccountBalance.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                "errorMessage",
                "Unable to retrieve account balance."
            );

            request.getRequestDispatcher(
                "AccountBalance.jsp"
            ).forward(request, response);
        }
    }
}