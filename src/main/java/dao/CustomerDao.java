package dao;
import java.sql.*;
import utilities.ConnectionFactory;

public class CustomerDao {
	private Connection cn=null;
	//private Statement st=null;
	private PreparedStatement ps=null;
	//private ResultSet rs=null;
	public String insert_sql="insert into customer values(?,?,?,?,?,?)";
	public String delete_sql="delete from customer where cid=?";
	public String update_sql="update customer set phno=?,email=? where cid=?";

	public boolean addData(String cid, String name, String phno,
                       String email, String panno, String adharno) {

    try {
        ConnectionFactory con = new ConnectionFactory();
        cn = con.getConn();

        ps = cn.prepareStatement(insert_sql);

        ps.setString(1, cid);
        ps.setString(2, name);
        ps.setString(3, phno);
        ps.setString(4, email);
        ps.setString(5, panno);
        ps.setString(6, adharno);

        int rows = ps.executeUpdate();

        return rows > 0;
    }
    catch (SQLException se) {
        se.printStackTrace();
        return false;
    }
    finally {
        try {
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        }
        catch (SQLException se) {
            se.printStackTrace();
        }
    }
}

	

public String deleteData(String cid) {
    try (
        Connection cn = new ConnectionFactory().getConn();
        PreparedStatement ps = cn.prepareStatement(delete_sql)
    ) {
        ps.setString(1, cid);

        int rows = ps.executeUpdate();

        if (rows > 0) {
            return "SUCCESS";
        } else {
            return "NOT_FOUND";
        }

    } catch (SQLException se) {
        se.printStackTrace();
        return "ERROR";
    }
}


public String UpdateData(String cid, String phno, String email) {

	 String checkSql = "SELECT cid FROM customer WHERE cid = ?";

    try {
        ConnectionFactory con = new ConnectionFactory();
        cn = con.getConn();

        // Check whether Customer ID exists
        PreparedStatement checkPs = cn.prepareStatement(checkSql);
        checkPs.setString(1, cid);

        ResultSet rs = checkPs.executeQuery();

        if (!rs.next()) {
            rs.close();
            checkPs.close();
            return "NOT_FOUND";
        }

        rs.close();
        checkPs.close();

        // Update customer details
        ps = cn.prepareStatement(update_sql);
        ps.setString(1, phno);
        ps.setString(2, email);
        ps.setString(3, cid);

        ps.executeUpdate();

        return "SUCCESS";
    }
    catch (SQLException se) {
        se.printStackTrace();
        return "ERROR";
    }
    finally {
        try {
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        }
        catch (SQLException se) {
            se.printStackTrace();
        }
    }
}

}
