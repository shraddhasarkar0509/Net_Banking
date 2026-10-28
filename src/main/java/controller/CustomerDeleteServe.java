
package controller;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CustomerDao;

@WebServlet("/CustomerDeleteServe")
public class CustomerDeleteServe extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String cid = request.getParameter("cid");

        if (cid == null || cid.trim().isEmpty()) {
            request.setAttribute("errorMessage",
                    "Please enter a Customer ID.");
            request.getRequestDispatcher("CustomerDel.jsp")
                   .forward(request, response);
            return;
        }

        CustomerDao cdao = new CustomerDao();
        String result = cdao.deleteData(cid.trim());

        if ("SUCCESS".equals(result)) {
            request.setAttribute("successMessage",
                    "Customer deleted successfully!");
        } else if ("NOT_FOUND".equals(result)) {
            request.setAttribute("errorMessage",
                    "Customer ID not found. Please enter a valid Customer ID.");
        } else {
            request.setAttribute("errorMessage",
                    "Unable to delete the customer. Please check whether the customer is linked to an account.");
        }

        request.getRequestDispatcher("CustomerDel.jsp")
               .forward(request, response);
    }
}
