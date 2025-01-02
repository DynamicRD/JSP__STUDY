package co.kh.dev.homepageproject.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import co.kh.dev.common.ConnectionPool;

public class ProductsDAO {
	// 싱글톤방식
	// 1. 객체
	private static ProductsDAO instance;

	// 2. 생성자
	private ProductsDAO() {
	};

	// 3.
	public static ProductsDAO getInstance() {
		if (instance == null) {
			synchronized (ProductsDAO.class) {
				instance = new ProductsDAO();
			}
		}
		return instance;
	}

	private final String SELECT_START_END_SQL = " select * from "
		    + "(select rownum AS rnum, num, name, regdate, price, amount, tag, imgUrl, content "
		    + " from (select * from Products order by num desc)) "
		    + "where rnum >= ? and rnum <= ?";
	private final String SELECT_START_END_SUBJECT_SQL = " select * from "
		    + "(select rownum AS rnum, num, name, regdate, price, amount, tag, imgUrl, content "
		    + " from (select * from Products order by num desc)) "
		    + "where rnum >= ? and rnum <= ? and name like ?";
	private final String SELECT_START_END_TAG_SQL = " select * from "
		    + "(select rownum AS rnum, num, name, regdate, price, amount, tag, imgUrl, content "
		    + " from (select * from Products order by num desc)) "
		    + "where rnum >= ? and rnum <= ? and tag like ?";
	private final String SELECT_COUNT_SQL = "select count(*) as count from Products";
	private final String SELECT_COUNT_NAME_SQL = "SELECT COUNT(*) AS count FROM Products WHERE NAME LIKE ?";
	private final String SELECT_COUNT_TAG_SQL = "SELECT COUNT(*) AS count FROM Products WHERE TAG LIKE ?";
	private final String SELECT_ONE_SQL = "select * from Products where num = ?";
	private final String DELETE_SQL = "DELETE FROM Products WHERE NUM = ?";
	private final String UPDATE_PURCHASE_SQL = "update Products set amount = amount - ? where num=?";
	private final String UPDATE_RECALL_SQL = "update Products set amount = amount + ? where num=?";
	private final String INSERT_SQL = "INSERT INTO products (num,name, price, amount, tag, content, imgUrl, REGDATE) VALUES (commentmember_SEQ.nextval,?, ?, ?, ?, ?, ?, ?)";
	private final String UPDATE_SQL = "UPDATE products SET name = ?, price = ?, amount = ?, tag = ?, content = ?, imgUrl = ?, REGDATE = ? WHERE num = ?";
	
	
	
	public Boolean insertDB(ProductsVO pvo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;

		// 상품 등록하기
		try {
			pstmt = con.prepareStatement(INSERT_SQL);
			pstmt.setString(1, pvo.getName());              // 제품 이름 설정
			pstmt.setInt(2, pvo.getPrice());                // 제품 가격 설정
			pstmt.setInt(3, pvo.getAmount());               // 제품 수량 설정
			pstmt.setString(4, pvo.getTag());               // 제품 태그 설정
			pstmt.setString(5, pvo.getContent());           // 제품 설명 설정
			pstmt.setString(6, pvo.getImgUrl());            // 제품 이미지 URL 설정
			pstmt.setTimestamp(7, pvo.getRegdate());        // 제품 등록일 설정
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		return (count > 0) ? true : false;
	}
	
	public Boolean updateDB(ProductsVO pvo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;

		// 상품 등록하기
		try {
			pstmt = con.prepareStatement(UPDATE_SQL);
			pstmt.setString(1, pvo.getName());              // 제품 이름 설정
			pstmt.setInt(2, pvo.getPrice());                // 제품 가격 설정
			pstmt.setInt(3, pvo.getAmount());               // 제품 수량 설정
			pstmt.setString(4, pvo.getTag());               // 제품 태그 설정
			pstmt.setString(5, pvo.getContent());           // 제품 설명 설정
			pstmt.setString(6, pvo.getImgUrl());            // 제품 이미지 URL 설정
			pstmt.setTimestamp(7, pvo.getRegdate());        // 제품 등록일 설정
			pstmt.setInt(8, pvo.getNum());  
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		return (count > 0) ? true : false;
	}

	public int selectCountDB(ProductsVO bvo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			switch (bvo.getSearchCheck()) {
			case "none":
				pstmt = con.prepareStatement(SELECT_COUNT_SQL);
				break;
			case "subject":
				pstmt = con.prepareStatement(SELECT_COUNT_NAME_SQL);
				pstmt.setString(1, "%"+bvo.getName()+"%");
				break;
			case "tag":
				pstmt = con.prepareStatement(SELECT_COUNT_TAG_SQL);
				pstmt.setString(1, "%"+bvo.getTag()+"%");
				break;
			default:
				pstmt = con.prepareStatement(SELECT_COUNT_SQL);
				break;
			}
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
	public ProductsVO selectProductsDB(ProductsVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductsVO bvo = null;
		try {
			// 글 전체내용 조회
			pstmt = con.prepareStatement(SELECT_ONE_SQL);
			pstmt.setInt(1, vo.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int num = rs.getInt("num");               // 제품 번호
				String name = rs.getString("name");        // 제품 이름
				Timestamp regdate = rs.getTimestamp("regdate");  // 등록일시
				int price = rs.getInt("price");            // 가격
				int amount = rs.getInt("amount");          // 재고 수량
				String tag = rs.getString("tag");          // 태그
				String imgUrl = rs.getString("imgUrl");    // 이미지 URL
				String content = rs.getString("content");  // 내용
				bvo = new ProductsVO(num, name, regdate, content, price, amount, tag, imgUrl);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return bvo;
	}

	
	public ArrayList<ProductsVO> selectStartEndDB(int start, int end,ProductsVO bvo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProductsVO> ProductsList = new ArrayList<ProductsVO>(end-start+1);	//arrayList갯수정해줌
		try {
			switch (bvo.getSearchCheck()) {
			case "none":
				pstmt = con.prepareStatement(SELECT_START_END_SQL);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				break;		
			case "subject":
				pstmt = con.prepareStatement(SELECT_START_END_SUBJECT_SQL);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				pstmt.setString(3, "%"+bvo.getName()+"%");
				break;
			case "tag":
				pstmt = con.prepareStatement(SELECT_START_END_TAG_SQL);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				pstmt.setString(3, "%"+bvo.getTag()+"%");
				break;
			default:
				pstmt = con.prepareStatement(SELECT_START_END_SQL);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				break;
			}
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int num = rs.getInt("num");               // 제품 번호
				String name = rs.getString("name");        // 제품 이름
				Timestamp regdate = rs.getTimestamp("regdate");  // 등록일시
				int price = rs.getInt("price");            // 가격
				int amount = rs.getInt("amount");          // 재고 수량
				String tag = rs.getString("tag");          // 태그
				String imgUrl = rs.getString("imgUrl");    // 이미지 URL
				String content = rs.getString("content");  // 내용
				ProductsVO vo = new ProductsVO(num, name, regdate, content, price, amount, tag, imgUrl);
				ProductsList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return ProductsList;
	}
	
	public boolean updatePurchaseDB(int purchase,int num) {
		// 1: 성공, 2. 패스워드문제, 3 수정문제
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;
			try {
				pstmt = con.prepareStatement(UPDATE_PURCHASE_SQL);
				pstmt.setInt(1, purchase);
				pstmt.setInt(2, num);
				count = pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				cp.dbClose(con, pstmt);
			}
	
		return (count > 0) ? true : false;
	}
	
	public boolean updateRecallDB(ProductsVO pvo) {
		// 1: 성공, 2. 패스워드문제, 3 수정문제
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			pstmt = con.prepareStatement(UPDATE_RECALL_SQL);
			pstmt.setInt(1, pvo.getAmount());
			pstmt.setInt(2, pvo.getNum());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		
		return (count > 0) ? true : false;
	}
	

	public boolean deleteDB(int num) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count=0;
		
		// 패스워드가 맞는지 점검필요
		try {
			pstmt = con.prepareStatement(DELETE_SQL);
			pstmt.setInt(1, num);	
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return (count!=0)?(true):(false);
	}

}
