<%@ page contentType="text/html; charset=UTF-8"%>
	<main >
		<form method="post" action="addMoneyProc.jsp" name="addMoneyProc" class="addMoneyProc">
			<table  >
				<tr>
					<td  class="login_table" colspan="2" align="center">금액 충전</td>
				</tr>
				<tr>
					<td>충전할 금액을 적어주세요</td>
					<td align="left">&nbsp;&nbsp;<input type="text" name="money" required /><span></span></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="충전하기"/>&nbsp;&nbsp; 
						<input type="reset" value="다시입력" />&nbsp;&nbsp;
						<input type="button" onclick="location.href = 'mainPage.jsp?flag=myPage'" value="뒤로가기"> 
					</td>
				</tr>
			</table>
		</form>
	</main>