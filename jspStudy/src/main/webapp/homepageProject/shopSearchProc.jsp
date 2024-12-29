<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1.사용자 정보를 가져온다 -->
<!-- 2.curd 한다 -->
<%
request.setCharacterEncoding("utf-8");
String shopSearchType = request.getParameter("shopSearchType");
String shopSearch = request.getParameter("shopSearch");
session.setAttribute("shopSearchType", shopSearchType);
session.setAttribute("shopSearch", shopSearch);
%>
<!-- 3.화면출력한다 -->
<script type="text/javascript">
	window.location.href = "mainPage.jsp?flag=shop"; // 알림창 후 로그인 페이지로 이동
</script>
