package co.kh.dev.login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/loginMemberChange.do")
public class LoginMemberChange extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;Charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		// 사용자 정보 id,pass
		out.println("<html>");
		out.println("<head>");
		out.println("<style>");
		out.println("#my_table{");
		out.println("margin: 0 auto;");
		out.println("}");
		out.println("</style>");
		out.println("</head>");
		out.println("<body>");
		out.print("<form method='post' action='/jspStudy/loginMemberChangeDB.do'>");
		out.println("<table border='1' width='400' id='my_table'>");
		out.println("<tr>");
		out.println("<th width='200'>새로운 비밀번호</th>");
		out.println("<td width='200'>&nbsp;<input type='password' name='pass'></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<th width='200'>비밀번호 재확인</th>");
		out.println("<td width='200'>&nbsp;<input type='password' name='pass1'></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td align='center' colspan='2'>");
		out.println("<input type='submit' value='확인'>");
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
