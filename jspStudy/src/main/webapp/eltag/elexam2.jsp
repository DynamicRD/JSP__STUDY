<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setAttribute("name", "홍길동");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li>${name}</li>
		<li>${requestScope.name}</li>
		<li>${requestScope["name"]}</li>
		<li>${pageContext.request.requestURI}</li>
		<li>param.code = ${param.code}</li>
	</ul>
</body>
</html>