package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import utilities.ConnectionFactory;

public class TransactionDetailsDao {

    public List<Map<String, Object>> getTransactions(String cid) {

        List<Map<String, Object>> list =
                new ArrayList<Map<String, Object>>();

        String sql = "SELECT transId, cid, accNo, transDate, type, "
                   + "description, amount, mode "
                   + "FROM transactions "
                   + "WHERE cid = ? "
                   + "ORDER BY transDate DESC, transId DESC";

        try {

            Connection cn = new ConnectionFactory().getConn();

            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, cid);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Map<String, Object> row =
                        new HashMap<String, Object>();

                row.put("transId", rs.getInt("transId"));
                row.put("cid", rs.getString("cid"));
                row.put("accNo", rs.getString("accNo"));
                row.put("transDate", rs.getDate("transDate"));
                row.put("type", rs.getString("type"));
                row.put("description", rs.getString("description"));
                row.put("amount", rs.getBigDecimal("amount"));
                row.put("mode", rs.getString("mode"));

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
}