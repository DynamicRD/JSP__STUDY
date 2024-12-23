<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
%>
	<main>
		<b>글삭제</b> <br></br>
		<form method="POST" name="delForm" action="deleteProc.jsp?pageNum=<%=pageNum%>" onsubmit="return deleteSave()">
			<input type="hidden" name="num"	value="<%=num%>">
			<table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
				<tr height="30">
<%if(session.getAttribute("id")==null ){ %>
					<td align=center bgcolor="lightgrey"><b>비밀번호를 입력해 주세요.</b></td>
				</tr>
				<tr height="30">
					<td align=center bgcolor="white">비밀번호 : 
					<input type="password" name="pass"	size="8" maxlength="12"> 
					</td>
				</tr>
				<tr height="30">
					<td align=center bgcolor="lightgrey">
<%}else if(session.getAttribute("id").equals(request.getParameter("writer"))){%>
					<td align=center bgcolor="white">
						<b>정말 삭제하시겠습니까?.</b>
						<input type="hidden" name="pass" value="<%=session.getAttribute("pass") %>"	size="8" maxlength="12"> 
					</td>
				</tr>
				<tr height="30">
					<td align=center bgcolor="lightgrey">
<%}else if(session.getAttribute("id").equals("admin")){%>
					<td align=center bgcolor="white">
						<b>정말 삭제하시겠습니까?.</b>
					</td>
				</tr>
				<tr height="30">
					<td align=center bgcolor="lightgrey">
<%}else{ %>
	<td align=center bgcolor="lightgrey"><b>비밀번호를 입력해 주세요.</b></td>
				</tr>
				<tr height="30">
					<td align=center bgcolor="white">비밀번호 : 
					<input type="password" name="pass"	size="8" maxlength="12"> 
					</td>
				</tr>
				<tr height="30">
					<td align=center bgcolor="lightgrey">
<%} %>
						<input type="submit" value="글삭제"> 
						<input type="button" value="글목록" onclick="document.location.href= 'mainPage.jsp?pageNum=<%=pageNum%>'">
					</td>
				</tr>
			</table>
		</form>
	</main>
