<%@page import="co.kh.dev.homepageproject.model.MemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
MemberDAO mdao = MemberDAO.getInstance();
MemberVO mvo = new MemberVO();
try{
int money = Integer.parseInt(request.getParameter("money"));
String id = (String)session.getAttribute("id");
mvo.setMoney(money);
mvo.setId(id);
boolean check = mdao.memberAddMoney(mvo);
%>
<!-- 3.화면출력한다 -->
<%
if (check) {
%>
<script type="text/javascript">
	alert("성공적으로 충전했습니다");
	window.location.href = "mainPage.jsp?flag=myPage"; // 알림창 후 로그인 페이지로 이동
</script>
<%
} else {
%>
<script>
	alert("오류가 발생했습니다.");
	history.go(-1);
</script>
<%
}
}catch(Exception e){
%>
<script>
	alert("입력오류입니다.");
	history.go(-1);
</script>
<%
}
%>