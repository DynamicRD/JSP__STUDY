package co.kh.dev.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/memberList.do")
public class MemberList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemberList() {
		super();
		System.out.println("멤버리스트 생성자 실행");
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 사용자 데이터 가져오기

		// 2. 테이블 curd
		Connection con = null;
		String MEMBER_SELECT = "select * from member order by no";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "webuser", "123456");
			pstmt = con.prepareStatement(MEMBER_SELECT);
			rs = pstmt.executeQuery();

			// 3. 출력하기
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<html>");
			out.println("<head><title>가입자 리스트</title></head>");
			out.println("<body>");
			while (rs.next()) {
				int no = rs.getInt("no");
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				out.println("<table align=center width=500 border=1>");
				out.println("<tr>");
				out.println("<th width=50>번호</th>");
				out.println("<td width=50 align=center>" + no + "</td>");
				out.println("<th width=70>아이디</th>");
				out.println("<td width=180 align=center>" + id + "</td>");
				out.println("<th width=50>비밀번호</th>");
				out.println("<td width=100 align=center>" + pw + "</td>");
				out.println("</tr>");
				out.println("</table>");
				out.println("<p>");
			}
			out.println("<p align=center><a href=/jspStudy/member/write.html>회원가입 다시</a></p>");
			out.println("</body>");
			out.println("</html>");
		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		} catch (SQLException e) {
			System.out.println(e.toString());
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			}
		}
	}

}
