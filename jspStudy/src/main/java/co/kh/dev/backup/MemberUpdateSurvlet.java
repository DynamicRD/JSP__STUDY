package co.kh.dev.backup;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.kh.dev.common.DBUtility;


//@WebServlet({ "/memberUpdateSurvlet.do" })
public class MemberUpdateSurvlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private void processRequest(HttpServletRequest request, HttpServletResponse response) {
	try {
		final String UPDATE_SQL = "UPDATE MEMBER SET NAME=?, ID=?, PWD=? WHERE ID=?";
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Connection con = DBUtility.dbCon();
		PreparedStatement pstmt = null;
		String nname = request.getParameter("name");
		String nid = request.getParameter("id");
		String npwd = request.getParameter("pwd");
		String sid =  (String) session.getAttribute("id");
		pstmt = con.prepareStatement(UPDATE_SQL);
		pstmt.setString(1, nname);
		pstmt.setString(2, nid);
		pstmt.setString(3, npwd);
		pstmt.setString(4, sid);
		pstmt.executeUpdate();
		session.setAttribute("id", nid);
		session.setAttribute("pwd", npwd);
		DBUtility.dbClose(con, pstmt);
		response.sendRedirect("myPageServlet.do");
	} catch (UnsupportedEncodingException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
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
