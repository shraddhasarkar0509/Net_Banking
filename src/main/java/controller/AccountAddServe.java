package controller;

import java.io.IOException;




import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AccountDao;

/**
 * Servlet implementation class AccountAddServe
 */
@WebServlet("/AccountAddServe")
public class AccountAddServe extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		String accno=request.getParameter("accno");
		String opdate=request.getParameter("opdate");
		double balance=Double.parseDouble(request.getParameter("balance"));
		String acctype=request.getParameter("acctype");
		String cid=request.getParameter("cid");
		 AccountDao adao = new AccountDao();
         boolean result = adao.addData(accno, opdate, balance, acctype, cid);
		if (result) {
            response.sendRedirect("AccountCreate.jsp?msg=success");
        } else {
            response.sendRedirect("AccountCreate.jsp?msg=error");
        }
	}

}
