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

import dao.RDDao;

@WebServlet("/RDDashboardServe")
public class RDDashboardServe extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // =========================
    // LOAD RD DASHBOARD
    // =========================
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("cid") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String cid = (String) session.getAttribute("cid");

        try {

            RDDao rdao = new RDDao();

            List<Map<String, Object>> rdList =
                    rdao.getRDDashboard(cid);

            request.setAttribute("rdList", rdList);

            request.getRequestDispatcher("RDDashboard.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "RDDashboard.jsp?error=Unable to load RD dashboard"
            );
        }
    }


    // =========================
    // BREAK RD / TRANSFER
    // =========================
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("cid") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String cid = (String) session.getAttribute("cid");

        String action = request.getParameter("action");
        String rdAccNo = request.getParameter("rdAccNo");

        if (action == null || rdAccNo == null ||
            rdAccNo.trim().isEmpty()) {

            response.sendRedirect(
                "RDDashboardServe?error=Invalid RD request"
            );
            return;
        }

        try {

            RDDao rdao = new RDDao();

            // =========================
            // BREAK RD
            // =========================
            if ("break".equalsIgnoreCase(action)) {

                boolean success =
                        rdao.breakRD(rdAccNo, cid);

                if (success) {

                    response.sendRedirect(
                        "RDDashboardServe?msg=RD broken successfully"
                    );

                } else {

                    response.sendRedirect(
                        "RDDashboardServe?error=Unable to break RD"
                    );
                }

                return;
            }


            // =========================
            // TRANSFER MATURITY
            // =========================
            if ("transfer".equalsIgnoreCase(action)) {

                Map<String, Object> rd =
                        rdao.getRDDetails(rdAccNo, cid);

                if (rd == null || rd.isEmpty()) {

                    response.sendRedirect(
                        "RDDashboardServe?error=RD not found"
                    );

                    return;
                }

                String status =
                        String.valueOf(rd.get("status"));

                if (!"MATURED".equalsIgnoreCase(status)) {

                    response.sendRedirect(
                        "RDDashboardServe?error=RD is not matured"
                    );

                    return;
                }

                String accNo =
                        String.valueOf(rd.get("accNo"));

                double maturityAmount =
                        ((Number) rd.get("maturityAmount"))
                        .doubleValue();

                // IMPORTANT:
                // Pass CID also
                boolean success =
                        rdao.transferMaturityToSavings(
                            rdAccNo,
                            cid,
                            accNo,
                            maturityAmount
                        );

                if (success) {

                    response.sendRedirect(
                        "RDDashboardServe?msg=Maturity amount transferred successfully"
                    );

                } else {

                    response.sendRedirect(
                        "RDDashboardServe?error=Unable to transfer maturity amount"
                    );
                }

                return;
            }


            // =========================
            // INVALID ACTION
            // =========================
            response.sendRedirect(
                "RDDashboardServe?error=Invalid action"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "RDDashboardServe?error=Transaction failed"
            );
        }
    }
}