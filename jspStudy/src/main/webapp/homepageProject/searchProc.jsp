<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1.사용자 정보를 가져온다 -->
<!-- 2.curd 한다 -->
<%
request.setCharacterEncoding("utf-8");
String searchType = request.getParameter("searchType");
String search = request.getParameter("search");
session.setAttribute("searchType", searchType);
session.setAttribute("search", search);
%>
<!-- 3.화면출력한다 -->
<script type="text/javascript">
	window.location.href = "mainPage.jsp"; // 알림창 후 로그인 페이지로 이동
</script>
