package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TransferDao;

@WebServlet("/Fund_TransferServe")
public class Fund_TransferServe extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        String sacc = request.getParameter("sacc");
        String bacc = request.getParameter("bacc");
        String transdt = request.getParameter("transdt");

        String amountStr = request.getParameter("amt");

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null || session.getAttribute("cid") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // CID comes from session
        String cid = (String) session.getAttribute("cid");

        double amt;

        try {
            amt = Double.parseDouble(amountStr);
        } catch (Exception e) {
            response.sendRedirect("Error.jsp");
            return;
        }

        TransferDao transferDao = new TransferDao();

        boolean isSaved = transferDao.transferAmount(
                cid,
                sacc,
                bacc,
                transdt,
                amt
        );

        if (isSaved) {

            request.setAttribute("sacc", sacc);
            request.setAttribute("bacc", bacc);
            request.setAttribute("amt", amt);

            request.getRequestDispatcher("F_Transfer.jsp")
                   .forward(request, response);

        } else {

            response.sendRedirect("Error.jsp");
        }
    }
}