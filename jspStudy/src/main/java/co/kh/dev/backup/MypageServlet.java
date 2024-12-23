package co.kh.dev.backup;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//@WebServlet({ "/myPageServlet.do" })
public class MypageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response) {
    	PrintWriter out = null;
    	response.setContentType("text/html; charSet=UTF-8");
		try {
			out = response.getWriter();
			HttpSession session = request.getSession();
			String name = (String) session.getAttribute("name");
			String id = (String) session.getAttribute("id");
			String pwd = (String) session.getAttribute("pwd");
			out.println("<h1 align=\"center\">마이페이지</h1>");
			out.println("<table align=\"center\" width=\"300\" border=\"1\">");
			out.println("<tr>");
			out.println("<td align=\"center\">");
			out.println("이름 = "+ name);
			out.println("</td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<tr>");
			out.println("<td align=\"center\">");
			out.println("id = "+ id);
			out.println("</td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td align=\"center\">");
			out.println("비밀번호 = "+ pwd);
			out.println("</td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td align=\"center\">");
			out.println("<a href='/jspStudy/member/memberUpdate.html'><input type=\"button\" value=\"회원정보 수정\"></a>");
			out.println("<a href='/jspStudy/loginServlet.do'><input type=\"button\" value=\"뒤로가기\"></a>");
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");	
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
   
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) {
		processRequest(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		processRequest(request, response);
	}

}
