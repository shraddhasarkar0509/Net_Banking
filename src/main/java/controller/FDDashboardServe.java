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

import dao.FDDao;

@WebServlet("/FDDashboardServe")
public class FDDashboardServe extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ---------------------------------------------------------
    // LOAD FD DASHBOARD
    // ---------------------------------------------------------
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String cid = (String) session.getAttribute("cid");

        if (cid == null || cid.trim().isEmpty()) {
            response.sendRedirect("Login.jsp");
            return;
        }

        try {

            FDDao fdao = new FDDao();

            List<Map<String, Object>> fdList =
                    fdao.getFDDashboard(cid);

            request.setAttribute("fdList", fdList);

            request.getRequestDispatcher("FDDashboard.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "FDDashboard.jsp?error=Unable to load FD dashboard"
            );
        }
    }


    // ---------------------------------------------------------
    // HANDLE POST REQUESTS
    // ---------------------------------------------------------
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get logged-in CID from session
        String cid = (String) session.getAttribute("cid");

        if (cid == null || cid.trim().isEmpty()) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String action = request.getParameter("action");

        // -----------------------------------------------------
        // BREAK FD
        // -----------------------------------------------------
        if ("breakFD".equals(action)) {

            String fdAccNo = request.getParameter("fdAccNo");

            if (fdAccNo == null || fdAccNo.trim().isEmpty()) {

                session.setAttribute(
                    "fdMessage",
                    "Invalid FD account number."
                );

                response.sendRedirect("FDDashboardServe");
                return;
            }

            try {

                FDDao fdao = new FDDao();

                boolean result =
                        fdao.breakFD(fdAccNo, cid);

                if (result) {

                    session.setAttribute(
                        "fdMessage",
                        "FD " + fdAccNo
                        + " has been broken successfully. "
                        + "Premature amount has been credited "
                        + "to the linked savings account."
                    );

                } else {

                    session.setAttribute(
                        "fdMessage",
                        "Unable to break FD. "
                        + "The FD may not belong to you or "
                        + "may already be closed."
                    );
                }

            } catch (Exception e) {

                e.printStackTrace();

                session.setAttribute(
                    "fdMessage",
                    "Error while breaking FD: "
                    + e.getMessage()
                );
            }

            // Reload dashboard
            response.sendRedirect("FDDashboardServe");
            return;
        }

        // -----------------------------------------------------
        // OTHER POST REQUESTS
        // -----------------------------------------------------
        doGet(request, response);
    }
}