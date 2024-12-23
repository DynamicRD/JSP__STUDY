package co.kh.dev.backup;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.kh.dev.common.DBUtility;


//@WebServlet("/loginCheckServlet.do")
public class LoginCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginCheckServlet() {
		super();
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		final String SELECT_SQL = "SELECT * FROM MEMBER";
		Connection con = DBUtility.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(SELECT_SQL);
			rs = pstmt.executeQuery();
			request.setCharacterEncoding("UTF-8");
			// 1. 사용자정보를 얻는다
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			// 2. 데이터베이스에서 확인한다. 확인이 완료됐으면 세션을 만들어준다.
			while (rs.next()) {
				String dId = rs.getString("ID");
				String dPwd = rs.getString("PWD");
				String name = rs. getString("NAME");
						
				if (id.equals(dId) && pwd.equals(dPwd)) {
					HttpSession session = request.getSession();
					session.setAttribute("id", id);
					session.setAttribute("pwd", pwd);
					session.setAttribute("name", name);
				}
			
			}//while
			response.sendRedirect("loginServlet.do");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		processRequest(request, response);
	}

}
