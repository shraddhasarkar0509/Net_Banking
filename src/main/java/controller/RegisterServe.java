package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RegisterDao;

@WebServlet("/RegisterServe")
public class RegisterServe extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String cid = request.getParameter("cid");
        String pass = request.getParameter("pass");

        RegisterDao dao = new RegisterDao();

        try {

            // Check whether CID exists in customer table
            if (dao.checkCustomerCID(cid)) {

                // Check whether CID is already registered
                if (dao.checkCID(cid)) {

                    request.setAttribute(
                        "errorMessage",
                        "This Customer ID is already registered."
                    );

                    request.getRequestDispatcher("Register.jsp")
                           .forward(request, response);

                } else {

                    // CID exists in customer but not in register
                    boolean isRegistered =
                        dao.insertData(cid, pass);

                    if (isRegistered) {

                        request.setAttribute(
                            "successMessage",
                            "Registration successful! You can now log in."
                        );

                        request.getRequestDispatcher("Register.jsp")
                               .forward(request, response);

                    } else {

                        request.setAttribute(
                            "errorMessage",
                            "Registration failed. Please try again."
                        );

                        request.getRequestDispatcher("Register.jsp")
                               .forward(request, response);
                    }
                }

            } else {

                request.setAttribute(
                    "errorMessage",
                    "Invalid Customer ID! Please contact your bank branch."
                );

                request.getRequestDispatcher("Register.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                "errorMessage",
                "A system error occurred. Please try again later."
            );

            request.getRequestDispatcher("Error.jsp")
                   .forward(request, response);
        }
    }
}