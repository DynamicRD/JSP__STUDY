<%@ page contentType="text/html; charset=UTF-8"%>
<%
 Cookie cookie = new Cookie("name", "1time");
 cookie.setMaxAge(60); // 60초(1분)
 response.addCookie(cookie);
%>
<html>
<head><title>쿠키유효시간설정</title></head>
<body>
유효시간이 60초인 쿠키 생성. </body>
</html>