package co.kh.dev.memberone.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import co.kh.dev.common.ConnectionPool;

public class ZipCodeDAO {
	private final String SELECT_SQL = "SELECT * FROM STUDENT";
	private final String SELECT_BY_ID_SQL = "SELECT count(*) as count FROM STUDENT WHERE ID = ?";
	private final String SELECT_LOGIN_CHECK_SQL = "SELECT * FROM STUDENT WHERE ID = ? AND PWD = ?";
	private final String INSERT_SQL = "INSERT INTO STUDENT VALUES(?,?,?,?,?)";
	private final String DELETE_SQL = "DELETE FROM STUDENT WHERE ID = ?";
	private final String UPDATE_SQL = "UPDATE STUDENT SET PWD = ?, EMAIL = ?, NAME = ?, BIRTH = ? WHERE ID = ?";
	private final String SELECT_ZIP_SQL = "select * from zipcode where dong like '?%'";

// 전체를 DB에서 출력
	public ArrayList<StudentVO> selectDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<StudentVO> tmList = new ArrayList<StudentVO>();
		try {
			pstmt = con.prepareStatement(SELECT_SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String id = rs.getString("ID");
				String passwd = rs.getString("passwd");
				String name = rs.getString("name");
				String memNum1 = rs.getString("mem_Num1");
				String memNum2 = rs.getString("mem_Num2");
				String eMail = rs.getString("E_MAIL");
				String phone = rs.getString("phone");
				String zipcode = rs.getString("zipcode");
				String address = rs.getString("address");
				String job = rs.getString("job");
				/*
				 * StudentVO tmvo = new StudentVO(id, passwd, name, memNum1, memNum2, eMail,
				 * phone, zipcode, address, job); tmList.add(tmvo);
				 */
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return tmList;
	}

	public void selectZipCode(ZipCodeVO zvo) {
//		ConnectionPool cp = ConnectionPool.getInstance();
//		Connection con = cp.dbCon();
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		int count = 0;
//		try {
//			pstmt = con.prepareStatement(SELECT_BY_ID_SQL);
//			pstmt.setString(1, zvo.getCode());
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				count = rs.getInt("count");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			cp.dbClose(con, pstmt, rs);
//		}
//		return (count != 0) ? true : false;
	}
	
//	public ArrayList<ZipcodeVO> selectZipCode(ZipcodeVO zvo) {
//		return null; 
//		
//	}

}