package co.kh.dev.homepageproject.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import co.kh.dev.boardone.model.BoardDAO;
import co.kh.dev.common.ConnectionPool;
import co.kh.dev.common.DBUtility;
import co.kh.dev.login.model.LoginVO;

import co.kh.dev.memberone.model.ZipCodeVO;

public class MemberDAO {
	// 싱글톤1
		private static MemberDAO instance;

		// 싱글톤2
		private MemberDAO() {
		}

		// 싱글톤3
		public static MemberDAO getInstance() {
			if (instance == null) {
				synchronized (MemberDAO.class) {
					instance = new MemberDAO();
				}
			}
			return instance;
		}
		
	private final String SELECT_SQL = "SELECT * FROM Member";
	private final String SELECT_ONE_SQL = "SELECT * FROM Member WHERE ID = ?";
	private final String SELECT_BY_ID_SQL = "SELECT count(*) as count FROM Member WHERE ID = ?";
	private final String INSERT_SQL = "insert into Member values(?,?,?,?,?,?,?,?)";
	private final String SELECT_ZIP_SQL = "select * from zipcode where dong like ?";
	private final String MEMBER_UPDATE_SQL = "UPDATE member SET pass = ?, name = ?, phone = ?, email = ?, zipcode = ?, address1 = ?, address2 = ? WHERE id = ?";
	private final String FIND_MEMBER_ID = "SELECT * FROM Member WHERE NAME = ? AND EMAIL = ? AND PHONE = ?";
	private final String FIND_MEMBER_PASS = "SELECT * FROM Member WHERE ID = ? AND EMAIL = ? AND PHONE = ?";
	
	// 전체를 DB에서 출력


	public boolean selectIdCheck(MemberVO mvo) {
		ConnectionPool cp = ConnectionPool.getInstance(); 
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			pstmt = con.prepareStatement(SELECT_BY_ID_SQL);
			pstmt.setString(1, mvo.getId());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return (count != 0 ) ? true : false;
	}
	
	public String findMemberID(MemberVO mvo) {
		ConnectionPool cp = ConnectionPool.getInstance(); 
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String id = null;
		try {
			pstmt = con.prepareStatement(FIND_MEMBER_ID);
			pstmt.setString(1, mvo.getName());
			pstmt.setString(2, mvo.getEmail());
			pstmt.setString(3, mvo.getPhone());
			rs = pstmt.executeQuery();
			if (rs.next()) {
			id = rs.getString("id");
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return (id != null ) ? id : "none";
	}
	
	public String findMemberPASS(MemberVO mvo) {
		ConnectionPool cp = ConnectionPool.getInstance(); 
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String pass = null;
		try {
			pstmt = con.prepareStatement(FIND_MEMBER_PASS);
			pstmt.setString(1, mvo.getId());
			pstmt.setString(2, mvo.getEmail());
			pstmt.setString(3, mvo.getPhone());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pass = rs.getString("pass");
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return (pass != null ) ? pass : "none";
	}

	public ArrayList<ZipCodeVO> selectZipCode(ZipCodeVO zvo) {
		ConnectionPool cp = ConnectionPool.getInstance(); 
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ZipCodeVO> zipList = new ArrayList<ZipCodeVO>();
		try {
			pstmt = con.prepareStatement(SELECT_ZIP_SQL);
			pstmt.setString(1, zvo.getDong() + "%");
			rs = pstmt.executeQuery();
			while(rs.next()){
				String zipcode = rs.getString("zipcode");
				String sido= rs.getString("sido");
				String gugun= rs.getString("gugun");
				String dong= rs.getString("dong");
				String bunji= rs.getString("bunji");
				ZipCodeVO obj = new ZipCodeVO(zipcode, sido, gugun, dong, bunji);
				zipList.add(obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return zipList;
	}

	public Boolean insertDB(MemberVO mvo) {
		ConnectionPool cp = ConnectionPool.getInstance(); 
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			pstmt= con.prepareStatement(INSERT_SQL);
			pstmt.setString(1,mvo.getId());
			 pstmt.setString(2,mvo.getPass());
			 pstmt.setString(3,mvo.getName());
			 pstmt.setString(4,mvo.getPhone());
			 pstmt.setString(5,mvo.getEmail());
			 pstmt.setString(6,mvo.getZipcode());
			 pstmt.setString(7,mvo.getAddress1());
			 pstmt.setString(8,mvo.getAddress2());
			 count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		return (count>0)?true:false;
	}
	
	//회원정보 변경
	public Boolean memberChange(MemberVO mvo) {
		ConnectionPool cp = ConnectionPool.getInstance(); 
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			pstmt= con.prepareStatement(MEMBER_UPDATE_SQL);
			//System.out.println(mvo.toString());
			pstmt.setString(1,mvo.getPass());
			pstmt.setString(2,mvo.getName());
			pstmt.setString(3,mvo.getPhone());
			pstmt.setString(4,mvo.getEmail());
			pstmt.setString(5,mvo.getZipcode());
			pstmt.setString(6,mvo.getAddress1());
			pstmt.setString(7,mvo.getAddress2());
			pstmt.setString(8,mvo.getId());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		return (count>0)?true:false;
	}

	public MemberVO selectLogin(MemberVO mvo) {
		ConnectionPool cp = ConnectionPool.getInstance(); 
		Connection con = cp.dbCon();
		ResultSet rs = null;
		PreparedStatement pstmt = null; // 오라클에서 작업할 쿼리문 사용할게 하는 명령문
		boolean successFlag = false;
		String name = null;
		String email = null;
		con = DBUtility.dbCon();
		try {
			pstmt = con.prepareStatement(SELECT_SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String idCheck = rs.getString("ID");
				String passCheck = rs.getString("PASS");
				name = rs.getString("NAME");
				email = rs.getString("email");
				if (mvo.getId().equals(idCheck) && mvo.getPass().equals(passCheck)) {
					successFlag = true;
					break;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		mvo.setName(name);
		mvo.setEmail(email);
		mvo.setSuccessFlag(successFlag);
		return mvo;
	}
	
	public MemberVO selectOneDB(MemberVO svo) {
		ConnectionPool cp = ConnectionPool.getInstance(); 
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO resultVO =null;
		try {
			pstmt = con.prepareStatement(SELECT_ONE_SQL);
			pstmt.setString(1, svo.getId());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String id 		= rs.getString("ID");
				String pass 	= rs.getString("pass");
				String name 	= rs.getString("name");
				String phone 	= rs.getString("phone");
				String eMail 	= rs.getString("email");
				String zipcode 	= rs.getString("zipcode");
				String address1 = rs.getString("address1");
				String address2	= rs.getString("address2");
				resultVO = new MemberVO(id, pass, name, phone, eMail, zipcode, address1, address2);
		} 
			}catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return resultVO;
	}
}