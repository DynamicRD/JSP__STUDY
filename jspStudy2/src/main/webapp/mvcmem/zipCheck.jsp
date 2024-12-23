<%@page import="com.kh.dev.student.model.ZipCodeVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 3.화면설계(자바코드에 해야되는데 - > jsp service함수에서 진행한다. -->
<%
	String check = (String)request.getAttribute("check");
	String dong = (String)request.getAttribute("dong");
	ArrayList<ZipCodeVO> zipcodeList = (ArrayList<ZipCodeVO>)request.getAttribute("zipcodeList");
	int totalList =(Integer)request.getAttribute("totalList");

%>
<html>
<head>
<title>우편번호검색</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
<!-- ② -->
</head>
<body bgcolor="#FFFFCC">
	<main>
		<b>우편번호 찾기</b>
		<form name="zipForm" method="post" action="zipCheck.do">
			<input type="hidden" name="check" value="n">
			<table>
				<tr>
					<td>동이름 입력 : <input name="dong" type="text"> <input
						type="button" value="검색" onclick="dongCheck()" />
					</td>
				</tr>
			</table>
		</form>
		<table>
			<!-- ③ -->
			<%
			if (check.equals("n")) {
				if (zipcodeList.isEmpty()) {
			%>
			<tr>
				<td align="center"><br />검색된 결과가 없습니다.</td>
			</tr>
			<%
			} else {
			%>
			<tr>
				<td align="center"><br /> ※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</td>
			</tr>
			<%
			for (ZipCodeVO data : zipcodeList) {
				String tempZipcode = data.getZipcode();
				String tempSido = data.getSido();
				String tempGugun = data.getGugun();
				String tempDong = data.getDong();
				String tempBunji = data.getBunji();
				if (tempBunji == null) {
					tempBunji = " ";
				}
			%>
			<tr>
				<td><a href="javascript:sendAddress('<%=tempZipcode%>','<%=tempSido%>','<%=tempGugun%>','<%=tempDong%>','<%=tempBunji%>')">
						<%= data.toString()%></a><br>
					<%
			    } //end for
					} //zipList.isEmpty() end else
					} //check.equals("n") end
					%></td>
			</tr>
			<!-- ③ -->
			<tr>
				<td align="center"><a href="javascript:this.close();">닫기</a></td>
			</tr>
		</table>
	</main>
</body>
</html>