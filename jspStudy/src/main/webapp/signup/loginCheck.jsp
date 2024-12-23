<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*"%>
<%@ page import="java.io.FileReader, java.io.IOException"%>
<%@ page session="true"%>


<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String message = "";

if (id != null && pass != null) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		String filePath = "C:\\dev\\jspWorkspace\\jspStudy\\src\\main\\resources\\db.properties";
		Properties pt = new Properties();
		try (FileReader reader = new FileReader(filePath)) {
	pt.load(reader);
		} catch (IOException e) {
	throw new ServletException("db.properties 파일을 찾을 수 없습니다: " + e.getMessage());
		}

		String url = pt.getProperty("url");
		String user = pt.getProperty("user");
		String pw = pt.getProperty("pw");

		// Oracle JDBC 드라이버 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");

		// 데이터베이스 연결
		con = DriverManager.getConnection(url, user, pw);
		pstmt = con.prepareStatement("SELECT * FROM SIGNUP WHERE ID = ? AND PWD = ?");
		pstmt.setString(1, id);
		pstmt.setString(2, pass);

		// 입력된 값 디버깅용 출력
		System.out.println("로그인 시 입력한 아이디: " + id);
		System.out.println("로그인 시 입력한 비밀번호: " + pass);

		rs = pstmt.executeQuery();

		if (rs.next()) {
	// 로그인 성공 시 세션 생성
	
	session.setAttribute("id", id);

	// 로그인 성공 후 이동
	response.sendRedirect("success.jsp");
		} else {
	message = "아이디 또는 비밀번호가 잘못되었습니다.";
	response.sendRedirect("login.jsp?error=" + java.net.URLEncoder.encode(message, "UTF-8"));
		}
	} catch (ClassNotFoundException e) {
		message = "JDBC 드라이버 로드 중 오류 발생: " + e.getMessage();
		System.out.println(message);
	} catch (SQLException e) {
		message = "로그인 중 오류 발생: " + e.getMessage();
		System.out.println(message);
	} finally {
		try {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (con != null)
		con.close();
		} catch (SQLException e) {
	message = "데이터베이스 연결 닫기 중 오류 발생: " + e.getMessage();
	System.out.println(message);
		}
	}
}
%>
