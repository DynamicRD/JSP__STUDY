<%@page import="co.kh.dev.memberone.model.StudentVO"%>
<%@page import="co.kh.dev.memberone.model.StudentDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
%>

<%
StudentDAO sdao = new StudentDAO();
StudentVO svo = new StudentVO();
svo.setId(id);
svo.setPass(passwd);
int check = sdao.selectLoginCheck(svo);
%>


<%
if(check==1){
session.setAttribute("memId",id);
response.sendRedirect("sessionLogInConfirm.jsp");
}else if(check==0){%>
<script>
alert("비밀번호가 맞지 않습니다.");
history.go(-1);
</script>
<% }else{ %>
<script>
alert("아이디가 맞지 않습니다..");
history.go(-1);
</script>
<% }
%>