<%@page import="java.util.Date"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
	//service() 함수의 지역변수
	Date date = new Date();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script></script>
<style type="text/css"></style>
</head>
<body>
	<h1>top.jsp 페이지 내용입니다.</h1>
	<h2>오늘의 시간은 <%= date.toString() %></h2>
	<hr color='red'>
