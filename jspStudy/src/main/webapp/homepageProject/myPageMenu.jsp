<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String id = (String)(session.getAttribute("id"));
%>
	<table width="800">
			<tr>
				<td align="center"   class="lightgrey" >
					<a href="mainPage.jsp?flag=myPagePurchaseList">
						<i class="fa-solid fa-basket-shopping"></i>장바구니
					</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td align="center"   class="lightgrey" >
					<a href="mainPage.jsp?myId=<%=id%>">
						<i class="fa-solid fa-pen"></i>작성글 목록
					</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td align="center"   class="lightgrey" >
					<a href="mainPage.jsp?myId=<%=id%>&flag=myComment">
						<i class="fa-solid fa-keyboard"></i>작성 댓글 목록
					</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td align="center"   class="lightgrey" >
					<i class="fa-solid fa-arrow-rotate-right"></i><a href="mainPage.jsp?flag=memberChange">회원정보 수정</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td align="center"   class="lightgrey" >
				<a href="mainPage.jsp?flag=addMoney">
					<i class="fa-solid fa-sack-dollar"></i>금액 충전
					</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>