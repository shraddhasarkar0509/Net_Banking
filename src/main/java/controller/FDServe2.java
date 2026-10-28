package controller;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.FDDao;

@WebServlet("/FDServe2")
public class FDServe2 extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Scheduler for Test Mode
    private static final ScheduledExecutorService scheduler =
            Executors.newScheduledThreadPool(5);

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        FDDao fdao = new FDDao();

        // ---------------------------------------------------------
        // GET LOGGED-IN SESSION
        // ---------------------------------------------------------

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("cid") == null) {

            response.sendRedirect("Login.jsp");
            return;
        }

        // IMPORTANT:
        // CID is taken from session, NOT from request parameter
        String cid = (String) session.getAttribute("cid");

        // ---------------------------------------------------------
        // GET FORM DATA
        // ---------------------------------------------------------

        String accNo = request.getParameter("accNo");
        String fundingType = request.getParameter("fundingType");

        String amtStr = request.getParameter("amt");
        String rateStr = request.getParameter("rate");
        String timeStr = request.getParameter("time");

        String autoPayoutStr = request.getParameter("autoPayout");
        String testModeStr = request.getParameter("testMode");

        String renewalLimitStr = request.getParameter("renewalLimit");

        // ---------------------------------------------------------
        // BASIC VALIDATION
        // ---------------------------------------------------------

        if (accNo == null || accNo.trim().isEmpty()) {

            request.setAttribute("error",
                    "Savings Account Number is required.");

            request.getRequestDispatcher("FD.jsp")
                   .forward(request, response);

            return;
        }

        if (fundingType == null || fundingType.trim().isEmpty()) {

            request.setAttribute("error",
                    "Please select a funding type.");

            request.getRequestDispatcher("FD.jsp")
                   .forward(request, response);

            return;
        }

        // ---------------------------------------------------------
        // PARSE NUMERIC VALUES
        // ---------------------------------------------------------

        double amt;
        double rate;
        int time;

        try {

            amt = Double.parseDouble(amtStr);
            rate = Double.parseDouble(rateStr);
            time = Integer.parseInt(timeStr);

        } catch (Exception e) {

            request.setAttribute("error",
                    "Please enter valid amount, rate and time.");

            request.getRequestDispatcher("FD.jsp")
                   .forward(request, response);

            return;
        }

        // ---------------------------------------------------------
        // VALIDATE AMOUNT
        // ---------------------------------------------------------

        if (amt < 1000) {

            request.setAttribute("error",
                    "Minimum FD amount is ₹1000.");

            request.getRequestDispatcher("FD.jsp")
                   .forward(request, response);

            return;
        }

        // ---------------------------------------------------------
        // VALIDATE RATE
        // ---------------------------------------------------------

        if (rate <= 0) {

            request.setAttribute("error",
                    "Interest rate must be greater than 0.");

            request.getRequestDispatcher("FD.jsp")
                   .forward(request, response);

            return;
        }

        // ---------------------------------------------------------
        // VALIDATE TIME
        // ---------------------------------------------------------

        if (time <= 0) {

            request.setAttribute("error",
                    "FD tenure must be greater than 0.");

            request.getRequestDispatcher("FD.jsp")
                   .forward(request, response);

            return;
        }

        // ---------------------------------------------------------
        // AUTO PAYOUT
        // ---------------------------------------------------------

        boolean autoPayout =
                "on".equalsIgnoreCase(autoPayoutStr)
                || "true".equalsIgnoreCase(autoPayoutStr)
                || "yes".equalsIgnoreCase(autoPayoutStr);

        // ---------------------------------------------------------
        // TEST MODE
        // ---------------------------------------------------------

        boolean testMode =
                "on".equalsIgnoreCase(testModeStr)
                || "true".equalsIgnoreCase(testModeStr)
                || "yes".equalsIgnoreCase(testModeStr);

        // ---------------------------------------------------------
        // RENEWAL LIMIT
        // KEEPING ATOMICINTEGER AS REQUESTED
        // ---------------------------------------------------------

        final java.util.concurrent.atomic.AtomicInteger renewalLimit =
                new java.util.concurrent.atomic.AtomicInteger(0);

        if (!autoPayout) {

            if (renewalLimitStr == null
                    || renewalLimitStr.trim().isEmpty()) {

                request.setAttribute("error",
                        "Please enter renewal limit.");

                request.getRequestDispatcher("FD.jsp")
                       .forward(request, response);

                return;
            }

            try {

                renewalLimit.set(
                        Integer.parseInt(renewalLimitStr)
                );

            } catch (NumberFormatException e) {

                request.setAttribute("error",
                        "Renewal limit must be a valid number.");

                request.getRequestDispatcher("FD.jsp")
                       .forward(request, response);

                return;
            }

            if (renewalLimit.get() < 1) {

                request.setAttribute("error",
                        "Renewal limit must be at least 1.");

                request.getRequestDispatcher("FD.jsp")
                       .forward(request, response);

                return;
            }
        }

        // ---------------------------------------------------------
        // CHECK SAVINGS ACCOUNT BELONGS TO LOGGED-IN CID
        // ---------------------------------------------------------

        if (!fdao.isValidSavingsAccount(cid, accNo)) {

            request.setAttribute("error",
                    "This account does not exist under your Customer ID. Please enter a valid savings account number.");

            request.getRequestDispatcher("FD.jsp")
                   .forward(request, response);

            return;
        }

        // ---------------------------------------------------------
        // ONLINE FUNDING VALIDATION
        // ---------------------------------------------------------

        if (fundingType.equalsIgnoreCase("ONLINE")) {

            double balance =
                    fdao.getAccountBalance(accNo);

            if (balance < 0) {

                request.setAttribute("error",
                        "Unable to retrieve account balance.");

                request.getRequestDispatcher("FD.jsp")
                       .forward(request, response);

                return;
            }

            // At least ₹5000 must remain
            if (balance - amt < 5000) {

                request.setAttribute("error",
                        "At least ₹5000 must remain in your savings account.");

                request.getRequestDispatcher("FD.jsp")
                       .forward(request, response);

                return;
            }
        }

        // ---------------------------------------------------------
        // CALCULATE INITIAL MATURITY
        // ---------------------------------------------------------

        double maturityAmount =
                calculateMaturity(amt, rate, time);

        // ---------------------------------------------------------
        // GENERATE FD ACCOUNT NUMBER
        // ---------------------------------------------------------

        String fdAccNo =
                "FD-" + System.currentTimeMillis();

        // ---------------------------------------------------------
        // SAVE FD
        // ---------------------------------------------------------

        boolean saved;

        if (fundingType.equalsIgnoreCase("ONLINE")) {

            saved = fdao.addDataOnline(
                    fdAccNo,
                    cid,
                    accNo,
                    amt,
                    rate,
                    time,
                    maturityAmount
            );

        } else {

            saved = fdao.addDataCash(
                    fdAccNo,
                    cid,
                    accNo,
                    amt,
                    rate,
                    time,
                    maturityAmount
            );
        }

        if (!saved) {

            request.setAttribute("error",
                    "FD creation failed.");

            request.getRequestDispatcher("FD.jsp")
                   .forward(request, response);

            return;
        }

        // ---------------------------------------------------------
        // CREATE DASHBOARD RECORD
        // ---------------------------------------------------------

        fdao.createDashboard(
                fdAccNo,
                "ACTIVE"
        );

        // ---------------------------------------------------------
        // GET TOTALS
        // ---------------------------------------------------------

        double totalPrincipal =
                fdao.getTotalPrincipal(cid);

        double totalMaturity =
                fdao.getTotalMaturity(cid);

        // ---------------------------------------------------------
        // TEST MODE
        // 1 YEAR = 1 MINUTE
        // ---------------------------------------------------------

        if (testMode) {

            long delayMinutes = time;

            scheduler.schedule(
                    () -> processMaturity(
                            fdao,
                            fdAccNo,
                            cid,
                            accNo,
                            amt,
                            rate,
                            time,
                            maturityAmount,
                            autoPayout,
                            renewalLimit.get(),
                            0
                    ),
                    delayMinutes,
                    TimeUnit.MINUTES
            );
        }

        // ---------------------------------------------------------
        // SEND DATA TO MATURITY.JSP
        // ---------------------------------------------------------

        request.setAttribute(
                "fdAccNo",
                fdAccNo
        );

        request.setAttribute(
                "amt",
                amt
        );

        request.setAttribute(
                "rate",
                rate
        );

        request.setAttribute(
                "time",
                time
        );

        request.setAttribute(
                "maturityAmount",
                maturityAmount
        );

        request.setAttribute(
                "totalPrincipal",
                totalPrincipal
        );

        request.setAttribute(
                "totalMaturity",
                totalMaturity
        );

        request.setAttribute(
                "status",
                "ACTIVE"
        );

        request.getRequestDispatcher("Maturity.jsp")
               .forward(request, response);
    }

    // ---------------------------------------------------------
    // CALCULATE QUARTERLY COMPOUND INTEREST
    // ---------------------------------------------------------

    private double calculateMaturity(
            double principal,
            double rate,
            int time) {

        double r = rate / 100.0;

        double maturity =
                principal *
                Math.pow(
                        (1 + r / 4),
                        4 * time
                );

        return Math.round(maturity * 100.0) / 100.0;
    }

    // ---------------------------------------------------------
    // MATURITY PROCESS
    // ---------------------------------------------------------

    private void processMaturity(
            FDDao fdao,
            String fdAccNo,
            String cid,
            String accNo,
            double principal,
            double rate,
            int time,
            double maturityAmount,
            boolean autoPayout,
            int renewalLimit,
            int renewalCount) {

        // ---------------------------------------------------------
        // CHECK FD DETAILS
        // ---------------------------------------------------------

        Map<String, Object> fd =
                fdao.getFDDetails(
                        fdAccNo,
                        cid
                );

        if (fd == null || fd.isEmpty()) {

            // FD is already closed / unavailable
            return;
        }

        // ---------------------------------------------------------
        // AUTO PAYOUT
        // ---------------------------------------------------------

        if (autoPayout) {

            /*
             * This now does TWO things in one DB transaction:
             *
             * 1. Credits maturity amount to savings account
             * 2. Inserts FD_MATURITY transaction
             */
            boolean credited =
                    fdao.creditSavingsAccount(
                            cid,
                            fdAccNo,
                            accNo,
                            maturityAmount
                    );

            if (credited) {

                fdao.updateFDStatus(
                        fdAccNo,
                        "CLOSED"
                );
            }

            return;
        }

        // ---------------------------------------------------------
        // AUTO RENEWAL
        // ---------------------------------------------------------

        if (renewalCount < renewalLimit) {

            // Previous maturity becomes new principal
            double newPrincipal =
                    maturityAmount;

            // Calculate new maturity
            double newMaturity =
                    calculateMaturity(
                            newPrincipal,
                            rate,
                            time
                    );

            // Update maturity amount
            fdao.updateMaturityAmount(
                    fdAccNo,
                    newMaturity
            );

            // Increase renewal count
            int newRenewalCount =
                    renewalCount + 1;

            fdao.updateRenewalCount(
                    fdAccNo,
                    newRenewalCount
            );

            // Update dashboard status
            fdao.updateFDStatus(
                    fdAccNo,
                    "RENEWED"
            );

            /*
             * No transaction is inserted here because
             * the money is not credited to savings.
             * It remains invested in the FD.
             */

            // Schedule next maturity
            scheduler.schedule(
                    () -> processMaturity(
                            fdao,
                            fdAccNo,
                            cid,
                            accNo,
                            newPrincipal,
                            rate,
                            time,
                            newMaturity,
                            false,
                            renewalLimit,
                            newRenewalCount
                    ),
                    time,
                    TimeUnit.MINUTES
            );

            return;
        }

        // ---------------------------------------------------------
        // RENEWAL LIMIT EXHAUSTED
        // ---------------------------------------------------------

        /*
         * Final maturity amount is credited to savings
         * and FD_MATURITY transaction is recorded.
         */

        boolean credited =
                fdao.creditSavingsAccount(
                        cid,
                        fdAccNo,
                        accNo,
                        maturityAmount
                );

        if (credited) {

            fdao.updateFDStatus(
                    fdAccNo,
                    "CLOSED"
            );
        }
    }
}