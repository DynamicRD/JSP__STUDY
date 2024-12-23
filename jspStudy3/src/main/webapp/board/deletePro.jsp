<%@ page contentType="text/html; charset=UTF-8"%>
<%
String pageNum = (String) request.getAttribute("pageNum");
boolean flag = (boolean) request.getAttribute("flag");
%>
<% 
if (flag) {
%>
<meta http-equiv="Refresh" content="0;url=list.do?pageNum=<%=pageNum%>">
<%
} else {
%>
<script>
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
</script>
<%
}
%>