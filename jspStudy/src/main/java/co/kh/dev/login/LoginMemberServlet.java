package co.kh.dev.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/loginMemberServlet.do")
public class LoginMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;Charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head>");
		out.println("<style>");
		out.println("#my_table{");
		out.println("margin: 0 auto;");
		out.println("}");
		out.println("</style>");
		out.println("</head>");
		out.println("<body>");
		out.print("<form method='post' action='/jspStudy/loginMemberDBServlet.do'>");
		out.println("<table border='1' width='300' id='my_table'>");
		out.println("<tr>");
		out.println("<th width='100'>이름</th>");
		out.println("<td width='200'>&nbsp;<input type='text' name='name'></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<th width='100'>아이디</th>");
		out.println("<td width='200'>&nbsp;<input type='text' name='id'></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<th width='100'>비번</th>");
		out.println("<td width='200'>&nbsp;<input type='password' name='pass'></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td align='center' colspan='2'>");
		out.println("<input type='submit' value='회원가입하기'>");
		out.println("</td>");
		out.println("</tr>");
		out.println("</form>");
		out.println("</table>");
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
