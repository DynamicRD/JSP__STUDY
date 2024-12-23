<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<title>회원가입</title>
<style>
#my_table {
	margin: 0 auto;
	border-collapse: collapse;
}
</style>
</head>
<body>

	<h2 align="center">회원가입</h2>

	<form method="post" action="new_member_db.jsp">
		<table border="1" width="300" id="my_table">
			<tr>
				<th width="100">이름</th>
				<td width="200"><input type="text" name="name" required></td>
			</tr>
			<tr>
				<th width="100">아이디</th>
				<td width="200"><input type="text" name="id" required></td>
			</tr>
			<tr>
				<th width="100">비밀번호</th>
				<td width="200"><input type="password" name="pass" required></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit"value="회원가입하기">
				<input type="reset"value="회원초기화"></td>
			</tr>
		</table>
	</form>

</body>
</html>