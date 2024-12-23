<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@page import="co.kh.dev.homepageproject.model.MemberVO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
String id = (String) session.getAttribute("id");
MemberVO mvo = new MemberVO();
mvo.setId(id);
MemberDAO mdao = MemberDAO.getInstance();
mvo = mdao.selectOneDB(mvo);

%>

<main>
		<form method="post" action="memberChangeProc.jsp" name="regForm" class="myform2" onsubmit="return checkForm2()">
			<input type="hidden" name="id" value="<%=id %>" />
			<table  >
				<tr>
					<td  class="login_table" colspan="2" align="center">회원 정보 변경</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td align="left">
						&nbsp;&nbsp;<%=mvo.getId()%>
					</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td align="left">&nbsp;&nbsp;<input id="input-pw12" type="password" name="pass" value=<%=mvo.getPass() %> required /><span></span></td>
				</tr>
				<tr>
					<td>패스워드 확인</td>
					<td align="left">&nbsp;&nbsp;<input id="input-pw22" type="password" name="repass" value=<%=mvo.getPass() %> required /><span></span></td>
				</tr>
				<tr>
					<td>이름</td>
					<td align="left">&nbsp;&nbsp;<input id="input-name2" type="text" name="name" value=<%=mvo.getName() %> required /><span></span></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td align="left">&nbsp;&nbsp;<input id="input-tel2"  type="tel" name="tel" value=<%=mvo.getPhone() %> required /><span></span></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td align="left">&nbsp;&nbsp;<input  id="input-email2"  type="text" name="email" value=<%=mvo.getEmail() %> required /><span></span></td>
				</tr>
				<tr>
					<td>우편번호</td>
					<td align="left">
						&nbsp;&nbsp;<input  id="zipcode2"  type="text" name="zipcode" value=<%=mvo.getZipcode() %> required /> 
						<br>
						&nbsp;&nbsp;<input type="button" value="찾기" onClick="zipCheck()" />
					</td>
				</tr>
				<tr>
					<td>주소1</td>
					<td align="left">&nbsp;&nbsp;<input  id="addr12" type="text" name="address1" value=<%=mvo.getAddress1() %> size="50" required /></td>
				</tr>
				<tr>
					<td>주소2</td>
					<td align="left">&nbsp;&nbsp;<input id="addr22" type="text" name="address2" value=<%=mvo.getAddress2() %> size="30" required /></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="정보수정"/>&nbsp;&nbsp; 
						<input type="reset" value="다시입력" />&nbsp;&nbsp;
						<input type="button" onclick="location.href = 'mainPage.jsp?flag=none'" value="뒤로가기"> 
					</td>
				</tr>
			</table>
		</form>
	</main>