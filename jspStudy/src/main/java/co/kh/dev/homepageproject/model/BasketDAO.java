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

	private final String SELECT_SQL = "select * from Basket order by num desc";
	private final String SELECT_ID_SQL = "SELECT * FROM "
	        + "(SELECT ROWNUM AS rnum, num, id, p_num, name, regdate, price, amount, imgUrl "
	        + " FROM (SELECT * FROM SHOPBasket ORDER BY num DESC)) "
	        + "WHERE id = ?";
	private final String SELECT_ADMIN_START_END_SQL = "SELECT * FROM Basket WHERE writer LIKE '%(관리자)'";
	private final String SELECT_COUNT_SQL = "select count(*) as count from SHOPBasket where id = ?";
	private final String SELECT_COUNT_SUBJECT_SQL = "SELECT COUNT(*) AS count FROM Basket WHERE subject LIKE ?";
	private final String SELECT_COUNT_WRITER_SQL = "SELECT COUNT(*) AS count FROM Basket WHERE writer LIKE ?";
	private final String SELECT_COUNT_CONTENT_SQL = "SELECT COUNT(*) AS count FROM Basket WHERE content LIKE ?";
	private final String SELECT_ADMIN_COUNT_SQL = "select count(*) as count from Basket WHERE writer LIKE '%(관리자)'";
	private final String SELECT_ONE_SQL = "select * from Basket where num = ?";
	private final String SELECT_PASS_ID_CHECK_SQL = "select count(*) count from Basket where num = ? and pass = ?";
	private final String DELETE_SQL = "DELETE FROM ShopBasket WHERE NUM = ?";
	private final String DELETE_ID_SQL = "DELETE FROM ShopBasket WHERE ID = ?";
	private final String DELETE_ADMIN_SQL = "DELETE FROM ShopBasket WHERE NUM = ?";
	private final String UPDATE_SQL = "update Basket set writer=?,subject=?,content=? where num=?";
	private final String INSERT_SQL = "INSERT INTO shopbasket (num, ID, p_num, name, regdate, price, imgUrl, amount) VALUES (shopbasket_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?)";
	private final String ADD_COMMENT_READCOUNT_SQL = "update Basket set comments = comments + 1 where num = ?";
	private final String DOWN_COMMENT_READCOUNT_SQL = "update Basket set comments = comments - 1 where num = ?";
	
	
	
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

	public ArrayList<BasketVO> selectDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BasketVO> BasketList = new ArrayList<BasketVO>();
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
				BasketVO vo = new BasketVO(num, writer, subject, pass, readcount, ref, step, depth, regdate,
						content, ip);
				BasketList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return BasketList;
	}

*/
	
/**************************	
	public BasketVO selectBasketDB(BasketVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BasketVO bvo = null;
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
				bvo = new BasketVO(num, name, regdate, content, price, amount, tag, imgUrl);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return bvo;
	}

	/*
	public BasketVO selectBasketOneDB(BasketVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BasketVO bvo = null;
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
				bvo = new BasketVO(num, writer, subject, pass, readcount, ref, step, depth, regdate, content, ip);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return bvo;
	}

	


	public ArrayList<BasketVO> selectStartEndDB(int start, int end,BasketVO bvo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BasketVO> BasketList = new ArrayList<BasketVO>(end-start+1);	//arrayList갯수정해줌
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
				BasketVO vo = new BasketVO(num, name, regdate, content, price, amount, tag, imgUrl);
				BasketList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return BasketList;
	}
*/	
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
	
/*	
	public ArrayList<BasketVO> selectAdminStartEndDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BasketVO> BasketList = new ArrayList<BasketVO>();	//arrayList갯수정해줌
		try {
			pstmt = con.prepareStatement(SELECT_ADMIN_START_END_SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String subject = rs.getString("subject");
				int num = rs.getInt("num");
				BasketVO vo = new BasketVO();
				vo.setNum(num);
				vo.setSubject(subject);
				BasketList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return BasketList;
	}
	
	public int updateDB(BasketVO vo) {
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
	
*/	
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
/*	
	public void commentAddDB(BasketVO vo) {
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
	
	public void commentDownDB(BasketVO vo) {
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
