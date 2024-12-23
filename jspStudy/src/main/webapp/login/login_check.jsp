<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="co.kh.dev.login.model.LoginDAO"%>
<%@ page import="co.kh.dev.login.model.LoginVO"%>
<!-- 1.사용자 정보를 가져온다 -->
<!-- 2.curd 한다 -->
<!-- 3.화면출력한다 -->
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
%>
<% 
boolean successFlag = false;
//아이디 패스워드 확인
String message = null;
if (id != null && pass != null) {
	// 1. LoginVO 객체 생성
	LoginVO lvo = new LoginVO(id, pass);
	LoginDAO ld = new LoginDAO();
	// 2. selectLogin 메서드를 호출하여 로그인 정보 확인
	LoginVO rlvo = ld.selectLogin(lvo);
	successFlag = rlvo.isSuccessFlag();
	
	// 3. 로그인 성공 시 세션을 생성하여 사용자 정보 저장
	if (successFlag) {
		session.setAttribute("id", id);
		session.setAttribute("pass", pass);
		session.setAttribute("name", rlvo.getName());
		response.sendRedirect("login_main.jsp");
		message = "로그인 성공입니다";
	}
	else {
		message = "로그인 실패입니다";
	}
}
%>
<script>
	alert('<%= message%>');
	window.location.href = 'login_main.jsp';
</script>
