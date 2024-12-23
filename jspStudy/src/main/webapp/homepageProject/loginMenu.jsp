<%@ page contentType="text/html; charset=UTF-8"%>
<form method="post" action="loginCheck.jsp">
	<div class="login_block">
		<table width="200" id="login_table">
			<tr>
				<th width="50px" height="50px" class="login_input" bgcolor="lightgrey">아이디</th>
				<td bgcolor="white"><input type="text" name="id" required></td>
			</tr>
			<tr>
				<th class="login_input" bgcolor="lightgrey">비번</th>
				<td  bgcolor="white"><input type="password" name="pass" required></td>
			</tr>
			<br>
		</table>
	<input type="submit" value="로그인"> 
	<input type="button" onclick="location.href = 'mainPage.jsp?flag=regform'" value="회원가입"> 
	<input type="button" onclick="location.href = 'mainPage.jsp?flag=findMemberForm'" value="아이디찾기">
	<input type="button" onclick="location.href = 'mainPage.jsp?flag=findPassForm'" value="비밀번호찾기">
	</div>
</form>