
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import utilities.ConnectionFactory;

public class RDDao {

    // =========================================================
    // 1. ADD RD
    // =========================================================
    public boolean addRD(String rdAccNo,
                         String cid,
                         String accNo,
                         double monthlyAmount,
                         double rate,
                         int time,
                         double maturityAmount) {

        String sql = "INSERT INTO rdamount "
                   + "(rdAccNo, cid, accNo, monthlyAmount, rate, time, maturityAmount, paidInstallments) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, 0)";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, rdAccNo);
            ps.setString(2, cid);
            ps.setString(3, accNo);
            ps.setDouble(4, monthlyAmount);
            ps.setDouble(5, rate);
            ps.setInt(6, time);
            ps.setDouble(7, maturityAmount);

            int rows = ps.executeUpdate();

            ps.close();
            cn.close();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 2. CHECK WHETHER SAVINGS ACCOUNT BELONGS TO CID
    // =========================================================
    public boolean isValidSavingsAccount(String cid, String accNo) {

        String sql = "SELECT accNo FROM accounts "
                   + "WHERE accNo = ? AND CID = ?";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, accNo);
            ps.setString(2, cid);

            ResultSet rs = ps.executeQuery();

            boolean valid = rs.next();

            rs.close();
            ps.close();
            cn.close();

            return valid;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 3. GET ACCOUNT BALANCE
    // =========================================================
    public double getAccountBalance(String accNo, String cid) {

        String sql = "SELECT BALANCE FROM accounts "
                   + "WHERE accNo = ? AND CID = ?";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, accNo);
            ps.setString(2, cid);

            ResultSet rs = ps.executeQuery();

            double balance = 0;

            if (rs.next()) {
                balance = rs.getDouble("BALANCE");
            }

            rs.close();
            ps.close();
            cn.close();

            return balance;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }


    // =========================================================
    // 4. CREATE RD DASHBOARD RECORD
    // =========================================================
    public boolean createDashboard(String rdAccNo,
                                   String status) {

        String sql = "INSERT INTO rddashboard (rdAccNo, status) "
                   + "VALUES (?, ?)";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, rdAccNo);
            ps.setString(2, status);

            int rows = ps.executeUpdate();

            ps.close();
            cn.close();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 5. CHECK WHETHER RD IS ACTIVE
    // =========================================================
    public boolean isRDActive(String rdAccNo,
                              String cid) {

        String sql = "SELECT r.rdAccNo "
                   + "FROM rdamount r "
                   + "JOIN rddashboard d "
                   + "ON r.rdAccNo = d.rdAccNo "
                   + "WHERE r.rdAccNo = ? "
                   + "AND r.cid = ? "
                   + "AND d.status = 'ACTIVE'";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, rdAccNo);
            ps.setString(2, cid);

            ResultSet rs = ps.executeQuery();

            boolean active = rs.next();

            rs.close();
            ps.close();
            cn.close();

            return active;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 6. DEDUCT MONTHLY INSTALLMENT
    // =========================================================
    public boolean deductInstallment(String accNo,
                                     String cid,
                                     double amount) {

        Connection cn = null;

        try {

            cn = new ConnectionFactory().getConn();
            cn.setAutoCommit(false);

            // -------------------------------------------------
            // STEP 1: Deduct installment from savings account
            // -------------------------------------------------
            String sql = "UPDATE accounts "
                       + "SET BALANCE = BALANCE - ? "
                       + "WHERE accNo = ? "
                       + "AND CID = ? "
                       + "AND BALANCE >= ?";

            PreparedStatement ps =
                    cn.prepareStatement(sql);

            ps.setDouble(1, amount);
            ps.setString(2, accNo);
            ps.setString(3, cid);
            ps.setDouble(4, amount);

            int rows = ps.executeUpdate();

            ps.close();

            if (rows == 0) {

                cn.rollback();
                return false;
            }


            // -------------------------------------------------
            // STEP 2: Insert RD installment transaction
            // -------------------------------------------------
            String transactionSql =
                    "INSERT INTO transactions "
                  + "(cid, accNo, transDate, type, description, amount, mode) "
                  + "VALUES (?, ?, CURDATE(), ?, ?, ?, ?)";

            PreparedStatement ps2 =
                    cn.prepareStatement(transactionSql);

            ps2.setString(1, cid);
            ps2.setString(2, accNo);
            ps2.setString(3, "RD_INSTALLMENT");
            ps2.setString(4, "RD Monthly Installment");
            ps2.setDouble(5, -amount);
            ps2.setString(6, "ONLINE");

            int transactionRows =
                    ps2.executeUpdate();

            ps2.close();

            if (transactionRows == 0) {

                cn.rollback();
                return false;
            }

            cn.commit();

            return true;

        } catch (Exception e) {

            e.printStackTrace();

            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            return false;

        } finally {

            try {
                if (cn != null) {
                    cn.setAutoCommit(true);
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    // =========================================================
    // 7. INCREMENT PAID INSTALLMENTS
    // =========================================================
    public boolean incrementPaidInstallments(String rdAccNo,
                                             String cid) {

        String sql = "UPDATE rdamount "
                   + "SET paidInstallments = paidInstallments + 1 "
                   + "WHERE rdAccNo = ? "
                   + "AND cid = ?";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps =
                    cn.prepareStatement(sql);

            ps.setString(1, rdAccNo);
            ps.setString(2, cid);

            int rows = ps.executeUpdate();

            ps.close();
            cn.close();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 8. GET PAID INSTALLMENTS
    // =========================================================
    public int getPaidInstallments(String rdAccNo,
                                   String cid) {

        String sql = "SELECT paidInstallments "
                   + "FROM rdamount "
                   + "WHERE rdAccNo = ? "
                   + "AND cid = ?";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps =
                    cn.prepareStatement(sql);

            ps.setString(1, rdAccNo);
            ps.setString(2, cid);

            ResultSet rs = ps.executeQuery();

            int paid = 0;

            if (rs.next()) {
                paid = rs.getInt("paidInstallments");
            }

            rs.close();
            ps.close();
            cn.close();

            return paid;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }


    // =========================================================
    // 9. CREDIT SAVINGS ACCOUNT
    // =========================================================
    public boolean creditSavingsAccount(String accNo,
                                        String cid,
                                        double amount) {

        String sql = "UPDATE accounts "
                   + "SET BALANCE = BALANCE + ? "
                   + "WHERE accNo = ? "
                   + "AND CID = ?";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps =
                    cn.prepareStatement(sql);

            ps.setDouble(1, amount);
            ps.setString(2, accNo);
            ps.setString(3, cid);

            int rows = ps.executeUpdate();

            ps.close();
            cn.close();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 10. UPDATE RD STATUS
    // =========================================================
    public boolean updateStatus(String rdAccNo,
                                 String cid,
                                 String status) {

        String sql = "UPDATE rddashboard d "
                   + "JOIN rdamount r "
                   + "ON d.rdAccNo = r.rdAccNo "
                   + "SET d.status = ? "
                   + "WHERE d.rdAccNo = ? "
                   + "AND r.cid = ?";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps =
                    cn.prepareStatement(sql);

            ps.setString(1, status);
            ps.setString(2, rdAccNo);
            ps.setString(3, cid);

            int rows = ps.executeUpdate();

            ps.close();
            cn.close();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 11. GET RD DASHBOARD
    // =========================================================
    public List<Map<String, Object>> getRDDashboard(String cid) {

        List<Map<String, Object>> list =
                new ArrayList<Map<String, Object>>();

        String sql = "SELECT r.rdAccNo, "
                   + "r.accNo, "
                   + "r.monthlyAmount, "
                   + "r.rate, "
                   + "r.time, "
                   + "r.maturityAmount, "
                   + "r.paidInstallments, "
                   + "d.status "
                   + "FROM rdamount r "
                   + "JOIN rddashboard d "
                   + "ON r.rdAccNo = d.rdAccNo "
                   + "WHERE r.cid = ? "
                   + "ORDER BY r.rdAccNo DESC";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps =
                    cn.prepareStatement(sql);

            ps.setString(1, cid);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Map<String, Object> row =
                        new HashMap<String, Object>();

                row.put("rdAccNo",
                        rs.getString("rdAccNo"));

                row.put("accNo",
                        rs.getString("accNo"));

                row.put("monthlyAmount",
                        rs.getDouble("monthlyAmount"));

                row.put("rate",
                        rs.getDouble("rate"));

                row.put("time",
                        rs.getInt("time"));

                row.put("maturityAmount",
                        rs.getDouble("maturityAmount"));

                row.put("paidInstallments",
                        rs.getInt("paidInstallments"));

                row.put("status",
                        rs.getString("status"));

                list.add(row);
            }

            rs.close();
            ps.close();
            cn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    // =========================================================
    // 12. GET RD DETAILS
    // =========================================================
    public Map<String, Object> getRDDetails(String rdAccNo,
                                            String cid) {

        Map<String, Object> rd =
                new HashMap<String, Object>();

        String sql = "SELECT r.rdAccNo, "
                   + "r.cid, "
                   + "r.accNo, "
                   + "r.monthlyAmount, "
                   + "r.rate, "
                   + "r.time, "
                   + "r.maturityAmount, "
                   + "r.paidInstallments, "
                   + "d.status "
                   + "FROM rdamount r "
                   + "JOIN rddashboard d "
                   + "ON r.rdAccNo = d.rdAccNo "
                   + "WHERE r.rdAccNo = ? "
                   + "AND r.cid = ? "
                   + "AND d.status IN ('ACTIVE','MATURED')";

        try {

            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps =
                    cn.prepareStatement(sql);

            ps.setString(1, rdAccNo);
            ps.setString(2, cid);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                rd.put("rdAccNo",
                        rs.getString("rdAccNo"));

                rd.put("cid",
                        rs.getString("cid"));

                rd.put("accNo",
                        rs.getString("accNo"));

                rd.put("monthlyAmount",
                        rs.getDouble("monthlyAmount"));

                rd.put("rate",
                        rs.getDouble("rate"));

                rd.put("time",
                        rs.getInt("time"));

                rd.put("maturityAmount",
                        rs.getDouble("maturityAmount"));

                rd.put("paidInstallments",
                        rs.getInt("paidInstallments"));

                rd.put("status",
                        rs.getString("status"));
            }

            rs.close();
            ps.close();
            cn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rd;
    }


    // =========================================================
    // 13. TRANSFER MATURITY AMOUNT TO SAVINGS
    // =========================================================
    public boolean transferMaturityToSavings(String rdAccNo,
                                             String cid,
                                             String accNo,
                                             double maturityAmount) {

        Connection cn = null;

        try {

            cn = new ConnectionFactory().getConn();
            cn.setAutoCommit(false);

            // -------------------------------------------------
            // STEP 1: Verify RD belongs to CID and is MATURED
            // -------------------------------------------------
            String checkRD =
                    "SELECT r.accNo, d.status "
                  + "FROM rdamount r "
                  + "JOIN rddashboard d "
                  + "ON r.rdAccNo = d.rdAccNo "
                  + "WHERE r.rdAccNo = ? "
                  + "AND r.cid = ? "
                  + "AND d.status = 'MATURED' "
                  + "FOR UPDATE";

            PreparedStatement ps1 =
                    cn.prepareStatement(checkRD);

            ps1.setString(1, rdAccNo);
            ps1.setString(2, cid);

            ResultSet rs1 =
                    ps1.executeQuery();

            if (!rs1.next()) {

                rs1.close();
                ps1.close();

                cn.rollback();
                return false;
            }

            String actualAccNo =
                    rs1.getString("accNo");

            rs1.close();
            ps1.close();


            // -------------------------------------------------
            // STEP 2: Make sure savings account is same
            // -------------------------------------------------
            if (!actualAccNo.equals(accNo)) {

                cn.rollback();
                return false;
            }


            // -------------------------------------------------
            // STEP 3: Credit savings account
            // -------------------------------------------------
            String creditSQL =
                    "UPDATE accounts "
                  + "SET BALANCE = BALANCE + ? "
                  + "WHERE accNo = ? "
                  + "AND CID = ?";

            PreparedStatement ps2 =
                    cn.prepareStatement(creditSQL);

            ps2.setDouble(1, maturityAmount);
            ps2.setString(2, accNo);
            ps2.setString(3, cid);

            int credited =
                    ps2.executeUpdate();

            ps2.close();

            if (credited == 0) {

                cn.rollback();
                return false;
            }


            // -------------------------------------------------
            // STEP 4: Insert RD maturity transaction
            // -------------------------------------------------
            String transactionSql =
                    "INSERT INTO transactions "
                  + "(cid, accNo, transDate, type, description, amount, mode) "
                  + "VALUES (?, ?, CURDATE(), ?, ?, ?, ?)";

            PreparedStatement ps3 =
                    cn.prepareStatement(transactionSql);

            ps3.setString(1, cid);
            ps3.setString(2, accNo);
            ps3.setString(3, "RD_MATURITY");
            ps3.setString(4, "RD Maturity Amount");
            ps3.setDouble(5, maturityAmount);
            ps3.setString(6, "ONLINE");

            int transactionRows =
                    ps3.executeUpdate();

            ps3.close();

            if (transactionRows == 0) {

                cn.rollback();
                return false;
            }


            // -------------------------------------------------
            // STEP 5: Close RD
            // -------------------------------------------------
            String closeSQL =
                    "UPDATE rddashboard d "
                  + "JOIN rdamount r "
                  + "ON d.rdAccNo = r.rdAccNo "
                  + "SET d.status = 'CLOSED' "
                  + "WHERE d.rdAccNo = ? "
                  + "AND r.cid = ? "
                  + "AND d.status = 'MATURED'";

            PreparedStatement ps4 =
                    cn.prepareStatement(closeSQL);

            ps4.setString(1, rdAccNo);
            ps4.setString(2, cid);

            int closed =
                    ps4.executeUpdate();

            ps4.close();

            if (closed == 0) {

                cn.rollback();
                return false;
            }

            cn.commit();

            return true;

        } catch (Exception e) {

            e.printStackTrace();

            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            return false;

        } finally {

            try {
                if (cn != null) {
                    cn.setAutoCommit(true);
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    // =========================================================
    // 14. BREAK RD
    // =========================================================
    public boolean breakRD(String rdAccNo,
                            String cid) {

        Connection cn = null;

        try {

            cn = new ConnectionFactory().getConn();
            cn.setAutoCommit(false);


            // -------------------------------------------------
            // STEP 1: Get RD details
            // -------------------------------------------------
            String sql =
                    "SELECT r.accNo, "
                  + "r.monthlyAmount, "
                  + "r.paidInstallments, "
                  + "d.status "
                  + "FROM rdamount r "
                  + "JOIN rddashboard d "
                  + "ON r.rdAccNo = d.rdAccNo "
                  + "WHERE r.rdAccNo = ? "
                  + "AND r.cid = ? "
                  + "AND d.status = 'ACTIVE' "
                  + "FOR UPDATE";

            PreparedStatement ps =
                    cn.prepareStatement(sql);

            ps.setString(1, rdAccNo);
            ps.setString(2, cid);

            ResultSet rs =
                    ps.executeQuery();

            if (!rs.next()) {

                rs.close();
                ps.close();

                cn.rollback();
                return false;
            }

            String accNo =
                    rs.getString("accNo");

            double monthlyAmount =
                    rs.getDouble("monthlyAmount");

            int paidInstallments =
                    rs.getInt("paidInstallments");

            String status =
                    rs.getString("status");

            rs.close();
            ps.close();


            // -------------------------------------------------
            // STEP 2: Make sure RD is active
            // -------------------------------------------------
            if (!"ACTIVE".equals(status)
                    || paidInstallments <= 0) {

                cn.rollback();
                return false;
            }


            // -------------------------------------------------
            // STEP 3: Calculate principal
            // -------------------------------------------------
            double principal =
                    monthlyAmount * paidInstallments;


            // -------------------------------------------------
            // STEP 4: Premature RD interest
            // 5% for breaking RD
            // -------------------------------------------------
            double prematureRate = 5.0;

            double interest =
                    principal
                    * prematureRate
                    * paidInstallments
                    / (12.0 * 100.0);


            // -------------------------------------------------
            // STEP 5: Calculate payout
            // -------------------------------------------------
            double payout =
                    principal + interest;

            payout =
                    Math.round(payout * 100.0)
                    / 100.0;


            // -------------------------------------------------
            // STEP 6: Update maturity amount
            // -------------------------------------------------
            String updateRD =
                    "UPDATE rdamount "
                  + "SET maturityAmount = ? "
                  + "WHERE rdAccNo = ? "
                  + "AND cid = ?";

            PreparedStatement ps2 =
                    cn.prepareStatement(updateRD);

            ps2.setDouble(1, payout);
            ps2.setString(2, rdAccNo);
            ps2.setString(3, cid);

            int updated =
                    ps2.executeUpdate();

            ps2.close();

            if (updated == 0) {

                cn.rollback();
                return false;
            }


            // -------------------------------------------------
            // STEP 7: Credit savings account
            // -------------------------------------------------
            String creditSQL =
                    "UPDATE accounts "
                  + "SET BALANCE = BALANCE + ? "
                  + "WHERE accNo = ? "
                  + "AND CID = ?";

            PreparedStatement ps3 =
                    cn.prepareStatement(creditSQL);

            ps3.setDouble(1, payout);
            ps3.setString(2, accNo);
            ps3.setString(3, cid);

            int credited =
                    ps3.executeUpdate();

            ps3.close();

            if (credited == 0) {

                cn.rollback();
                return false;
            }


            // -------------------------------------------------
            // STEP 8: Insert RD break transaction
            // -------------------------------------------------
            String transactionSql =
                    "INSERT INTO transactions "
                  + "(cid, accNo, transDate, type, description, amount, mode) "
                  + "VALUES (?, ?, CURDATE(), ?, ?, ?, ?)";

            PreparedStatement ps4 =
                    cn.prepareStatement(transactionSql);

            ps4.setString(1, cid);
            ps4.setString(2, accNo);
            ps4.setString(3, "RD_BREAK");
            ps4.setString(4, "RD Premature Break");
            ps4.setDouble(5, payout);
            ps4.setString(6, "ONLINE");

            int transactionRows =
                    ps4.executeUpdate();

            ps4.close();

            if (transactionRows == 0) {

                cn.rollback();
                return false;
            }


            // -------------------------------------------------
            // STEP 9: Close RD
            // -------------------------------------------------
            String closeSQL =
                    "UPDATE rddashboard d "
                  + "JOIN rdamount r "
                  + "ON d.rdAccNo = r.rdAccNo "
                  + "SET d.status = 'CLOSED' "
                  + "WHERE d.rdAccNo = ? "
                  + "AND r.cid = ? "
                  + "AND d.status = 'ACTIVE'";

            PreparedStatement ps5 =
                    cn.prepareStatement(closeSQL);

            ps5.setString(1, rdAccNo);
            ps5.setString(2, cid);

            int closed =
                    ps5.executeUpdate();

            ps5.close();

            if (closed == 0) {

                cn.rollback();
                return false;
            }


            // -------------------------------------------------
            // STEP 10: Commit everything
            // -------------------------------------------------
            cn.commit();

            return true;

        } catch (Exception e) {

            e.printStackTrace();

            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            return false;

        } finally {

            try {
                if (cn != null) {
                    cn.setAutoCommit(true);
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
