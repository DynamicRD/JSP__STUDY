<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="./signup.css">
</head>
<body>
    <%
        String id = request.getParameter("id");
        String pwd = request.getParameter("pwd");
        String pwdTest = request.getParameter("pwdtest");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String birth = request.getParameter("birth");
        String message = "";
        boolean isSuccess = false;

        if (id != null && pwd != null && email != null && name != null) {
            if (pwdTest != null && !pwd.equals(pwdTest)) {
                message = "비밀번호와 비밀번호 확인이 일치하지 않습니다.";
            } else {
                Connection con = null;
                PreparedStatement pstmt = null;

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

                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    con = DriverManager.getConnection(url, user, pw);
                    pstmt = con.prepareStatement("INSERT INTO SIGNUP (ID, PWD, EMAIL, NAME, BIRTH) VALUES (?, ?, ?, ?, ?)");
                    pstmt.setString(1, id);
                    pstmt.setString(2, pwd);
                    pstmt.setString(3, email);
                    pstmt.setString(4, name);
                    if (birth != null && !birth.isEmpty() && birth.matches("\\d{8}")) {
                        pstmt.setInt(5, Integer.parseInt(birth));
                    } else {
                        pstmt.setNull(5, java.sql.Types.INTEGER);
                    }

                    int result = pstmt.executeUpdate();
                    if (result > 0) {
                        message = "회원가입이 성공적으로 완료되었습니다. 잠시 후 로그인 페이지로 이동합니다.";
                        isSuccess = true;
                    } else {
                        message = "회원가입에 실패했습니다. 다시 시도해주세요.";
                    }
                } catch (Exception e) {
                    message = "회원가입 처리 중 문제가 발생했습니다. 잠시 후 다시 시도해주세요.";
                    System.out.println("회원가입 오류: " + e.getMessage()); // 서버에 로그 기록
                } finally {
                    try {
                        if (pstmt != null) pstmt.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        message = "데이터베이스 연결 닫기 중 오류 발생: " + e.getMessage();
                        System.out.println(message);
                    }
                }
            }
        }
    %>

    <form action="signup.jsp" method="post">
        <table>
            <thead>
                <tr>
                    <th colspan="2">회원 기본 정보</th>
                </tr>
            </thead>
            <tr>
                <th class="title">아이디:</th>
                <td><input type="text" name="id" id="id" required><i>4~12자의 영문 대소문자와 숫자로만 입력</i></td>
            </tr>
            <tr>
                <th class="title">비밀번호:</th>
                <td><input type="password" name="pwd" id="pwd" required><i>4~12자의 영문 대소문자와 숫자로만 입력</i></td>
            </tr>
            <tr>
                <th class="title">비밀번호확인:</th>
                <td><input type="password" name="pwdtest" id="pwdtest" required></td>
            </tr>
            <tr>
                <th class="title">메일주소:</th>
                <td><input type="text" name="email" id="email" required><i>ex) abcd@gmail.com</i></td>
            </tr>
            <tr>
                <th class="title">이름:</th>
                <td><input type="text" name="name" id="name" required></td>
            </tr>
            <tr>
                <th class="title">생년월일:</th>
                <td><input type="text" name="birth" id="birth"><i>ex) 20000101</i></td>
            </tr>
        </table>

        <footer>
            <hr>
            <button type="submit">회원 가입</button>
            <button type="reset">다시 입력</button>
        </footer>
    </form>

    <% if (!message.isEmpty()) { %>
        <p style="<%= isSuccess ? "color: green;" : "color: red;" %>"><%= message %></p>
        <% if (isSuccess) { %>
            <script>
                setTimeout(function() {
                    window.location.href = 'login.jsp';
                }, 3000);
            </script>
        <% } %>
    <% } %>
</body>
</html>
