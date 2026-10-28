package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.RegisterDao;

@WebServlet("/LoginServe2")
public class LoginServe2 extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String cid = request.getParameter("cid");
        String pass = request.getParameter("pass");

        // Validate empty or missing input
        if (cid == null || pass == null ||
            cid.trim().isEmpty() || pass.isEmpty()) {

            response.sendRedirect("First.jsp?message=Please enter Customer ID and Password");
            return;
        }

        // Admin Login
        if ("admin".equals(cid) && "admin".equals(pass)) {

            HttpSession session = request.getSession(true);

            session.setAttribute("cid", cid);
            session.setAttribute("role", "admin");

            response.sendRedirect("Admin_Menu.jsp");
            return;
        }

        RegisterDao dao = new RegisterDao();

        // Check whether Customer ID exists
        boolean cidExists = dao.checkCID(cid);

        if (!cidExists) {

            response.sendRedirect(
                "First.jsp?message=Invalid Customer ID! Please contact your bank branch."
            );
            return;
        }

        // Check password
        boolean passwordCorrect = dao.checkPassword(cid, pass);

        if (!passwordCorrect) {

            response.sendRedirect(
                "First.jsp?message=Password is incorrect!!!"
            );
            return;
        }

        // Successful customer login: create session
        HttpSession session = request.getSession(true);

        session.setAttribute("cid", cid);
        session.setAttribute("role", "customer");

        // Open customer dashboard
        response.sendRedirect("NavClient.jsp");
    }
}
