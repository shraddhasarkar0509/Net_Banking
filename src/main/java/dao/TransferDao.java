
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import utilities.ConnectionFactory;

public class TransferDao {

    public boolean transferAmount(String cid,
                                  String sacc,
                                  String bacc,
                                  String transdt,
                                  double amount) {

        Connection cn = null;

        try {

            cn = new ConnectionFactory().getConn();
            cn.setAutoCommit(false);

            // ---------------------------------------------------------
            // 1. Sender must belong to logged-in CID
            // ---------------------------------------------------------

            String senderSql =
                    "SELECT BALANCE FROM accounts " +
                    "WHERE accNo = ? AND CID = ?";

            try (PreparedStatement ps =
                    cn.prepareStatement(senderSql)) {

                ps.setString(1, sacc);
                ps.setString(2, cid);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        cn.rollback();
                        return false;
                    }

                    double senderBalance =
                            rs.getDouble("BALANCE");

                    // Amount must be positive
                    if (amount <= 0) {
                        cn.rollback();
                        return false;
                    }

                    // Sender must maintain minimum ₹5000
                    if (senderBalance - amount < 5000) {
                        cn.rollback();
                        return false;
                    }
                }
            }


            // ---------------------------------------------------------
            // 2. Beneficiary account must exist
            // ---------------------------------------------------------

            String beneficiarySql =
                    "SELECT accNo FROM accounts WHERE accNo = ?";

            try (PreparedStatement ps =
                    cn.prepareStatement(beneficiarySql)) {

                ps.setString(1, bacc);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        cn.rollback();
                        return false;
                    }
                }
            }


            // ---------------------------------------------------------
            // 3. Sender and beneficiary cannot be same
            // ---------------------------------------------------------

            if (sacc.equals(bacc)) {
                cn.rollback();
                return false;
            }


            // ---------------------------------------------------------
            // 4. Deduct from sender
            // ---------------------------------------------------------

            String deductSql =
                    "UPDATE accounts " +
                    "SET BALANCE = BALANCE - ? " +
                    "WHERE accNo = ? " +
                    "AND CID = ? " +
                    "AND BALANCE - ? >= 5000";

            try (PreparedStatement ps =
                    cn.prepareStatement(deductSql)) {

                ps.setDouble(1, amount);
                ps.setString(2, sacc);
                ps.setString(3, cid);
                ps.setDouble(4, amount);

                if (ps.executeUpdate() != 1) {
                    cn.rollback();
                    return false;
                }
            }


            // ---------------------------------------------------------
            // 5. Credit beneficiary
            // ---------------------------------------------------------

            String creditSql =
                    "UPDATE accounts " +
                    "SET BALANCE = BALANCE + ? " +
                    "WHERE accNo = ?";

            try (PreparedStatement ps =
                    cn.prepareStatement(creditSql)) {

                ps.setDouble(1, amount);
                ps.setString(2, bacc);

                if (ps.executeUpdate() != 1) {
                    cn.rollback();
                    return false;
                }
            }


            // ---------------------------------------------------------
            // 6. Save transfer in fund_transfer
            // ---------------------------------------------------------

            String insertSql =
                    "INSERT INTO fund_transfer " +
                    "(sacc, bacc, transdt, amount) " +
                    "VALUES (?, ?, ?, ?)";

            try (PreparedStatement ps =
                    cn.prepareStatement(insertSql)) {

                ps.setString(1, sacc);
                ps.setString(2, bacc);
                ps.setString(3, transdt);
                ps.setDouble(4, amount);

                if (ps.executeUpdate() != 1) {
                    cn.rollback();
                    return false;
                }
            }


            // ---------------------------------------------------------
            // 7. Get beneficiary CID
            // ---------------------------------------------------------

            String beneficiaryCid = null;

            String getCidSql =
                    "SELECT CID FROM accounts WHERE accNo = ?";

            try (PreparedStatement ps =
                    cn.prepareStatement(getCidSql)) {

                ps.setString(1, bacc);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        beneficiaryCid =
                                rs.getString("CID");
                    } else {
                        cn.rollback();
                        return false;
                    }
                }
            }


            // ---------------------------------------------------------
            // 8. Insert sender transaction
            // ---------------------------------------------------------

            String transactionSql =
                    "INSERT INTO transactions " +
                    "(cid, accNo, transDate, type, description, amount, mode) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps =
                    cn.prepareStatement(transactionSql)) {

                ps.setString(1, cid);
                ps.setString(2, sacc);
                ps.setString(3, transdt);
                ps.setString(4, "TRANSFER");
                ps.setString(5, "Transfer to " + bacc);
                ps.setDouble(6, -amount);
                ps.setString(7, "ONLINE");

                if (ps.executeUpdate() != 1) {
                    cn.rollback();
                    return false;
                }
            }


            // ---------------------------------------------------------
            // 9. Insert beneficiary transaction
            // ---------------------------------------------------------

            try (PreparedStatement ps =
                    cn.prepareStatement(transactionSql)) {

                ps.setString(1, beneficiaryCid);
                ps.setString(2, bacc);
                ps.setString(3, transdt);
                ps.setString(4, "TRANSFER");
                ps.setString(5, "Received from " + sacc);
                ps.setDouble(6, amount);
                ps.setString(7, "ONLINE");

                if (ps.executeUpdate() != 1) {
                    cn.rollback();
                    return false;
                }
            }


            // ---------------------------------------------------------
            // 10. Commit everything
            // ---------------------------------------------------------

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
