<%@page import="co.kh.dev.homepageproject.model.BoardMemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1. 사용자정보를 가져온다. -->
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="vo" scope="page"
	class="co.kh.dev.homepageproject.model.BoardMemberVO">
	<jsp:setProperty name="vo" property="*" />
</jsp:useBean>
<!-- 2. curd -->
<%
vo.setRegdate(new Timestamp(System.currentTimeMillis()));
vo.setIp(request.getRemoteAddr());
if(session.getAttribute("id")==null){
	vo.setWriter(vo.getWriter()+"(비회원)");
}else if((session.getAttribute("id")).equals("admin")){
	vo.setWriter(vo.getWriter()+"(관리자)");
}
BoardMemberDAO bdao = BoardMemberDAO.getInstance();
boolean flag = bdao.insertDB(vo);
if (flag == true) {
	response.sendRedirect("mainPage.jsp");
}else{
%>
<script>
	alert("글 등록이 실패되었습니다.")
	history.go(-1);
</script>
<%
}
%>
