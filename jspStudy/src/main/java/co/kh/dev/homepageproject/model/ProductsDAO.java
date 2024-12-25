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

	private final String SELECT_SQL = "select * from Products order by num desc";
	private final String SELECT_START_END_SQL = " select * from "
		    + "(select rownum AS rnum, num, name, regdate, price, amount, tag, imgUrl, content "
		    + " from (select * from Products order by num desc)) "
		    + "where rnum >= ? and rnum <= ?";
	private final String SELECT_START_END_SUBJECT_SQL = " select * from "
			+ "(select rownum AS rnum, num, writer, subject, pass, regdate, readcount, ref, step, depth,comments, content, ip "
			+ "from (select * from Products order by ref desc, step asc)) where rnum>=? and rnum<=? and subject LIKE ?";
	private final String SELECT_START_END_WRITER_SQL = " select * from "
			+ "(select rownum AS rnum, num, writer, subject, pass, regdate, readcount, ref, step, depth,comments, content, ip "
			+ "from (select * from Products order by ref desc, step asc)) where rnum>=? and rnum<=? and writer LIKE ?";
	private final String SELECT_START_END_CONTENT_SQL = " select * from "
			+ "(select rownum AS rnum, num, writer, subject, pass, regdate, readcount, ref, step, depth,comments, content, ip "
			+ "from (select * from Products order by ref desc, step asc)) where rnum>=? and rnum<=? and content LIKE ?";
	private final String SELECT_ADMIN_START_END_SQL = "SELECT * FROM Products WHERE writer LIKE '%(관리자)'";
	private final String SELECT_COUNT_SQL = "select count(*) as count from Products";
	private final String SELECT_COUNT_SUBJECT_SQL = "SELECT COUNT(*) AS count FROM Products WHERE subject LIKE ?";
	private final String SELECT_COUNT_WRITER_SQL = "SELECT COUNT(*) AS count FROM Products WHERE writer LIKE ?";
	private final String SELECT_COUNT_CONTENT_SQL = "SELECT COUNT(*) AS count FROM Products WHERE content LIKE ?";
	private final String SELECT_ADMIN_COUNT_SQL = "select count(*) as count from Products WHERE writer LIKE '%(관리자)'";
	private final String SELECT_ONE_SQL = "select * from Products where num = ?";
	private final String SELECT_PASS_ID_CHECK_SQL = "select count(*) count from Products where num = ? and pass = ?";
	private final String DELETE_SQL = "DELETE FROM Products WHERE NUM = ? AND PASS = ?";
	private final String DELETE_ADMIN_SQL = "DELETE FROM Products WHERE NUM = ?";
	private final String UPDATE_SQL = "update Products set writer=?,subject=?,content=? where num=?";
	private final String INSERT_SQL = "INSERT INTO products (num,name, price, amount, tag, content, imgUrl, REGDATE) VALUES (commentmember_SEQ.nextval,?, ?, ?, ?, ?, ?, ?)";
	private final String ADD_COMMENT_READCOUNT_SQL = "update Products set comments = comments + 1 where num = ?";
	private final String DOWN_COMMENT_READCOUNT_SQL = "update Products set comments = comments - 1 where num = ?";
	
	
	
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
/*			case "subject":
				pstmt = con.prepareStatement(SELECT_COUNT_SUBJECT_SQL);
				pstmt.setString(1, "%"+bvo.getSubject()+"%");
				System.out.println("한국어 문제"+"%"+bvo.getSubject()+"%");
				break;
			case "writer":
				pstmt = con.prepareStatement(SELECT_COUNT_WRITER_SQL);
				pstmt.setString(1, "%"+bvo.getWriter()+"%");
				break;
			case "content":
				pstmt = con.prepareStatement(SELECT_COUNT_CONTENT_SQL);
				pstmt.setString(1, "%"+bvo.getContent()+"%");
				break;
*/				
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
	/*
	public int selectAdminCountDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			pstmt = con.prepareStatement(SELECT_ADMIN_COUNT_SQL);
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

	public ArrayList<ProductsVO> selectDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProductsVO> ProductsList = new ArrayList<ProductsVO>();
		try {
			pstmt = con.prepareStatement(SELECT_SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int num = rs.getInt("num");
				String writer = rs.getString("writer");
				String subject = rs.getString("subject");
				String pass = rs.getString("pass");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				String content = rs.getString("content");
				String ip = rs.getString("ip");
				ProductsVO vo = new ProductsVO(num, writer, subject, pass, readcount, ref, step, depth, regdate,
						content, ip);
				ProductsList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return ProductsList;
	}

*/
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

	/*
	public ProductsVO selectProductsOneDB(ProductsVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductsVO bvo = null;
		int count = 0;
		try {
			// 글 전체내용 조회
			pstmt = con.prepareStatement(SELECT_ONE_SQL);
			pstmt.setInt(1, vo.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int num = rs.getInt("num");
				String writer = rs.getString("writer");
				String subject = rs.getString("subject");
				String pass = rs.getString("pass");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				String content = rs.getString("content");
				String ip = rs.getString("ip");
				bvo = new ProductsVO(num, writer, subject, pass, readcount, ref, step, depth, regdate, content, ip);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return bvo;
	}

	
*/	
	
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
/*				
			case "subject":
				pstmt = con.prepareStatement(SELECT_START_END_SUBJECT_SQL);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				pstmt.setString(3, "%"+bvo.getSubject()+"%");
				break;
			case "writer":
				pstmt = con.prepareStatement(SELECT_START_END_WRITER_SQL);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				pstmt.setString(3, "%"+bvo.getWriter()+"%");
				break;
			case "content":
				pstmt = con.prepareStatement(SELECT_START_END_CONTENT_SQL);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				pstmt.setString(3, "%"+bvo.getContent()+"%");
				break;
*/				
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
	
/*	
	public ArrayList<ProductsVO> selectAdminStartEndDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProductsVO> ProductsList = new ArrayList<ProductsVO>();	//arrayList갯수정해줌
		try {
			pstmt = con.prepareStatement(SELECT_ADMIN_START_END_SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String subject = rs.getString("subject");
				int num = rs.getInt("num");
				ProductsVO vo = new ProductsVO();
				vo.setNum(num);
				vo.setSubject(subject);
				ProductsList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return ProductsList;
	}
	
	public int updateDB(ProductsVO vo) {
		// 1: 성공, 2. 패스워드문제, 3 수정문제
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int passCheckCount = 0;
		int count = 0;
		int returnValue = 1;

		// 패스워드가 맞는지 점검필요
		try {
			pstmt = con.prepareStatement(SELECT_PASS_ID_CHECK_SQL);
			pstmt.setInt(1, vo.getNum());
			pstmt.setString(2, vo.getPass());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				passCheckCount = rs.getInt("COUNT");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (passCheckCount != 0) {
			try {
				pstmt = con.prepareStatement(UPDATE_SQL);
				pstmt.setString(1, vo.getWriter());
				pstmt.setString(2, vo.getSubject());
				pstmt.setString(3, vo.getContent());
				pstmt.setInt(4, vo.getNum());
				count = pstmt.executeUpdate();
				if (count == 0)
					returnValue = 3;
				else
					returnValue = 1;
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				cp.dbClose(con, pstmt);
			}
		} else {
			returnValue = 2;
		}
		return returnValue;
	}
	
	
	public boolean deleteDB(ProductsVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count=0;
		
		// 패스워드가 맞는지 점검필요
		try {
			if(vo.getWriter().equals("admin")) {
			pstmt = con.prepareStatement(DELETE_ADMIN_SQL);
			pstmt.setInt(1, vo.getNum());
			}else {
			pstmt = con.prepareStatement(DELETE_SQL);
			pstmt.setInt(1, vo.getNum());	
			pstmt.setString(2, vo.getPass());
			}
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return (count!=0)?(true):(false);
	}
	
	public void commentAddDB(ProductsVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count=0;
		
		try {
			pstmt = con.prepareStatement(ADD_COMMENT_READCOUNT_SQL);
			pstmt.setInt(1, vo.getNum());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void commentDownDB(ProductsVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count=0;
		
		try {
			pstmt = con.prepareStatement(DOWN_COMMENT_READCOUNT_SQL);
			pstmt.setInt(1, vo.getNum());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	*/

}
