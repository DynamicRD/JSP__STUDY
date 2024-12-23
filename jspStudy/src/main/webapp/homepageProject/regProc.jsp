
<%@page import="co.kh.dev.homepageproject.model.MemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1.사용자 정보를 가져온다 -->
<!-- 2.curd 한다 -->
<%
request.setCharacterEncoding("utf-8");
MemberDAO mdao = MemberDAO.getInstance();
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String phone = request.getParameter("tel");
String email = request.getParameter("email");
String zipcode = request.getParameter("zipcode");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
MemberVO mvo = new MemberVO(id, pass, name, phone, email, zipcode, address1, address2);
boolean flag = mdao.insertDB(mvo);
%>
<!-- 3.화면출력한다 -->
<%
if (flag) {
%>
<script type="text/javascript">
	alert("회원가입을 축하 드립니다.");
	window.location.href = "mainPage.jsp?flag=none"; // 알림창 후 로그인 페이지로 이동
</script>
<%
} else {
%>
<script type="text/javascript">
	alert("다시 입력하여 주십시오.");
	window.location.href = "mainPage.jsp?flag=regform"; // 알림창 후 가입 페이지로 이동
</script>
<%
}
%>