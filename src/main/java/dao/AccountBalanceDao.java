
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import utilities.ConnectionFactory;

public class AccountBalanceDao {

    public Double getAccountBalance(String accNo, String cid) {

        String sql =
                "SELECT BALANCE FROM accounts " +
                "WHERE accNo = ? AND CID = ?";

        try (
            Connection cn = new ConnectionFactory().getConn();
            PreparedStatement ps = cn.prepareStatement(sql)
        ) {

            ps.setString(1, accNo);
            ps.setString(2, cid);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getDouble("BALANCE");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
