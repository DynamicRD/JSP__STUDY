<%@page import="co.kh.dev.tempmember.model.TempMemberDAO"%>
<%@page import="co.kh.dev.tempmember.model.TempMemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1.사용자정보를 가져온다  -->
<!-- 2.curd  -->
<%
//로그인 정보 리스트 가져오기
TempMemberDAO tmdao = new TempMemberDAO(); 
ArrayList<TempMemberVO> tempList  = tmdao.selectDB(); // DB에서 사용자 목록 가져오기
int counter = 0; 
%>
<!-- 3.화면설계(자바코드에 해야되는데 - > jsp service함수에서 진행한다. -->
<!DOCTYPE html>
<html>
<head>
<title>JSP에서 데이터베이스 연동</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
	<h2>JSP 스크립틀릿에서 데이터베이스 연동 예제입니다....</h2>
	<br></br>
	<h3>회원정보</h3>
	<table bordercolor="#0000ff" border="1">
		<tr>
			<td><strong>ID</strong></td>
			<td><strong>PASSWD</strong></td>
			<td><strong>NAME</strong></td>
			<td><strong>MEM_NUM1</strong></td>
			<td><strong>MEM_NUM2</strong></td>
			<td><strong>E_MAIL</strong></td>
			<td><strong>PHONE</strong></td>
			<td><strong>ZIPCODE</strong></td>
			<td><strong>ADDRESS</strong></td>
			<td><strong>JOB</strong></td>
		</tr>
<%
      for( TempMemberVO data  :  tempList){
%>
		<tr>
			<td><%= data.getId() %></td>
			<td><%= data.getPasswd() %></td>
			<td><%= data.getName() %></td>
			<td><%= data.getMemNum1() %></td>
			<td><%= data.getMemNum2() %></td>
			<td><%= data.geteMail() %></td>
			<td><%= data.getPhone() %></td>
			<td><%= data.getZipcode() %></td>
			<td><%= data.getAddress() %></td>
			<td><%= data.getJob() %></td>
<%
         counter++;
      }//end for
%>
		</tr>
	</table>
	<br></br> total records : <%= counter %>
</body>
</html>