package co.kh.dev.backup;

import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//@WebServlet("/loginServlet.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
	    PrintWriter out = null;
	    response.setContentType("text/html;charset=UTF-8");
	    try {
	        out = response.getWriter();
	        // 1. 세션 정보를 가져오기 (세션이 없으면 null 반환)
	        HttpSession session = request.getSession(false);

	        if (session == null) {
	            // 세션이 없을 때 로그인 화면 출력
	            out.println("<html>");
	            out.println("<body>");
	            out.println("<form method='post' action='/jspStudy/loginCheckServlet.do'>");
	            out.println("<table border='1' width='300' align=\"center\">");
	            out.println("<tr>");
	            out.println("<th width='100'>아이디</th>");
	            out.println("<td width='200'>&nbsp;<input type='text' name='id'></td>");
	            out.println("</tr>");
	            out.println("<tr>");
	            out.println("<th width='100'>비번</th>");
	            out.println("<td width='200'>&nbsp;<input type='password' name='pwd'></td>");
	            out.println("</tr>");
	            out.println("<tr>");
	            out.println("<td align='center' colspan='2'>");
	            out.println("<a href='/jspStudy/member/member.html'><input type='button' value='회원가입'></a> &nbsp; &nbsp;");
	            out.println("<input type='submit' value='로그인'>");
	            out.println("</td>");
	            out.println("</tr>");
	            out.println("</form>");
	            out.println("</table>");
	            out.println("</body>");
	            out.println("</html>");
	        } else {
	            // 세션이 있을 때
	            String id = (String) session.getAttribute("id");
	                out.println("<html>");
	                out.println("<body>");
	                out.println("<table border='1' width='300' align=\"center\">");
	                out.println("<tr>");
	                out.println("<td width='300' align='center'>" + id + " 님 로그인 되었습니다.</td>");
	                out.println("</tr>");
	                out.println("<tr>");
	                out.println("<td align='center'>");
	                out.println("<a href='myPageServlet.do'>회원정보</a> &nbsp;&nbsp;");
	                out.println("<a href='logoutServlet.do'>로그아웃</a>");
	                out.println("</td>");
	                out.println("</tr>");
	                out.println("</table>");
	                out.println("</body>");
	                out.println("</html>");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (out != null) {
	            out.close();
	        }
	    }
	}



	protected void doGet(HttpServletRequest request, HttpServletResponse response) {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		processRequest(request, response);
	}

}
