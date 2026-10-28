package dao;
import java.sql.*;


import utilities.ConnectionFactory;
public class AccountDao {
	private Connection cn=null;
	//private Statement st=null;
	private PreparedStatement ps=null;
	//private ResultSet rs=null;
	public String insert_sql="insert into accounts values(?,?,?,?,?)";
	public String update_sql="update accounts set balance=? where accno=?";
	public boolean addData(String  accno, String opdate, double balance , String acctype , String cid  ) {
		// TODO Auto-generated method stub
		try
		{
			ConnectionFactory con=new ConnectionFactory();
		     cn=con.getConn();
			ps=cn.prepareStatement(insert_sql);
		  ps.setString(1,accno);
		  ps.setString(2,opdate);
		  ps.setDouble(3,balance);
		  ps.setString(4,acctype);
		  ps.setString(5,cid);
		  int i = ps.executeUpdate();

	        if (i > 0) {
	            return true;
	        }//saving data into table
		}
		catch(SQLException se)
		{
			se.printStackTrace();
		}
		return false;
		
	}
	public boolean UpdateData(String accno, double balance) {
		// TODO Auto-generated method stub
		try
		{
			 ConnectionFactory con=new ConnectionFactory();
		     cn=con.getConn();
			ps=cn.prepareStatement(update_sql);
		  ps.setDouble(1,balance);
		  ps.setString(2,accno);
		  int i = ps.executeUpdate();

	        if (i > 0) {
	            return true;
	        }//saving data into table
		}
		catch(SQLException se)
		{
			se.printStackTrace();
		}
		return false;
		
	}
}
