package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.RegisterDao;

@WebServlet("/LoginServe")
public class LoginServe extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        
        // 1. Get user input parameters
        String cid = request.getParameter("cid");
        String pass = request.getParameter("pass");
        
        // 2. Instantiate DAO and check credentials
        RegisterDao rdao = new RegisterDao();
        boolean flag = rdao.checkPassword(cid, pass);
        
        // 3. Handle routing based on role and verification
        if ("admin".equals(cid) && "admin".equals(pass)) {
            // Valid Admin: Create session and redirect
            HttpSession session = request.getSession();
            session.setAttribute("cid", cid);
            response.sendRedirect("Admin_Menu.jsp");
        } 
        else if (flag) {
            // Valid Registered User: Create session and redirect
            HttpSession session = request.getSession();
            session.setAttribute("cid", cid);
            response.sendRedirect("NavClient.jsp"); 
        } 
        else {
            // Unauthorized entry: Do NOT store session attribute, send straight to error
            response.sendRedirect("Error.jsp");
        }
    }
}
