<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<!-- 1. -->
<%
String pageNum = (String)request.getAttribute("pageNum");
int check = (Integer)request.getAttribute("check");
if (check == 1) {
%>
<meta http-equiv="Refresh" content="0;url=list.do?pageNum=<%=pageNum%>">
<%
} else if(check==2){
%>
<script language="JavaScript">
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
</script>
<%
}else{
%>
<script language="JavaScript">
	alert("업데이트에 문제가 발생하였습니다.");
	history.go(-1);
</script>
<%
}
%>