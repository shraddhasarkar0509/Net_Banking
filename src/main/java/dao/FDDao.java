package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import utilities.ConnectionFactory;

public class FDDao {

    // Deduct amount from savings account
    String deductSql =
            "UPDATE accounts SET balance = balance - ? WHERE accNo = ?";

    // Insert FD details
    String insertSql =
            "INSERT INTO fdamount(fdAccNo, cid, accNo, amt, rate, time, maturityAmount) "
          + "VALUES(?, ?, ?, ?, ?, ?, ?)";


    // ---------------------------------------------------------
    // GET SAVINGS ACCOUNT BALANCE
    // ---------------------------------------------------------

    public double getAccountBalance(String accNo) {

        double balance = 0;

        String sql =
                "SELECT balance FROM accounts WHERE accNo = ?";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, accNo);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    balance = rs.getDouble("balance");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return balance;
    }


    // ---------------------------------------------------------
    // CHECK SAVINGS ACCOUNT
    // ---------------------------------------------------------

    public boolean isValidSavingsAccount(String cid,
                                         String accNo) {

        String sql =
                "SELECT * FROM accounts "
              + "WHERE cid = ? AND accNo = ?";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, cid);
            ps.setString(2, accNo);

            try (ResultSet rs = ps.executeQuery()) {

                return rs.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    // ---------------------------------------------------------
    // ADD FD - ONLINE
    // ---------------------------------------------------------

    public boolean addDataOnline(String fdAccNo,
                                 String cid,
                                 String accNo,
                                 double amt,
                                 double rate,
                                 int time,
                                 double maturityAmount) {

        Connection cn = null;

        try {

            cn = new ConnectionFactory().getConn();
            cn.setAutoCommit(false);

            // -------------------------------------------------
            // 1. Insert FD
            // -------------------------------------------------

            try (PreparedStatement ps =
                    cn.prepareStatement(insertSql)) {

                ps.setString(1, fdAccNo);
                ps.setString(2, cid);
                ps.setString(3, accNo);
                ps.setDouble(4, amt);
                ps.setDouble(5, rate);
                ps.setInt(6, time);
                ps.setDouble(7, maturityAmount);

                ps.executeUpdate();
            }


            // -------------------------------------------------
            // 2. Deduct money from savings account
            // -------------------------------------------------

            try (PreparedStatement ps =
                    cn.prepareStatement(deductSql)) {

                ps.setDouble(1, amt);
                ps.setString(2, accNo);

                ps.executeUpdate();
            }


            // -------------------------------------------------
            // 3. Store FD creation transaction
            // -------------------------------------------------

            String transactionSql =
                    "INSERT INTO transactions "
                  + "(cid, accNo, transDate, type, description, amount, mode) "
                  + "VALUES (?, ?, CURDATE(), ?, ?, ?, ?)";

            try (PreparedStatement ps =
                    cn.prepareStatement(transactionSql)) {

                ps.setString(1, cid);
                ps.setString(2, accNo);
                ps.setString(3, "FD_CREATION");
                ps.setString(4, "FD Created - " + fdAccNo);
                ps.setDouble(5, -amt);
                ps.setString(6, "ONLINE");

                ps.executeUpdate();
            }


            // -------------------------------------------------
            // 4. Commit
            // -------------------------------------------------

            cn.commit();

            return true;

        } catch (SQLException e) {

            e.printStackTrace();

            if (cn != null) {

                try {
                    cn.rollback();

                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

        } finally {

            if (cn != null) {

                try {
                    cn.close();

                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return false;
    }


    // ---------------------------------------------------------
    // ADD FD - CASH
    // ---------------------------------------------------------

    public boolean addDataCash(String fdAccNo,
                               String cid,
                               String accNo,
                               double amt,
                               double rate,
                               int time,
                               double maturityAmount) {

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps =
                     cn.prepareStatement(insertSql)) {

            ps.setString(1, fdAccNo);
            ps.setString(2, cid);
            ps.setString(3, accNo);
            ps.setDouble(4, amt);
            ps.setDouble(5, rate);
            ps.setInt(6, time);
            ps.setDouble(7, maturityAmount);

            ps.executeUpdate();

            return true;

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return false;
    }


    // ---------------------------------------------------------
    // CREDIT MATURITY AMOUNT TO SAVINGS ACCOUNT
    // AND STORE TRANSACTION HISTORY
    // ---------------------------------------------------------

    public boolean creditSavingsAccount(String cid,
                                        String fdAccNo,
                                        String accNo,
                                        double amount) {

        Connection cn = null;

        try {

            cn = new ConnectionFactory().getConn();
            cn.setAutoCommit(false);


            // -------------------------------------------------
            // 1. Credit maturity amount
            // -------------------------------------------------

            String creditSql =
                    "UPDATE accounts "
                  + "SET balance = balance + ? "
                  + "WHERE accNo = ? AND CID = ?";

            try (PreparedStatement ps =
                    cn.prepareStatement(creditSql)) {

                ps.setDouble(1, amount);
                ps.setString(2, accNo);
                ps.setString(3, cid);

                if (ps.executeUpdate() != 1) {

                    cn.rollback();
                    return false;
                }
            }


            // -------------------------------------------------
            // 2. Store FD maturity transaction
            // -------------------------------------------------

            String transactionSql =
                    "INSERT INTO transactions "
                  + "(cid, accNo, transDate, type, description, amount, mode) "
                  + "VALUES (?, ?, CURDATE(), ?, ?, ?, ?)";

            try (PreparedStatement ps =
                    cn.prepareStatement(transactionSql)) {

                ps.setString(1, cid);
                ps.setString(2, accNo);
                ps.setString(3, "FD_MATURITY");
                ps.setString(4, "FD Maturity - " + fdAccNo);
                ps.setDouble(5, amount);
                ps.setString(6, "ONLINE");

                if (ps.executeUpdate() != 1) {

                    cn.rollback();
                    return false;
                }
            }


            // -------------------------------------------------
            // 3. Commit both operations
            // -------------------------------------------------

            cn.commit();

            return true;

        } catch (SQLException e) {

            e.printStackTrace();

            if (cn != null) {

                try {
                    cn.rollback();

                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

        } finally {

            if (cn != null) {

                try {
                    cn.close();

                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return false;
    }


    // ---------------------------------------------------------
    // CREATE FD DASHBOARD RECORD
    // ---------------------------------------------------------

    public boolean createDashboard(String fdAccNo,
                                   String status) {

        String sql =
                "INSERT INTO fddashboard(fdAccNo, status, renewal_count) "
              + "VALUES(?, ?, 0)";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps =
                     cn.prepareStatement(sql)) {

            ps.setString(1, fdAccNo);
            ps.setString(2, status);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    // ---------------------------------------------------------
    // UPDATE FD STATUS
    // ---------------------------------------------------------

    public boolean updateFDStatus(String fdAccNo,
                                  String status) {

        String sql =
                "UPDATE fddashboard SET status = ? "
              + "WHERE fdAccNo = ?";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps =
                     cn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, fdAccNo);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    // ---------------------------------------------------------
    // UPDATE RENEWAL COUNT
    // ---------------------------------------------------------

    public boolean updateRenewalCount(String fdAccNo,
                                      int renewalCount) {

        String sql =
                "UPDATE fddashboard SET renewal_count = ? "
              + "WHERE fdAccNo = ?";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps =
                     cn.prepareStatement(sql)) {

            ps.setInt(1, renewalCount);
            ps.setString(2, fdAccNo);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    // ---------------------------------------------------------
    // GET RENEWAL COUNT
    // ---------------------------------------------------------

    public int getRenewalCount(String fdAccNo) {

        int count = 0;

        String sql =
                "SELECT renewal_count FROM fddashboard "
              + "WHERE fdAccNo = ?";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps =
                     cn.prepareStatement(sql)) {

            ps.setString(1, fdAccNo);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    count = rs.getInt("renewal_count");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }


    // ---------------------------------------------------------
    // UPDATE MATURITY AMOUNT
    // ---------------------------------------------------------

    public boolean updateMaturityAmount(String fdAccNo,
                                        double maturityAmount) {

        String sql =
                "UPDATE fdamount SET maturityAmount = ? "
              + "WHERE fdAccNo = ?";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps =
                     cn.prepareStatement(sql)) {

            ps.setDouble(1, maturityAmount);
            ps.setString(2, fdAccNo);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    // ---------------------------------------------------------
    // GET TOTAL PRINCIPAL
    // ---------------------------------------------------------

    public double getTotalPrincipal(String cid) {

        double total = 0;

        String sql =
                "SELECT COALESCE(SUM(amt), 0) "
              + "FROM fdamount WHERE cid = ?";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps =
                     cn.prepareStatement(sql)) {

            ps.setString(1, cid);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    total = rs.getDouble(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }


    // ---------------------------------------------------------
    // GET TOTAL MATURITY
    // ---------------------------------------------------------

    public double getTotalMaturity(String cid) {

        double total = 0;

        String sql =
                "SELECT COALESCE(SUM(maturityAmount), 0) "
              + "FROM fdamount WHERE cid = ?";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps =
                     cn.prepareStatement(sql)) {

            ps.setString(1, cid);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    total = rs.getDouble(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }


    // ---------------------------------------------------------
    // GET FD DASHBOARD
    // ---------------------------------------------------------

    public List<Map<String, Object>> getFDDashboard(String cid) {

        List<Map<String, Object>> list =
                new ArrayList<>();

        String sql =
                "SELECT f.fdAccNo, f.cid, f.accNo, "
              + "f.amt, f.rate, f.time, f.maturityAmount, "
              + "d.status, d.renewal_count "
              + "FROM fdamount f "
              + "INNER JOIN fddashboard d "
              + "ON f.fdAccNo = d.fdAccNo "
              + "WHERE f.cid = ? "
              + "ORDER BY f.fdAccNo";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps =
                     cn.prepareStatement(sql)) {

            ps.setString(1, cid);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Map<String, Object> fd =
                            new HashMap<>();

                    fd.put("fdAccNo",
                           rs.getString("fdAccNo"));

                    fd.put("cid",
                           rs.getString("cid"));

                    fd.put("accNo",
                           rs.getString("accNo"));

                    fd.put("amt",
                           rs.getDouble("amt"));

                    fd.put("rate",
                           rs.getDouble("rate"));

                    fd.put("time",
                           rs.getInt("time"));

                    fd.put("maturityAmount",
                           rs.getDouble("maturityAmount"));

                    fd.put("status",
                           rs.getString("status"));

                    fd.put("renewal_count",
                           rs.getInt("renewal_count"));

                    list.add(fd);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }


    // ---------------------------------------------------------
    // GET FD DETAILS FOR BREAK FD
    // ---------------------------------------------------------

    public Map<String, Object> getFDDetails(String fdAccNo,
                                            String cid) {

        Map<String, Object> fd =
                new HashMap<>();

        String sql =
                "SELECT f.fdAccNo, f.cid, f.accNo, "
              + "f.amt, f.rate, f.time, f.maturityAmount, "
              + "d.status "
              + "FROM fdamount f "
              + "INNER JOIN fddashboard d "
              + "ON f.fdAccNo = d.fdAccNo "
              + "WHERE f.fdAccNo = ? "
              + "AND f.cid = ? "
              + "AND d.status IN ('ACTIVE', 'RENEWED')";

        try (Connection cn = new ConnectionFactory().getConn();
             PreparedStatement ps =
                     cn.prepareStatement(sql)) {

            ps.setString(1, fdAccNo);
            ps.setString(2, cid);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    fd.put("fdAccNo",
                           rs.getString("fdAccNo"));

                    fd.put("cid",
                           rs.getString("cid"));

                    fd.put("accNo",
                           rs.getString("accNo"));

                    fd.put("amt",
                           rs.getDouble("amt"));

                    fd.put("rate",
                           rs.getDouble("rate"));

                    fd.put("time",
                           rs.getInt("time"));

                    fd.put("maturityAmount",
                           rs.getDouble("maturityAmount"));

                    fd.put("status",
                           rs.getString("status"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return fd;
    }


    // ---------------------------------------------------------
    // BREAK FD
    // ---------------------------------------------------------

    public boolean breakFD(String fdAccNo,
                           String cid) {

        Connection cn = null;

        try {

            cn = new ConnectionFactory().getConn();
            cn.setAutoCommit(false);


            // -------------------------------------------------
            // Get FD details
            // -------------------------------------------------

            Map<String, Object> fd =
                    getFDDetails(fdAccNo, cid);

            if (fd.isEmpty()) {

                cn.rollback();
                return false;
            }


            double principal =
                    (Double) fd.get("amt");


            // -------------------------------------------------
            // Premature interest rate
            // -------------------------------------------------

            double prematureRate = 5.0;


            // -------------------------------------------------
            // Calculate premature interest
            // -------------------------------------------------

            double interest =
                    principal * prematureRate / 100.0;


            // -------------------------------------------------
            // Calculate amount to return
            // -------------------------------------------------

            double prematureAmount =
                    principal + interest;


            // -------------------------------------------------
            // IMPORTANT:
            // Change maturity amount to premature amount
            // ONLY when FD is broken.
            // -------------------------------------------------

            String updateAmountSql =
                    "UPDATE fdamount "
                  + "SET maturityAmount = ? "
                  + "WHERE fdAccNo = ?";

            try (PreparedStatement ps =
                    cn.prepareStatement(updateAmountSql)) {

                ps.setDouble(1, prematureAmount);
                ps.setString(2, fdAccNo);

                ps.executeUpdate();
            }


            // -------------------------------------------------
            // Get linked savings account
            // -------------------------------------------------

            String linkedAccNo =
                    (String) fd.get("accNo");


            // -------------------------------------------------
            // Credit amount to savings account
            // -------------------------------------------------

            String creditSql =
                    "UPDATE accounts "
                  + "SET balance = balance + ? "
                  + "WHERE accNo = ? "
                  + "AND CID = ?";

            try (PreparedStatement ps =
                    cn.prepareStatement(creditSql)) {

                ps.setDouble(1, prematureAmount);
                ps.setString(2, linkedAccNo);
                ps.setString(3, cid);

                if (ps.executeUpdate() == 0) {

                    cn.rollback();
                    return false;
                }
            }


            // -------------------------------------------------
            // Store FD break transaction
            // -------------------------------------------------

            String transactionSql =
                    "INSERT INTO transactions "
                  + "(cid, accNo, transDate, type, description, amount, mode) "
                  + "VALUES (?, ?, CURDATE(), ?, ?, ?, ?)";

            try (PreparedStatement ps =
                    cn.prepareStatement(transactionSql)) {

                ps.setString(1, cid);
                ps.setString(2, linkedAccNo);
                ps.setString(3, "FD_BREAK");
                ps.setString(4, "FD Broken - " + fdAccNo);
                ps.setDouble(5, prematureAmount);
                ps.setString(6, "ONLINE");

                if (ps.executeUpdate() != 1) {

                    cn.rollback();
                    return false;
                }
            }


            // -------------------------------------------------
            // Change FD status to CLOSED
            // -------------------------------------------------

            String closeSql =
                    "UPDATE fddashboard "
                  + "SET status = 'CLOSED' "
                  + "WHERE fdAccNo = ? "
                  + "AND status IN ('ACTIVE', 'RENEWED')";

            try (PreparedStatement ps =
                    cn.prepareStatement(closeSql)) {

                ps.setString(1, fdAccNo);

                if (ps.executeUpdate() == 0) {

                    cn.rollback();
                    return false;
                }
            }


            // -------------------------------------------------
            // Commit
            // -------------------------------------------------

            cn.commit();

            return true;

        } catch (SQLException e) {

            e.printStackTrace();

            if (cn != null) {

                try {
                    cn.rollback();

                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

        } finally {

            if (cn != null) {

                try {
                    cn.close();

                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return false;
    }
}