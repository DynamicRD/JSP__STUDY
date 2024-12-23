<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="co.kh.dev.login.model.LoginDAO"%>
<%@page import="co.kh.dev.login.model.LoginVO"%>
<%
// 로그인 정보 리스트 가져오기
LoginDAO ldao = new LoginDAO();
ArrayList<LoginVO> list = ldao.listLogin(); // DB에서 사용자 목록 가져오기
response.setContentType("text/html;charset=UTF-8");
%>

<html>
<head>
<title>가입자 리스트</title>
<style>
th, td {
	text-align: center;
}
</style>
</head>
<body>
	<%
	for (int i = 0; i < list.size(); i++) {
		String id = list.get(i).getId();
		String pass = list.get(i).getPass();
		String name = list.get(i).getName();
		%>
		<table align=center width=500 border=1>
			<tr>
				<th width=100>아이디</th>
				<td width=100 align=center><%= id %></td>
				<th width=100>비밀번호</th>
				<td width=100 align=center><%= pass %></td>
				<th width=100>이름</th>
				<td width=100 align=center><%= name %></td>
			</tr>
		</table>
		<p>
		<% 
	}
	%>
	<p align=center>
		<input type='button' onclick = "location.href = 'login_main.jsp'" value='이전화면으로'>
	</p>
</body>
</html>