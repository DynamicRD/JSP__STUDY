<%@page import="co.kh.dev.SimpleVO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1.사용자정보를 가져온다 -->
<%
	request.setCharacterEncoding("UTF-8");
/* 	String message1 = request.getParameter("message1");
	String message2 = request.getParameter("message2");
	SimpleVO simpleVO = new SimpleVO(message1,message2); */
%>
<jsp:useBean id="simpleVO" class="co.kh.dev.SimpleVO"/>
<jsp:setProperty name="simpleVO" property = "*"/>
<!-- 2.curd -->
<!-- 3.화면설계(자바코드에 해야하는걸 ->jsp service함수에서 진행한다) -->
<html>
<body>
	<h1>간단한 빈즈 프로그램 결과</h1>
	<hr color="red"></hr>
	<br></br>
	<h3> 메세지1 : <jsp:getProperty name = "simpleVO" property="message1"></h3>
	<h3> 메세지2 : <jsp:getProperty name = "simpleVO" property="message2"></h3>
	</font>
</body>
</html>