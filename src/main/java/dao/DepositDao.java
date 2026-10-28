package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import utilities.ConnectionFactory;

public class DepositDao {

    public boolean depositAmount(String accNo,
                                 String depositdt,
                                 double amount) {

        Connection cn = null;

        try {

            cn = new ConnectionFactory().getConn();
            cn.setAutoCommit(false);

            // ---------------------------------------------------------
            // 1. Check account exists and get its owner CID
            // ---------------------------------------------------------

            String checkSql =
                    "SELECT CID FROM accounts WHERE accNo = ?";

            String accountCid = null;

            try (PreparedStatement ps =
                    cn.prepareStatement(checkSql)) {

                ps.setString(1, accNo);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        cn.rollback();
                        return false;
                    }

                    accountCid = rs.getString("CID");
                }
            }

            // ---------------------------------------------------------
            // 2. Validate amount
            // ---------------------------------------------------------

            if (amount <= 0) {
                cn.rollback();
                return false;
            }

            // ---------------------------------------------------------
            // 3. Add amount to destination account
            // ---------------------------------------------------------

            String updateSql =
                    "UPDATE accounts " +
                    "SET BALANCE = BALANCE + ? " +
                    "WHERE accNo = ?";

            try (PreparedStatement ps =
                    cn.prepareStatement(updateSql)) {

                ps.setDouble(1, amount);
                ps.setString(2, accNo);

                if (ps.executeUpdate() != 1) {
                    cn.rollback();
                    return false;
                }
            }

            // ---------------------------------------------------------
            // 4. Store deposit in deposit table
            // ---------------------------------------------------------

            String insertSql =
                    "INSERT INTO deposit (accNo, depositdt, amount) " +
                    "VALUES (?, ?, ?)";

            try (PreparedStatement ps =
                    cn.prepareStatement(insertSql)) {

                ps.setString(1, accNo);
                ps.setString(2, depositdt);
                ps.setDouble(3, amount);

                if (ps.executeUpdate() != 1) {
                    cn.rollback();
                    return false;
                }
            }

            // ---------------------------------------------------------
            // 5. Store deposit in transactions table
            //    Use ACCOUNT OWNER CID, NOT SESSION CID
            // ---------------------------------------------------------

            String transactionSql =
                    "INSERT INTO transactions " +
                    "(cid, accNo, transDate, type, description, amount, mode) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps =
                    cn.prepareStatement(transactionSql)) {

                ps.setString(1, accountCid);
                ps.setString(2, accNo);
                ps.setString(3, depositdt);
                ps.setString(4, "DEPOSIT");
                ps.setString(5, "Amount Deposited");
                ps.setDouble(6, amount);
                ps.setString(7, "CASH");

                if (ps.executeUpdate() != 1) {
                    cn.rollback();
                    return false;
                }
            }

            // ---------------------------------------------------------
            // 6. Everything successful
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