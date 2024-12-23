<%@page import="co.kh.dev.homepageproject.model.MemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
MemberDAO mdao = MemberDAO.getInstance();
MemberVO mvo = new MemberVO();
String id = request.getParameter("id");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
mvo.setId(id);
mvo.setEmail(email);
mvo.setPhone(phone);
System.out.println(mvo.getId());
System.out.println(mvo.getEmail());
System.out.println(mvo.getPhone());
String passFound = mdao.findMemberPASS(mvo);
%>
<!-- 3.화면출력한다 -->
<%
if (passFound.equals("none")) {
%>
<script>
	alert("입력정보에 오류가 있습니다.");
	history.go(-1);
</script>
<%
} else {
%>
<script type="text/javascript">
	alert("<%=id%> 회원님의 비밀번호는 <%=passFound%> 입니다.");
	window.location.href = "mainPage.jsp?flag=none"; // 알림창 후 로그인 페이지로 이동
</script>
<%
}
%>