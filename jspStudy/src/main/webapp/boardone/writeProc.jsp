<%@page import="co.kh.dev.boardone.model.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1. 사용자정보를 가져온다. -->
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="vo" scope="page"
	class="co.kh.dev.boardone.model.BoardVO">
	<jsp:setProperty name="vo" property="*" />
</jsp:useBean>
<!-- 2. curd -->
<%
vo.setRegdate(new Timestamp(System.currentTimeMillis()));
vo.setIp(request.getRemoteAddr());
BoardDAO bdao = BoardDAO.getInstance();
boolean flag = bdao.insertDB(vo);
if (flag == true) {
	response.sendRedirect("list.jsp");
}else{
%>
<script>
	alert("글 등록이 실패되었습니다.")
	history.go(-1);
</script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>