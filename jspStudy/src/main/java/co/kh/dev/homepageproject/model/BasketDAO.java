package co.kh.dev.homepageproject.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import co.kh.dev.common.ConnectionPool;

public class BasketDAO {
	// 싱글톤방식
	// 1. 객체
	private static BasketDAO instance;

	// 2. 생성자
	private BasketDAO() {
	};

	// 3.
	public static BasketDAO getInstance() {
		if (instance == null) {
			synchronized (BasketDAO.class) {
				instance = new BasketDAO();
			}
		}
		return instance;
	}

	private final String SELECT_ID_SQL = "SELECT * FROM "
	        + "(SELECT ROWNUM AS rnum, num, id, p_num, name, regdate, price, amount, imgUrl "
	        + " FROM (SELECT * FROM SHOPBasket ORDER BY num DESC)) "
	        + "WHERE id = ?";
	private final String SELECT_COUNT_SQL = "select count(*) as count from SHOPBasket where id = ?";
	private final String DELETE_SQL = "DELETE FROM ShopBasket WHERE NUM = ?";
	private final String DELETE_ID_SQL = "DELETE FROM ShopBasket WHERE ID = ?";
	private final String INSERT_SQL = "INSERT INTO shopbasket (num, ID, p_num, name, regdate, price, imgUrl, amount) VALUES (shopbasket_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?)";
	
	
	
	public Boolean insertDB(BasketVO bvo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;

		// 상품 등록하기
		try {
			pstmt = con.prepareStatement(INSERT_SQL);
			 pstmt.setString(1, bvo.getId());        // ID
	            pstmt.setInt(2, bvo.getpNum());         // p_num
	            pstmt.setString(3, bvo.getName());      // name
	            pstmt.setTimestamp(4, bvo.getRegDate()); // regdate
	            pstmt.setInt(5, bvo.getPrice());        // price
	            pstmt.setString(6, bvo.getImgUrl());    // imgUrl
	            pstmt.setInt(7, bvo.getAmount());       // amount
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		return (count > 0) ? true : false;
	}


	public int selectCountDB(String id) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			pstmt = con.prepareStatement(SELECT_COUNT_SQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return count;
	}
	public ArrayList<BasketVO> selectIdDB(String id) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BasketVO> BasketList = new ArrayList<BasketVO>();
		try {
				pstmt = con.prepareStatement(SELECT_ID_SQL);
				pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int num = rs.getInt("num");          // 제품 번호
				String iId = rs.getString("id");      // 사용자 ID
				int pNum = rs.getInt("p_num");       // 제품 번호 (p_num)
				String name = rs.getString("name");  // 제품 이름
				Timestamp regdate = rs.getTimestamp("regdate");  // 등록일시
				int price = rs.getInt("price");      // 가격
				int amount = rs.getInt("amount");    // 재고 수량
				String imgUrl = rs.getString("imgUrl");  // 이미지 URL
				BasketVO vo = new BasketVO(num, iId, pNum, name, regdate, price, imgUrl, amount);
				BasketList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return BasketList;
	}
	
	public boolean deleteDB(int numInt) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count=0;
		
		try {
			pstmt = con.prepareStatement(DELETE_SQL);
			pstmt.setInt(1, numInt);	
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return (count!=0)?(true):(false);
	}
	public boolean deleteIdDB(String id) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count=0;
		
		try {
			pstmt = con.prepareStatement(DELETE_ID_SQL);
			pstmt.setString(1, id);	
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return (count!=0)?(true):(false);
	}

}
