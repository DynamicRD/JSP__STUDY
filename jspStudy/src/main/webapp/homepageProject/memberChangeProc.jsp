<%@page import="co.kh.dev.homepageproject.model.MemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
String message = null;
// 1.1 전송된 값을 UTF-8로 설정하기,  사용자 입력 받은 비밀번호 값
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String tel = request.getParameter("tel");
String email = request.getParameter("email");
String zipcode = request.getParameter("zipcode");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");

MemberDAO mdao = MemberDAO.getInstance();
MemberVO mvo = new MemberVO(id,pass, name, tel, email, zipcode, address1, address2);
boolean flag = mdao.memberChange(mvo);
if(flag == true){
	message = "회원정보가 잘 변경됐습니다.";
}else{
	message = "회원정보가 변경실패했습니다.";
}
%>
<html>
	<head>
	<script>
	window.onload = function() {
	alert('<%= message%>');
	window.location.href = 'mainPage.jsp?flag=none';
	};
	</script>
	</head>
	<body>
	</body>
	</html>
