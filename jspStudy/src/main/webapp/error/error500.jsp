<%@page contentType="text/html; charset=UTF-8"%>
<%@page isErrorPage="true" %>
<% 
//웹브라우저에게 정상적으로 처리됨을 통보한다 200번
response.setStatus(HttpServletResponse.SC_OK); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>500예외발생</title>
</head>
<body>
	<h1>요청과정중에 문제가 발생하였습니다.</h1>
	<h1>빠른시간안에 처리하도록 하겠습니다</h1>
	<h2>에러타입 <%= exception.getClass().getName() %></h2>
	<h2>에러메시지 <%= exception.getMessage() %></h2>
</body>
</html>