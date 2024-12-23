<%@page import="com.kh.dev.student.model.StudentVO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 3.화면설계(자바코드에 해야되는데 - > jsp service함수에서 진행한다. -->
<%
StudentVO svo = (StudentVO)request.getAttribute("svo");
%>
<html>
<head>
<title>Update Form</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="script.js?timestamp=<%= System.currentTimeMillis() %>"></script>
</head>
<body>
	<main>
	<form name="regForm" method="post" action="modifyProc.do">
		<table border="1">
			<tr>
				<td colspan="2" align="center">회원 수정 정보 입력</td>
			</tr>
			<tr>
				<td align="right">아이디 :</td>
				<td><%= svo.getId()%></td>
			</tr>
			<tr>
				<td align="right">패스워드 :</td>
				<td><input type="password" name="pass" value="<%=svo.getPass()%>"/></td>
			</tr>
			<tr>
				<td align="right">패스워드 확인:</td>
				<td><input type="password" name="repass" value="<%=svo.getPass()%>" /></td>
			</tr>
			<tr>
				<td align="right">이름 :</td>
				<td><%=svo.getName()%></td>
			</tr>
			<tr>
				<td align="right">전화번호 :</td>
				<td>
				  <input type="text" name="phone1" size="4"	value="<%=svo.getPhone1()%>" /> - 
					<input type="text" name="phone2" size="5" value="<%=svo.getPhone2()%>" /> - 
					<input type="text" name="phone3" size="5" value="<%=svo.getPhone3()%>" />
				</td>
			</tr>
			<tr>
				<td align="right">이메일 :</td>
				<td><input type="text" name="email" value="<%=svo.getEmail()%>" /></td>
			</tr>
			<tr>
				<td align="right">우편번호 :</td>
				<td><input type="text" name="zipcode"
					value="<%=svo.getZipcode()%>" /> <input type="button" value="찾기"
					onClick="zipCheck()" /></td>
			</tr>
			<tr>
				<td align="right">주소1 :</td>
				<td><input type="text" name="address1" size="50"
					value="<%=svo.getAddress1()%>" /></td>
			</tr>
			<tr>
				<td align="right">주소2 :</td>
				<td><input type="text" name="address2" size="30"
					value="<%=svo.getAddress2()%>" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="정보수정" onClick="updateCheck()" />&nbsp;&nbsp; 
					<input type="button" value="취소" 	onClick="javascript:window.location='login.do'" /></td>
			</tr>
		</table>
	</form>
	</main>
</body>
</html>