package co.kh.dev.login.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import co.kh.dev.common.DBUtility;

public class LoginDAO {
	private final String LOGIN_SELECT = "SELECT * FROM Login";
	private final String LOGIN_UPDATE = "update login set pass = ? where id = ?";
	private final String LOGIN_INSERT = "insert into login values(?,?,?)";
	private final String LOGIN_DELETE = "delete from login where id = ?";

	// 로그인 체크
	public LoginVO selectLogin(LoginVO lvo) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement pstmt = null; // 오라클에서 작업할 쿼리문 사용할게 하는 명령문
		boolean successFlag = false;
		String name = null;
		con = DBUtility.dbCon();
		try {
			pstmt = con.prepareStatement(LOGIN_SELECT);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String idCheck = rs.getString("ID");
				String passCheck = rs.getString("PASS");
				name = rs.getString("NAME");
				if (lvo.getId().equals(idCheck) && lvo.getPass().equals(passCheck)) {
					successFlag = true;
					break;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtility.dbClose(con, pstmt, rs);
		}
		lvo.setName(name);
		lvo.setSuccessFlag(successFlag);
		return lvo;
	}

	// 비밀번호 변경
	public boolean changeLogin(LoginVO lvo) {
		Connection con = null;
		PreparedStatement pstmt = null; 
		con = DBUtility.dbCon();
		boolean successFlag = false;
		try {
			pstmt = con.prepareStatement(LOGIN_UPDATE);
			pstmt.setString(1, lvo.getPass());
			pstmt.setString(2, lvo.getId());
			int count = pstmt.executeUpdate();
			successFlag = (count != 0) ? (true) : (false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		DBUtility.dbClose(con, pstmt);
		return successFlag;
	}

	// 회원가입
	public boolean newLogin(LoginVO lvo) {
		boolean successFlag = false;
		Connection con = null;
		PreparedStatement pstmt = null; // 오라클에서 작업할 쿼리문 사용할게 하는 명령문
		con = DBUtility.dbCon();
		try {
			pstmt = con.prepareStatement(LOGIN_INSERT);
			pstmt.setString(1, lvo.getId());
			pstmt.setString(2, lvo.getPass());
			pstmt.setString(3, lvo.getName());
			int count = pstmt.executeUpdate();
			successFlag = (count != 0) ? (true) : (false);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBUtility.dbClose(con, pstmt);
		}
		
		return successFlag;
	}

	// 회원정보 출력
	public ArrayList<LoginVO> listLogin() {
		ArrayList<LoginVO> list = new ArrayList<LoginVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		con = DBUtility.dbCon();
		try {
			pstmt = con.prepareStatement(LOGIN_SELECT);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String id = rs.getString("ID");
				String pass = rs.getString("PASS");
				String name = rs.getString("NAME");
				LoginVO lvo = new LoginVO(id,pass,name);
				list.add(lvo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		DBUtility.dbClose(con, pstmt, rs);
		return list;
	}

	// 회원탈퇴
	public boolean deleteLogin(LoginVO lvo) {
		Connection con = null;
		PreparedStatement pstmt = null; // 오라클에서 작업할 쿼리문 사용할게 하는 명령문
		boolean successFlag = false;
		con = DBUtility.dbCon();
		try {
			pstmt = con.prepareStatement(LOGIN_DELETE);
			pstmt.setString(1, lvo.getId());
			int count = pstmt.executeUpdate();
			successFlag = (count != 0) ? (true) : (false);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtility.dbClose(con, pstmt);
		}
		return successFlag;
	}
}
