<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% String name = (String)session.getAttribute("name"); %>
<% String id = (String)session.getAttribute("id"); %>
<%
	MemberDAO mdaooo = MemberDAO.getInstance();
	int money = mdaooo.selectMoney(id);

%>
<form method="post" action="loginCheck.jsp">
	<div class="login_block" >
			<%=name%>님 방문을 환영합니다<br><br>
			잔액 : <%=money %>
			

		<input type="button" onclick="location.href = 'mainPage.jsp?flag=myPage'" value="마이페이지">
	<input type="button" onclick="location.href = 'logout.jsp'" value="로그아웃"> 
	<%if(id != null && id.equals("admin")){ %>
	<input type="button" onclick="location.href = 'mainPage.jsp?flag=newProduct'" value="상품추가">
	<%} %>
	</div>
</form>