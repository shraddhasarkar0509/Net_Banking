package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TransactionDetailsDao;

@WebServlet("/TransactionDetailsServe")
public class TransactionDetailsServe extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session
        HttpSession session = request.getSession(false);

        // Check whether client is logged in
        if (session == null || session.getAttribute("cid") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Get CID from session
        String cid = (String) session.getAttribute("cid");

        // Create DAO object
        TransactionDetailsDao dao = new TransactionDetailsDao();

        // Get all transactions of logged-in client
        List<Map<String, Object>> transactions =
                dao.getTransactions(cid);

        // Send transaction list to JSP
        request.setAttribute("transactions", transactions);

        // Forward to transaction details page
        request.getRequestDispatcher("TransactionDetails.jsp")
               .forward(request, response);
    }
}