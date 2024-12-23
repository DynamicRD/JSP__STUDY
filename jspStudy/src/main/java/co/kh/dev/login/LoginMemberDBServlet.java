package co.kh.dev.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.kh.dev.common.DBUtility;
import co.kh.dev.login.model.LoginDAO;
import co.kh.dev.login.model.LoginVO;

@WebServlet("/loginMemberDBServlet.do")
public class LoginMemberDBServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;Charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
		
		// 1.1 전송된값을 utf-8셋팅하기
		request.setCharacterEncoding("UTF-8");
		// 1.1 정보가져오기
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String name = request.getParameter("name");
		boolean successFlag = false;
		LoginDAO ldao = new LoginDAO();
		LoginVO lvo = new LoginVO(id,pass,name);
		successFlag = ldao.newLogin(lvo);
		// 3.화면출력
		if (successFlag == true) {
			System.out.println("가입성공");
			   out.println("<html>");
	            out.println("<head>");
	            out.println("<script>");
	            out.println("window.onload = function() {");
	            out.println("    alert('가입 성공했습니다.');");
	            out.println("    window.location.href = '/jspStudy/loginServlet.do';");  // 리다이렉트
	            out.println("};");
	            out.println("</script>");
	            out.println("</head>");
	            out.println("<body>");
	            out.println("</body>");
	            out.println("</html>");
	            out.close();
		} else {
			System.out.println("가입실패");
			   out.println("<html>");
	            out.println("<head>");
	            out.println("<script>");
	            out.println("window.onload = function() {");
	            out.println("    alert('가입 실패했습니다.');");
	            out.println("    window.location.href = '/jspStudy/loginServlet.do';");  // 리다이렉트
	            out.println("};");
	            out.println("</script>");
	            out.println("</head>");
	            out.println("<body>");
	            out.println("</body>");
	            out.println("</html>");
	            out.close();
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
