package dao;

import java.sql.*;


import utilities.ConnectionFactory;

public class RegisterDao {
	
	 public boolean checkCustomerCID(String cid) {

	        boolean result = false;

	        try {

	            ConnectionFactory cf = new ConnectionFactory();
	            
	            Connection cn = cf.getConn();

	            String sql = "SELECT cid FROM customer WHERE cid=?";

	            PreparedStatement ps = cn.prepareStatement(sql);

	            ps.setString(1, cid);

	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {

	                result = true;

	            }

	            rs.close();
	            ps.close();
	            cn.close();

	        } catch (SQLException e) {

	            e.printStackTrace();

	        }

	        return result;

	    }



    public boolean checkCID(String cid) {

        boolean result = false;

        try {

            ConnectionFactory cf = new ConnectionFactory();
            
            Connection cn = cf.getConn();

            String sql = "SELECT cid FROM register WHERE cid=?";

            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, cid);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                result = true;

            }

            rs.close();
            ps.close();
            cn.close();

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return result;

    }


    public boolean checkPassword(String cid, String pass) {

        boolean result = false;

        try {

            ConnectionFactory cf = new ConnectionFactory();

            Connection cn = cf.getConn();

            String sql = "SELECT cid FROM register WHERE cid=? AND pass=?";

            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, cid);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                result = true;

            }

            rs.close();
            ps.close();
            cn.close();

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return result;

    }


    // Function to insert Customer ID and Password
    public boolean insertData(String cid, String pass) {

        boolean result = false;

        try {

            ConnectionFactory cf = new ConnectionFactory();

            Connection cn = cf.getConn();

            String sql = "INSERT INTO register(cid, pass) VALUES(?, ?)";

            PreparedStatement ps = cn.prepareStatement(sql);

            ps.setString(1, cid);
            ps.setString(2, pass);

            int rows = ps.executeUpdate();

            if (rows > 0) {

                result = true;

            }

            ps.close();
            cn.close();

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return result;
    }

}
