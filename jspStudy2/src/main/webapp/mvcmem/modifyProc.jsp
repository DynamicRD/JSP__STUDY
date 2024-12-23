<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 3.화면설계 -->
<%
	boolean flag = (Boolean)request.getAttribute("flag");
%>
<html>
<head>
<title>Update Process</title>
</head>
<link href="style.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Refresh" content="3;url=login.jsp">
<body>
	<main>
	<%
	if (flag == true){
	%>
		<p> 입력하신 내용대로 <b>회원정보가 수정 되었습니다.</b><br></br>
			3초후에 Logon Page로 이동합니다
		</p>
	<%}else{%>
		<p> 입력하신 내용대로 <b>회원정보가 수정 안되었습니다.</b><br></br>
			3초후에 Logon Page로 이동합니다
		</p>
		
	<%}
	
	%>
	</main>
</body>
</html>