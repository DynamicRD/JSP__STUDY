<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1. 사용자정보를 가져온다. -->
<%
boolean flag = (boolean)request.getAttribute("flag");
if (flag == true) {
	response.sendRedirect("list.do");
}else{
%>
<script>
	alert("글 등록이 실패되었습니다.")
	history.go(-1);
</script>
<%
}
%>