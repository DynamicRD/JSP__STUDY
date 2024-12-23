package co.kh.dev.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.kh.dev.common.DBUtility;
import co.kh.dev.login.model.LoginDAO;
import co.kh.dev.login.model.LoginVO;

@WebServlet("/loginMemberList.do")
public class LoginMemberList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		LoginDAO ldao = new LoginDAO();
		ArrayList<LoginVO> list = ldao.listLogin();
		out.println("<html>");
		out.println("<head><title>가입자 리스트</title></head>");
		out.println("<body>");
		for(int i = 0;i<list.size();i++) {
			String id = list.get(i).getId();
			String pass = list.get(i).getPass();
			String name = list.get(i).getName();
			out.println("<table align=center width=500 border=1>");
			out.println("<tr>");
			out.println("<th width=100>아이디</th>");
			out.println("<td width=100 align=center>" + id + "</td>");
			out.println("<th width=100>비밀번호</th>");
			out.println("<td width=100 align=center>" + pass + "</td>");
			out.println("<th width=100>이름</th>");
			out.println("<td width=100 align=center>" + name + "</td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<p>");
		}
		out.println(
				"<p align=center><input type='button' onclick = \"location.href = '/jspStudy/loginServlet.do' \" value='이전화면으로'></p>");
		out.println("</body>");
		out.println("</html>");

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

}
