<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head><title>쿠키목록</title></head>
<body>
쿠키 목록<br>
<%
 Cookie[] cookies = request.getCookies();
 if (cookies != null && cookies.length > 0) {
 for (int i = 0 ; i < cookies.length ; i++) {
%>
 <%= cookies[i].getName() %> =
 <%= URLDecoder.decode(cookies[i].getValue(), "UTF-8") %><br>
<%
 		}//end for
 } else {
%>
쿠키가 존재하지 않습니다. 
<%
 }
%>
</body>
</html>