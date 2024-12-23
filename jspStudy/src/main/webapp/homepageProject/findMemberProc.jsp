<%@page import="co.kh.dev.homepageproject.model.MemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
MemberDAO mdao = MemberDAO.getInstance();
MemberVO mvo = new MemberVO();
String name = request.getParameter("name");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
mvo.setName(name);
mvo.setEmail(email);
mvo.setPhone(phone);
String idFound = mdao.findMemberID(mvo);
%>
<!-- 3.화면출력한다 -->
<%
if (idFound.equals("none")) {
%>
<script>
	alert("해당 회원은 존재하지 않습니다");
	history.go(-1);
</script>
<%
} else {
%>
<script type="text/javascript">
	alert("회원님의 아이디는 <%=idFound%> 입니다.");
	window.location.href = "mainPage.jsp?flag=none"; // 알림창 후 로그인 페이지로 이동
</script>
<%
}
%>