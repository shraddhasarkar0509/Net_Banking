
package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.RDDao;

@WebServlet("/RDServe")
public class RDServe extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Fixed RD interest rate
    private static final double RD_RATE = 6.0;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null || session.getAttribute("cid") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // CID always comes from session
        String cid = (String) session.getAttribute("cid");

        String accNo = request.getParameter("accNo");
        String bookdt = request.getParameter("bookdt");
        String monthlyAmountStr = request.getParameter("monthlyAmount");
        String timeStr = request.getParameter("time");

        String autoPayout = request.getParameter("autoPayout");
        String testMode = request.getParameter("testMode");

        try {

            // Validate input
            if (accNo == null || accNo.trim().isEmpty()
                    || bookdt == null || bookdt.trim().isEmpty()
                    || monthlyAmountStr == null
                    || monthlyAmountStr.trim().isEmpty()
                    || timeStr == null
                    || timeStr.trim().isEmpty()) {

                response.sendRedirect("RD.jsp?error=Please fill all fields");
                return;
            }

            double monthlyAmount =
                    Double.parseDouble(monthlyAmountStr);

            int time =
                    Integer.parseInt(timeStr);

            if (monthlyAmount <= 0 || time <= 0) {
                response.sendRedirect(
                        "RD.jsp?error=Invalid amount or time");
                return;
            }

            RDDao rdao = new RDDao();

            // Check that savings account belongs to logged-in client
            if (!rdao.isValidSavingsAccount(cid, accNo)) {
                response.sendRedirect(
                        "RD.jsp?error=This account does not exist under your Customer ID. Please enter a valid savings account number.");
                return;
            }

            // Check current account balance
            double balance =
                    rdao.getAccountBalance(accNo, cid);

            if (balance < monthlyAmount) {
                response.sendRedirect(
                        "RD.jsp?error=Insufficient balance for first installment");
                return;
            }

            // Generate RD account number
            String rdAccNo =
                    "RD-" + System.currentTimeMillis();

            /*
             * RD maturity calculation
             *
             * Principal = monthlyAmount * number of months
             *
             * Simple RD interest approximation:
             * monthlyAmount * time * (time + 1) * rate / 2400
             */
            double r = RD_RATE / 100.0;

            double maturityAmount =
                    (monthlyAmount * time)
                    + (monthlyAmount * time * (time + 1) * r / 2400);

            // Round to 2 decimal places
            maturityAmount =
                    Math.round(maturityAmount * 100.0) / 100.0;

            // Store RD details
            boolean rdAdded =
                    rdao.addRD(
                            rdAccNo,
                            cid,
                            accNo,
                            monthlyAmount,
                            RD_RATE,
                            time,
                            maturityAmount
                    );

            if (!rdAdded) {
                response.sendRedirect(
                        "RD.jsp?error=Unable to create RD");
                return;
            }

            // Create dashboard entry
            boolean dashboardCreated =
                    rdao.createDashboard(
                            rdAccNo,
                            "ACTIVE"
                    );

            if (!dashboardCreated) {

                // Close RD if dashboard creation fails
                rdao.updateStatus(
                        rdAccNo,
                        cid,
                        "CLOSED"
                );

                response.sendRedirect(
                        "RD.jsp?error=Unable to create RD dashboard");
                return;
            }

            /*
             * First installment is deducted immediately.
             */
            boolean firstInstallment =
                    rdao.deductInstallment(
                            accNo,
                            cid,
                            monthlyAmount
                    );

            if (!firstInstallment) {

                rdao.updateStatus(
                        rdAccNo,
                        cid,
                        "CLOSED"
                );

                response.sendRedirect(
                        "RD.jsp?error=Unable to deduct first installment");
                return;
            }

            /*
             * First installment has been paid.
             */
            rdao.incrementPaidInstallments(
                    rdAccNo,
                    cid
            );

            /*
             * Total amount invested.
             */
            double totalInvested =
                    monthlyAmount * time;

            /*
             * If this is a 1-month RD, the first installment
             * is also the final installment.
             */
            if (time == 1) {

                // First change ACTIVE -> MATURED
                boolean matured =
                        rdao.updateStatus(
                                rdAccNo,
                                cid,
                                "MATURED"
                        );

                if (!matured) {
                    response.sendRedirect(
                            "RD.jsp?error=Unable to mature RD");
                    return;
                }

                /*
                 * If auto payout is selected,
                 * transfer maturity amount to savings account.
                 */
                if ("true".equalsIgnoreCase(autoPayout)
                        || "on".equalsIgnoreCase(autoPayout)) {

                    boolean payout =
                            rdao.transferMaturityToSavings(
                                    rdAccNo,
                                    cid,
                                    accNo,
                                    maturityAmount
                            );

                    if (!payout) {
                        response.sendRedirect(
                                "RD.jsp?error=Unable to credit maturity amount");
                        return;
                    }
                }

                response.sendRedirect(
                        "Rec_Maturity.jsp"
                        + "?rdAccNo=" + rdAccNo
                        + "&monthlyAmount=" + monthlyAmount
                        + "&time=" + time
                        + "&rate=" + RD_RATE
                        + "&maturityAmount=" + maturityAmount
                        + "&totalInvested=" + totalInvested
                        + "&autoPayout=" + autoPayout
                );

                return;
            }

            /*
             * Start processing remaining installments.
             *
             * First installment is already paid,
             * therefore processing starts from month 2.
             */
            startRDProcessing(
                    rdAccNo,
                    cid,
                    accNo,
                    monthlyAmount,
                    time,
                    maturityAmount,
                    autoPayout,
                    testMode
            );

            /*
             * Redirect immediately to maturity/confirmation page.
             */
            response.sendRedirect(
                    "Rec_Maturity.jsp"
                    + "?rdAccNo=" + rdAccNo
                    + "&monthlyAmount=" + monthlyAmount
                    + "&time=" + time
                    + "&rate=" + RD_RATE
                    + "&maturityAmount=" + maturityAmount
                    + "&totalInvested=" + totalInvested
                    + "&autoPayout=" + autoPayout
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "RD.jsp?error=Invalid number format"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "RD.jsp?error=Something went wrong"
            );
        }
    }


    /*
     * Processes remaining RD installments.
     */
    private void startRDProcessing(
            String rdAccNo,
            String cid,
            String accNo,
            double monthlyAmount,
            int totalMonths,
            double maturityAmount,
            String autoPayout,
            String testMode) {

        Thread rdThread = new Thread(() -> {

            try {

                /*
                 * First installment is already deducted.
                 *
                 * Therefore start from month 2.
                 */
                for (int month = 2;
                     month <= totalMonths;
                     month++) {

                    /*
                     * Test mode:
                     * 1 month = 1 minute
                     *
                     * Normal mode:
                     * 1 month = approximately 30 days
                     */
                    if ("true".equalsIgnoreCase(testMode)
                            || "on".equalsIgnoreCase(testMode)) {

                        Thread.sleep(60 * 1000);

                    } else {

                        Thread.sleep(
                                30L * 24L * 60L * 60L * 1000L
                        );
                    }

                    /*
                     * Check whether RD is still active.
                     *
                     * If user broke the RD, stop processing.
                     */
                    if (!rdaoIsActive(rdAccNo, cid)) {
                        return;
                    }

                    /*
                     * Check savings account balance
                     * before deducting installment.
                     */
                    RDDao rdao = new RDDao();

                    double balance =
                            rdao.getAccountBalance(
                                    accNo,
                                    cid
                            );

                    if (balance < monthlyAmount) {

                        /*
                         * Insufficient balance.
                         * Stop further RD processing.
                         */
                        return;
                    }

                    /*
                     * Deduct monthly installment.
                     */
                    boolean installment =
                            rdao.deductInstallment(
                                    accNo,
                                    cid,
                                    monthlyAmount
                            );

                    if (!installment) {
                        return;
                    }

                    /*
                     * Increase paid installment count.
                     */
                    rdao.incrementPaidInstallments(
                            rdAccNo,
                            cid
                    );

                    /*
                     * Final installment reached.
                     */
                    if (month == totalMonths) {

                        /*
                         * IMPORTANT:
                         *
                         * transferMaturityToSavings()
                         * in your current RDDao requires
                         * status = MATURED.
                         *
                         * Therefore first change:
                         *
                         * ACTIVE -> MATURED
                         */
                        boolean matured =
                                rdao.updateStatus(
                                        rdAccNo,
                                        cid,
                                        "MATURED"
                                );

                        if (!matured) {
                            return;
                        }

                        /*
                         * Auto payout:
                         * credit maturity amount to linked
                         * savings account.
                         */
                        if ("true".equalsIgnoreCase(autoPayout)
                                || "on".equalsIgnoreCase(autoPayout)) {

                            boolean payout =
                                    rdao.transferMaturityToSavings(
                                            rdAccNo,
                                            cid,
                                            accNo,
                                            maturityAmount
                                    );

                            if (!payout) {
                                return;
                            }

                        } else {

                            /*
                             * No auto payout.
                             *
                             * RD remains MATURED and the
                             * maturity amount stays recorded
                             * in the RD.
                             */
                            return;
                        }
                    }
                }

            } catch (InterruptedException e) {

                Thread.currentThread().interrupt();

            } catch (Exception e) {

                e.printStackTrace();
            }
        });

        rdThread.start();
    }


    /*
     * Small helper to check whether RD is ACTIVE.
     */
    private boolean rdaoIsActive(
            String rdAccNo,
            String cid) {

        try {

            RDDao rdao = new RDDao();

            return rdao.isRDActive(
                    rdAccNo,
                    cid
            );

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}
