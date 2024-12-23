<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="co.kh.dev.login.model.LoginDAO"%>
<%@ page import="co.kh.dev.login.model.LoginVO"%>
<!-- 1.사용자 정보를 가져온다 -->
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");

boolean successFlag = false;
%>
<!-- 2. curd -->
<% 
// 2. 로그인 정보 객체 생성 및 DB에 저장
LoginDAO ldao = new LoginDAO();
LoginVO lvo = new LoginVO(id, pass, name);
successFlag = ldao.newLogin(lvo);
String message = (successFlag == true)? ("가입 성공했습니다") : ("가입 실패했습니다");
%>
<!-- 3. 화면설계 -->
	<html>
	<head>
	<script>
	window.onload = function() {
	alert('<%= message%>');
	window.location.href = 'login_main.jsp';
	};
	</script>
	</head>
	<body>
	</body>
	</html>
