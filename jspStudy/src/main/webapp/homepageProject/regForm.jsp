<%@page contentType="text/html; charset=UTF-8"%>
	<main >
		<form method="post" action="regProc.jsp" name="regForm" class="myform">
			<table  >
				<tr>
					<td  class="login_table" colspan="2" align="center">회원 가입 정보 입력</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td align="left">
						&nbsp;&nbsp;<input id="input-id" type="text" name="id" required /><span></span>&nbsp; 
						<br>
						&nbsp;&nbsp;<input type="button" value="중복확인" onClick="idCheck(this.form.id.value)" />
					</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td align="left">&nbsp;&nbsp;<input id="input-pw1" type="password" name="pass" required /><span></span></td>
				</tr>
				<tr>
					<td >패스워드 확인</td>
					<td align="left">&nbsp;&nbsp;<input id="input-pw2" type="password" name="repass" required /><span></span></td>
				</tr>
				<tr>
					<td>이름</td>
					<td align="left">&nbsp;&nbsp;<input id="input-name" type="text" name="name" required /><span></span></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td align="left">&nbsp;&nbsp;<input id="input-tel"  type="tel" name="tel" required /><span></span></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td align="left">&nbsp;&nbsp;<input  id="input-email"  type="text" name="email" required /><span></span></td>
				</tr>
				<tr>
					<td>우편번호</td>
					<td align="left">
						&nbsp;&nbsp;<input  id="zipcode"  type="text" name="zipcode" required /> 
						<br>
						&nbsp;&nbsp;<input type="button" value="찾기" onClick="zipCheck()" />
					</td>
				</tr>
				<tr>
					<td>주소1</td>
					<td align="left">&nbsp;&nbsp;<input  id="addr1" type="text" name="address1" size="50" required /></td>
				</tr>
				<tr>
					<td>주소2</td>
					<td align="left">&nbsp;&nbsp;<input id="addr2" type="text" name="address2" size="30" required /></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="회원가입"/>&nbsp;&nbsp; 
						<input type="reset" value="다시입력" />&nbsp;&nbsp;
						<input type="button" onclick="location.href = 'mainPage.jsp?flag=none'" value="뒤로가기"> 
					</td>
				</tr>
			</table>
		</form>
	</main>
<!-- </body>
</html> -->