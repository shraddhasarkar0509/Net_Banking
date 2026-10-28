
package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TransferDao;

@WebServlet("/TransferServe")
public class TransferServe extends HttpServlet {

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

        // Get CID from session
        String cid = (String) session.getAttribute("cid");

        // Get values from Amount_Transfer.jsp
        String sacc = request.getParameter("sacc");
        String bacc = request.getParameter("bacc");
        String transdt = request.getParameter("transdt");
        String amountStr = request.getParameter("amount");

        try {

            // Check empty fields
            if (sacc == null || sacc.trim().isEmpty()
                    || bacc == null || bacc.trim().isEmpty()
                    || transdt == null || transdt.trim().isEmpty()
                    || amountStr == null || amountStr.trim().isEmpty()) {

                response.sendRedirect("TransferFailed.jsp");
                return;
            }

            // Convert amount
            double amount = Double.parseDouble(amountStr);

            // Amount must be positive
            if (amount <= 0) {
                response.sendRedirect("TransferFailed.jsp");
                return;
            }

            // Create DAO object
            TransferDao dao = new TransferDao();

            // Call DAO
            boolean result = dao.transferAmount(
                    cid,
                    sacc,
                    bacc,
                    transdt,
                    amount
            );

            // Redirect according to result
            if (result) {
                response.sendRedirect("TransferSuccess.jsp");
            } else {
                response.sendRedirect("TransferFailed.jsp");
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();
            response.sendRedirect("TransferFailed.jsp");

        } catch (Exception e) {

            e.printStackTrace();
            response.sendRedirect("TransferFailed.jsp");
        }
    }
}
