package co.kh.dev.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.kh.dev.common.DBUtility;
import co.kh.dev.login.model.LoginDAO;
import co.kh.dev.login.model.LoginVO;

@WebServlet("/loginMemberChangeDB.do")
public class LoginMemberChangeDB extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;Charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		// 1.1 전송된값을 utf-8셋팅하기
		request.setCharacterEncoding("UTF-8");
		// 1.1 정보가져오기
		String pass = request.getParameter("pass");
		String pass1 = request.getParameter("pass1");
		System.out.println(pass);
		System.out.println(pass1);
		HttpSession session = request.getSession(false);
		System.out.println("세션고유아이디 " + session.getId());
		// 사용자 정보 id,pass
		String id = (String) session.getAttribute("id");
		// 2. table에 저장한다(프로토콜: 약속)
		// 오라클에서 작업할 쿼리문 사용할게 하는 명령문
		boolean successFlag = false;

		if (pass.equals(pass1)) {
			LoginDAO ld = new LoginDAO();
			LoginVO lvo = new LoginVO(id, pass);
			successFlag = ld.changeLogin(lvo);
		}

		// 3.화면출력
		if (successFlag == true) {
			session.setAttribute("pass", pass);
			System.out.println("비번변경성공");
			out.println("<html>");
			out.println("<head>");
			out.println("<script>");
			out.println("window.onload = function() {");
			out.println("    alert('비밀번호를 잘 변경했습니다');");
			out.println("    window.location.href = '/jspStudy/loginServlet.do';"); // 리다이렉트
			out.println("};");
			out.println("</script>");
			out.println("</head>");
			out.println("<body>");
			out.println("</body>");
			out.println("</html>");
		} else {
			System.out.println("비번변경실패");
			out.println("<html>");
			out.println("<head>");
			out.println("<script>");
			out.println("window.onload = function() {");
			out.println("    alert('비밀번호가 서로 불일치해서 변경실패했습니다.');");
			out.println("    window.location.href = '/jspStudy/loginServlet.do';"); // 리다이렉트
			out.println("};");
			out.println("</script>");
			out.println("</head>");
			out.println("<body>");
			out.println("</body>");
			out.println("</html>");
		}
		out.close();
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
