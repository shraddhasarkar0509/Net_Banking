
package controller;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CustomerDao;

@WebServlet("/CustomerAddServe")
public class CustomerAddServe extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String cid = request.getParameter("cid");
        String name = request.getParameter("name");
        String phno = request.getParameter("phno");
        String email = request.getParameter("email");
        String panno = request.getParameter("panno");
        String adharno = request.getParameter("adharno");

        CustomerDao cdao = new CustomerDao();

        boolean result = cdao.addData(
            cid, name, phno, email, panno, adharno);
if (result) {
    request.setAttribute(
        "successMessage",
        "Customer added successfully! The details have been saved."
    );
} else {
    request.setAttribute(
        "errorMessage",
        "This Customer ID already exists, or the customer could not be saved. Please check the details and try again."
    );
}

request.getRequestDispatcher("CustomerCreate.jsp")
       .forward(request, response);

    }
}
