<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="vo" class="com.kh.edu.jstl.MemberVO" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set target="${vo}" property="name" value="kdj"></c:set>
	<c:set target="${vo}" property="email" >kdj@gmail.com</c:set>
	<c:set var="age" value="10" scope="page" ></c:set>
	<c:set target="${vo}" property="age" value="${age}"></c:set>
	<ul>
		<li>이름 : ${vo.name}</li>
		<li>메일 : <%=vo.getEmail() %></li>
		<li>나이 : ${vo.age}</li>
	</ul>
</body>
</html>