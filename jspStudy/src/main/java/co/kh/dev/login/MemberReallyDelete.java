package co.kh.dev.login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/memberReallyDelete.do")
public class MemberReallyDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;Charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head>");
		out.println("<script>");
		out.println("window.onload = function() {");
		out.println("let flag = window.confirm(\"정말 탈퇴하시겠습니까?\");");
		out.println("console.log('flag',flag);");
		out.println("if(flag === true){");
			out.println("let flag1 = window.confirm(\"참말루 진짜루 레알루 탈퇴하시겠습니까?\");");
			out.println("console.log('flag',flag1);");
			out.println("if(flag1 === true){");
			out.println("    window.location.href = '/jspStudy/memberDelete.do';"); // 리다이렉트
			out.println("}else{");
			out.println("    window.location.href = '/jspStudy/loginServlet.do';"); // 리다이렉트
			out.println("}");
		out.println("}else{");
		out.println("    window.location.href = '/jspStudy/loginServlet.do';"); // 리다이렉트
		out.println("}");
		out.println("};");
		out.println("</script>");
		out.println("</head>");
		out.println("<body>");
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
