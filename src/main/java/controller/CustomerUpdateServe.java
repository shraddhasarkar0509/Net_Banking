
package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CustomerDao;

@WebServlet("/CustomerUpdateServe")
public class CustomerUpdateServe extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String cid = request.getParameter("cid");
        String phno = request.getParameter("phno");
        String email = request.getParameter("email");

        CustomerDao cdao = new CustomerDao();

        String result = cdao.UpdateData(cid, phno, email);

        if ("SUCCESS".equals(result)) {
            request.setAttribute(
                "successMessage",
                "Customer details updated successfully!"
            );
        } else if ("NOT_FOUND".equals(result)) {
            request.setAttribute(
                "errorMessage",
                "Customer ID not found. Please enter an existing Customer ID."
            );
        } else {
            request.setAttribute(
                "errorMessage",
                "Failed to update customer. Please try again."
            );
        }

        request.getRequestDispatcher("CustomerUpd.jsp")
               .forward(request, response);
    }
}
