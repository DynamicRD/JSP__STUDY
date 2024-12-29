<%@page import="co.kh.dev.homepageproject.model.BoardMemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.BoardMemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String pass = request.getParameter("pass");
String id = (String)session.getAttribute("id");
if(id == null){
	id = "none";
}
%>
<% 
BoardMemberDAO bdao = BoardMemberDAO.getInstance();
BoardMemberVO vo = new BoardMemberVO();
vo.setNum(num);
vo.setPass(pass);
vo.setWriter(id);
System.out.println(vo.getNum());
System.out.println(vo.getPass());
System.out.println(vo.getWriter());
boolean check = bdao.deleteDB(vo);
if (check) {
%>
<script type="text/javascript">
	window.location.href = "mainPage.jsp?pageNum=<%=pageNum%>"; // 알림창 후 로그인 페이지로 이동
</script>
<%}else{ %>
<script>
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
</script>
<%
}
%>