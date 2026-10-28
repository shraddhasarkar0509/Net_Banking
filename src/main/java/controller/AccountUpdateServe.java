package controller;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AccountDao;

/**
 * Servlet implementation class AccountUpdateServe
 */
@WebServlet("/AccountUpdateServe")
public class AccountUpdateServe extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		String accno=request.getParameter("accno");
		double balance=Double.parseDouble(request.getParameter("balance"));
		AccountDao adao=new AccountDao();
		boolean result = adao.UpdateData(accno, balance);

	    if (result) {
	        response.sendRedirect("AccountUpd.jsp?msg=success");
	    } else {
	        response.sendRedirect("AccountUpd.jsp?msg=error");
	    }
	}

}
