<%@ page contentType="text/html; charset=UTF-8"%>
<% String name = (String)session.getAttribute("name"); %>
<% String id = (String)session.getAttribute("id"); %>
<form method="post" action="loginCheck.jsp">
	<div class="login_block" >
		<table width="200" id="login_table">
			<tr>
				<td><%=name%>님 방문을 환영합니다</td>
			</tr>
		</table>
	<input type="button" onclick="location.href = 'logout.jsp'" value="로그아웃"> 
	<input type="button" onclick="location.href = 'mainPage.jsp?flag=memberChange'" value="회원정보수정">
	<%if(id != null && id.equals("admin")){ %>
	<input type="button" onclick="location.href = 'mainPage.jsp?flag=newProduct'" value="상품추가">
	<%} %>
	</div>
</form>