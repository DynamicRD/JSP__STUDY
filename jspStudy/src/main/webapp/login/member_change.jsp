<%@ page contentType="text/html; charset=UTF-8"%>

<html>
<head>
<style>
#my_table {
	margin: 0 auto;
	border-collapse: collapse;
}
</style>
</head>
<body>
	<!-- 비밀번호 변경 폼 -->
	<form method="post" action="member_change_db.jsp">
		<table border="1" width="400" id="my_table">
			<tr>
				<th width="200">새로운 비밀번호</th>
				<td width="200">&nbsp;<input type="password" name="pass">
				</td>
			</tr>
			<tr>
				<th width="200">비밀번호 재확인</th>
				<td width="200">&nbsp;<input type="password" name="pass1">
				</td>
			</tr>
			<tr>
				<td align="center" colspan="2"><input type="submit" value="확인">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>