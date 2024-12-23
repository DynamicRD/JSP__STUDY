package co.kh.dev.login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/loginServlet.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1.사용자정보를 화면에 출력한다.
		// 2.DB를 조회한다
		// 3.화면을 출력한다.
		response.setContentType("text/html;Charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		try {
			// 4.세션 정보 가져오기(세션객체가 있으면 세션객체리턴, 없으면 null 리턴한다)
			HttpSession session = request.getSession(false);
			String superID = "admin";
			// 2.세션정보가 있으면 아이디와 패스워드를 가져온다. 없으면 로그인창으로 이동
			if (session == null) {
				out.println("<html>");
				out.println("<head>");
				out.println("<style>");
				out.println("#my_table{");
				out.println("margin: 0 auto;");
				out.println("}");
				out.println("</style>");
				out.println("</head>");
				out.println("<body>");
				out.print("<form method='post' action='/jspStudy/loginCheck.do'>");
				out.println("<table border='1' width='300' id ='my_table'>");
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
				out.println(
						"<input type='button' onclick = \"location.href = '/jspStudy/loginMemberServlet.do' \" value='회원가입'>");
				out.println("<input type='submit' value='로그인'>");
				out.println("</td>");
				out.println("</tr>");
				out.println("</form>");
				out.println("</table>");
				out.println("</body>");
				out.println("</html>");
			} else if (session != null && ((String) session.getAttribute("id")).equals(superID)) {
				System.out.println("세션고유아이디 " + session.getId());
				// 사용자 정보 id,pass
				String id = (String) session.getAttribute("id");
				String pass = (String) session.getAttribute("pass");
				String name = (String) session.getAttribute("name");

				out.println("<html>");
				out.println("<head>");
				out.println("<style>");
				out.println("#my_table{");
				out.println("margin: 0 auto;");
				out.println("}");
				out.println("</style>");
				out.println("</head>");
				out.println("<body>");
				out.println("<table border='1' width='500' id ='my_table'>");
				out.println("<tr>");
				out.println("<td width='500' align='center'>관리자 계정 "+id+" 입니다.</td>");
				out.println("</tr>");
				out.println("<tr>");
				out.println("<td width='500' align='center'>" + pass + " 패스워드입니다.</td>");
				out.println("</tr>");
				out.println("<tr>");
				out.println("<td width='500' align='center'>" + name + " 이름입니다.</td>");
				out.println("</tr>");
				out.println("<tr>");
				out.println("<td align='center'>");
				out.println(
						"<input type='button' onclick = \"location.href = '/jspStudy/loginMemberList.do' \" value='회원들 정보'>");
				out.println(
						"<input type='button' onclick = \"location.href = '/jspStudy/logoutServlet.do' \" value='로그아웃'>");
				out.println("</td>");
				out.println("</tr>");
				out.println("</table>");
				out.println("</body>");
				out.println("</html>");
			} else if (session != null) {
				System.out.println("세션고유아이디 " + session.getId());
				// 사용자 정보 id,pass
				String id = (String) session.getAttribute("id");
				String pass = (String) session.getAttribute("pass");
				String name = (String) session.getAttribute("name");

				out.println("<html>");
				out.println("<head>");
				out.println("<style>");
				out.println("#my_table{");
				out.println("margin: 0 auto;");
				out.println("}");
				out.println("</style>");
				out.println("</head>");
				out.println("<body>");
				out.println("<table border='1' width='500' id ='my_table'>");
				out.println("<tr>");
				out.println("<td width='500' align='center'>" + id + " 님 로그인 되었습니다.</td>");
				out.println("</tr>");
				out.println("<tr>");
				out.println("<td width='500' align='center'>" + pass + " 패스워드입니다.</td>");
				out.println("</tr>");
				out.println("<tr>");
				out.println("<td width='500' align='center'>" + name + " 이름입니다.</td>");
				out.println("</tr>");
				out.println("<tr>");
				out.println("<td align='center'>");
				out.println(
						"<input type='button' onclick = \"location.href = '/jspStudy/loginMemberChange.do' \" value='회원정보변경'>");
				out.println(
						"<input type='button' onclick = \"location.href = '/jspStudy/logoutServlet.do' \" value='로그아웃'>");
				out.println(
						"<input type='button' onclick = \"location.href = '/jspStudy/memberReallyDelete.do' \" value='탈퇴하기'>");
				out.println("</td>");
				out.println("</tr>");
				out.println("</table>");
				out.println("</body>");
				out.println("</html>");
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if (out != null) {
				out.close();
			}
		}

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
