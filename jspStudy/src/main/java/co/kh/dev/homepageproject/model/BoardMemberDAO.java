package co.kh.dev.homepageproject.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import co.kh.dev.common.ConnectionPool;

public class BoardMemberDAO {
	// 싱글톤방식
	// 1. 객체
	private static BoardMemberDAO instance;

	// 2. 생성자
	private BoardMemberDAO() {
	};

	// 3.
	public static BoardMemberDAO getInstance() {
		if (instance == null) {
			synchronized (BoardMemberDAO.class) {
				instance = new BoardMemberDAO();
			}
		}
		return instance;
	}

	private final String SELECT_SQL = "select * from BoardMember order by num desc";
	private final String SELECT_START_END_SQL = " select * from "
			+ "(select rownum AS rnum, num, writer, subject, pass, regdate, readcount, ref, step, depth,comments, content, ip "
			+ "from (select * from BoardMember order by ref desc, step asc)) where rnum>=? and rnum<=?";
	private final String SELECT_START_END_SUBJECT_SQL = " select * from "
			+ "(select rownum AS rnum, num, writer, subject, pass, regdate, readcount, ref, step, depth,comments, content, ip "
			+ "from (select * from BoardMember order by ref desc, step asc)) where rnum>=? and rnum<=? and subject LIKE ?";
	private final String SELECT_START_END_WRITER_SQL = " select * from "
			+ "(select rownum AS rnum, num, writer, subject, pass, regdate, readcount, ref, step, depth,comments, content, ip "
			+ "from (select * from BoardMember order by ref desc, step asc)) where rnum>=? and rnum<=? and writer LIKE ?";
	private final String SELECT_START_END_CONTENT_SQL = " select * from "
			+ "(select rownum AS rnum, num, writer, subject, pass, regdate, readcount, ref, step, depth,comments, content, ip "
			+ "from (select * from BoardMember order by ref desc, step asc)) where rnum>=? and rnum<=? and content LIKE ?";
	private final String SELECT_ADMIN_START_END_SQL = "SELECT * FROM BoardMember WHERE writer LIKE '%(관리자)'";
	private final String SELECT_COUNT_SQL = "select count(*) as count from BoardMember";
	private final String SELECT_COUNT_SUBJECT_SQL = "SELECT COUNT(*) AS count FROM BoardMember WHERE subject LIKE ?";
	private final String SELECT_COUNT_WRITER_SQL = "SELECT COUNT(*) AS count FROM BoardMember WHERE writer LIKE ?";
	private final String SELECT_COUNT_CONTENT_SQL = "SELECT COUNT(*) AS count FROM BoardMember WHERE content LIKE ?";
	private final String SELECT_ADMIN_COUNT_SQL = "select count(*) as count from BoardMember WHERE writer LIKE '%(관리자)'";
	private final String SELECT_MAX_NUM_SQL = "select max(num) as num from BoardMember";
	private final String SELECT_ONE_SQL = "select * from BoardMember where num = ?";
	private final String SELECT_PASS_ID_CHECK_SQL = "select count(*) count from BoardMember where num = ? and pass = ?";
	private final String DELETE_SQL = "DELETE FROM BoardMember WHERE NUM = ? AND PASS = ?";
	private final String DELETE_ADMIN_SQL = "DELETE FROM BoardMember WHERE NUM = ?";
	private final String UPDATE_SQL = "update BoardMember set writer=?,subject=?,content=? where num=?";
	private final String INSERT_SQL = "insert into BoardMember(num, writer, subject, pass, regdate, ref, step, depth, content, ip) values(BoardMember_seq.nextval,?,?,?,?,?,?,?,?,?)";
	private final String UPDATE_STEP_SQL = "update BoardMember set step=step+1 where ref= ? and step > ?";
	private final String UPDATE_READCOUNT_SQL = "update BoardMember set readcount=readcount+1 where num = ?";
	private final String ADD_COMMENT_READCOUNT_SQL = "update boardmember set comments = comments + 1 where num = ?";
	private final String DOWN_COMMENT_READCOUNT_SQL = "update boardmember set comments = comments - 1 where num = ?";
	
	
	
	public Boolean insertDB(BoardMemberVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number = 0;
		int step = 0;
		int depth = 0;
		int ref = 1;
		int count = 0;

		// num 현재 보드속에 가장최고값에 +1, 값이 하나도 없으면 1
		try {
			pstmt = con.prepareStatement(SELECT_MAX_NUM_SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number = rs.getInt("num") + 1;
			} else {
				number = 1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// getNum() = 0이면 새글, 0이 아니면 답변글이다
		try {
			if (vo.getNum() != 0) {// 답변글일경우
				pstmt = con.prepareStatement(UPDATE_STEP_SQL);
				pstmt.setInt(1, vo.getRef());
				pstmt.setInt(2, vo.getStep());
				pstmt.executeUpdate();
				ref = vo.getRef();
				step = vo.getStep() + 1;
				depth = vo.getDepth() + 1;
			} else {// 새 글일 경우
				ref = number; // 가장 최고값+1
				step = 0;
				depth = 0;
			} // 쿼리를 작성
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 게시판글 등록하기
		try {
			pstmt = con.prepareStatement(INSERT_SQL);
			pstmt.setString(1, vo.getWriter());
			pstmt.setString(2, vo.getSubject());
			pstmt.setString(3, vo.getPass());
			pstmt.setTimestamp(4, vo.getRegdate());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, step);
			pstmt.setInt(7, depth);
			pstmt.setString(8, vo.getContent());
			pstmt.setString(9, vo.getIp());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		return (count > 0) ? true : false;
	}

	public int selectCountDB(BoardMemberVO bvo) {
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

	public ArrayList<BoardMemberVO> selectDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardMemberVO> BoardMemberList = new ArrayList<BoardMemberVO>();
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
				BoardMemberVO vo = new BoardMemberVO(num, writer, subject, pass, readcount, ref, step, depth, regdate,
						content, ip);
				BoardMemberList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return BoardMemberList;
	}

	public BoardMemberVO selectBoardMemberDB(BoardMemberVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardMemberVO bvo = null;
		int count = 0;
		try {
			// 조회수 증가

			pstmt = con.prepareStatement(UPDATE_READCOUNT_SQL);
			pstmt.setInt(1, vo.getNum());
			pstmt.executeUpdate();

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
				bvo = new BoardMemberVO(num, writer, subject, pass, readcount, ref, step, depth, regdate, content, ip);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return bvo;
	}

	public BoardMemberVO selectBoardMemberOneDB(BoardMemberVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardMemberVO bvo = null;
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
				bvo = new BoardMemberVO(num, writer, subject, pass, readcount, ref, step, depth, regdate, content, ip);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return bvo;
	}

	
	public ArrayList<BoardMemberVO> selectStartEndDB(int start, int end,BoardMemberVO bvo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardMemberVO> BoardMemberList = new ArrayList<BoardMemberVO>(end-start+1);	//arrayList갯수정해줌
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
				int num = rs.getInt("num");
				String writer = rs.getString("writer");
				String subject = rs.getString("subject");
				String pass = rs.getString("pass");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				int conmments = rs.getInt("comments");
				String content = rs.getString("content");
				String ip = rs.getString("ip");
				BoardMemberVO vo = new BoardMemberVO(num, writer, subject, pass, readcount, ref, step, depth, conmments, regdate, content, ip);
				BoardMemberList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return BoardMemberList;
	}
	
	public ArrayList<BoardMemberVO> selectAdminStartEndDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardMemberVO> BoardMemberList = new ArrayList<BoardMemberVO>();	//arrayList갯수정해줌
		try {
			pstmt = con.prepareStatement(SELECT_ADMIN_START_END_SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String subject = rs.getString("subject");
				int num = rs.getInt("num");
				BoardMemberVO vo = new BoardMemberVO();
				vo.setNum(num);
				vo.setSubject(subject);
				BoardMemberList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return BoardMemberList;
	}
	
	public int updateDB(BoardMemberVO vo) {
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
	
	
	public boolean deleteDB(BoardMemberVO vo) {
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
	
	public void commentAddDB(BoardMemberVO vo) {
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
	
	public void commentDownDB(BoardMemberVO vo) {
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

}
