<%@ page contentType="text/html; charset=UTF-8"%>
	<main >
		<form method="post" action="findPassProc.jsp" name="findPassProc" class="findPassProc">
			<table  >
				<tr>
					<td  class="login_table" colspan="2" align="center">비밀번호 찾기</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td align="left">&nbsp;&nbsp;<input type="text" name="id" required /><span></span></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td align="left">&nbsp;&nbsp;<input type="text" name="phone" required placeholder="000-0000-0000" /><span></span></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td align="left">&nbsp;&nbsp;<input type="text" name="email" required /><span></span></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="비밀번호 찾기"/>&nbsp;&nbsp; 
						<input type="reset" value="다시입력" />&nbsp;&nbsp;
						<input type="button" onclick="location.href = 'mainPage.jsp?flag=none'" value="뒤로가기"> 
					</td>
				</tr>
			</table>
		</form>
	</main>