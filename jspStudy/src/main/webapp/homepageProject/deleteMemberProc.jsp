<%@page import="co.kh.dev.homepageproject.model.MemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String pass = request.getParameter("pass");
String realPass = (String)session.getAttribute("pass");
String id = (String)session.getAttribute("id");
System.out.println("받은비번 : " + pass);
System.out.println("진짜비번 : " + realPass);
if(realPass == null){
%>
<script>
	alert("세션이 만료되었습니다.");
	history.go(-1);
</script>
<% 
}else if(!(realPass.equals(pass))) {
%>
<script>
	alert("비밀번호가 일치하지 않습니다.");
	history.go(-1);
</script>
<%
}else{
%>
<% 
MemberDAO bdao = MemberDAO.getInstance();
MemberVO vo = new MemberVO();
vo.setId(id);
boolean check = bdao.memberDelete(vo);
if (check) {
	if (session != null) {
		session.invalidate();
	}
%>
<script type="text/javascript">
	alert("회원탈퇴에 성공했습니다.");
	window.location.href = "mainPage.jsp?flag=none";
</script>
<%}else{ %>
<script>
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
</script>
<%
}
%>
<%
}
%>