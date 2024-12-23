package co.kh.dev.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

@WebServlet("/loginCheck.do")
public class LoginCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html;Charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();

			// 1. 사용자정보를 읽는다
			request.setCharacterEncoding("UTF-8");
			String id = request.getParameter("id");
			String pass = request.getParameter("pass");
			// 2. 데이터베이스에서 확인한다. CURD
			LoginDAO ld = new LoginDAO();
			LoginVO lvo = new LoginVO(id, pass);
			LoginVO rlvo = ld.selectLogin(lvo);
			boolean successFlag = false;
			successFlag = rlvo.isSuccessFlag();
			// 3. 체크확인 로그인이 인정이 되면 세션을 만들어서 저장한다.

			if (successFlag == true) {
				// 세션이 있으면 가져오고, 없으면 세션을 생성한다.
				HttpSession session = request.getSession();
				session.setAttribute("id", id);
				session.setAttribute("pass", pass);
				session.setAttribute("name", rlvo.getName());
				response.sendRedirect("/jspStudy/loginServlet.do");
			} else {

				out.println("<html>");
				out.println("<head>");
				out.println("<script>");
				out.println("window.onload = function() {");
				out.println("    alert('로그인 실패했습니다.');");
				out.println("    window.location.href = '/jspStudy/loginServlet.do';"); // 리다이렉트
				out.println("};");
				out.println("</script>");
				out.println("</head>");
				out.println("<body>");
				out.println("</body>");
				out.println("</html>");
			}
			out.close();

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
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
