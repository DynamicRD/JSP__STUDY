<%@ page contentType="text/html; charset=UTF-8"%>
<%
//새로운 글로 입력(num=0, ref=0, step=0, depth=0)
//부모글에 대한 답변으로 입력(num=부모값, ref=부모값, step=부모값, depth=부모값)
int num = 0, ref = 1, step = 0, depth = 0;
try {
	if (request.getParameter("num") != null) {
		num = Integer.parseInt(request.getParameter("num"));
		ref = Integer.parseInt(request.getParameter("ref"));
		step = Integer.parseInt(request.getParameter("step"));
		depth = Integer.parseInt(request.getParameter("depth"));
	}
%>
	<main>
		<b>글쓰기</b>

	<br></br>
	<form method="post" name="writeForm" action="writeProc.jsp"	onsubmit="return writeSave()">
		<%if(session.getAttribute("id")!=null){%>
				<input type="hidden" size="30" maxlength="30" name="pass" value="<%=session.getAttribute("pass")%>" />
		<%} %>		
		<input type="hidden" name="num" value="<%=num%>"> 
		<input type="hidden" name="ref" value="<%=ref%>"> 
		<input type="hidden" name="step" value="<%=step%>"> 
		<input type="hidden" name="depth" value="<%=depth%>">
		<table width="400"   cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="right" colspan="2"   class="lightgrey" ><a
					href="mainPage.jsp">글목록</a></td>
			</tr>
			<tr>
				<td width="70" align="center"   class="lightgrey" >이름</td>
				<td width="330"  align="left"  bgcolor="white" >
				<%if(session.getAttribute("id")!=null){%>
					<input type="hidden" size="12" maxlength="12" name="writer" value="<%=session.getAttribute("id")%>"/>
					<%=session.getAttribute("id")%>
				<%}else{ %>
					<input type="text" size="12" maxlength="12" name="writer" />
				<%} %>
				</td>
			</tr>
<%-- 	<tr>
				<td width="70" align="center">이메일</td>
				<td width="330"  align="left" >
				<%if(session.getAttribute("id")!=null){%>
						<input type="hidden" size="30" maxlength="30" name="email" value="<%=session.getAttribute("email")%>" />
				<%=session.getAttribute("email")%>
				<%}else{ %>
						<input type="text" size="30" maxlength="30" name="email" />
				<%} %>		
				</td>
			</tr>  --%>
			<tr>
				<td width="70" align="center"   class="lightgrey" >제목</td>
				<td width="330"  bgcolor="white" >
<%
					if (request.getParameter("num") == null) {
%> 				<input type="text" size="50" maxlength="50" name="subject" /> 
<%
 						} else {
%> 
 					<input type="text" size="50" maxlength="50" name="subject" value="[답변]" />
<%
					}
%>
				</td>
			</tr>
			<tr>
				<td width="70" align="center"   class="lightgrey" >내용</td>
				<td width="330"  bgcolor="white" ><textarea name="content" rows="13" cols="50"></textarea>
				</td>
			</tr>
			<%if(session.getAttribute("id")==null){%>
			<tr>
				<td width="70" align="center"   class="lightgrey" >비밀번호</td>
				<td width="330" align="left" bgcolor="white" >
					<input type="password" size="10" maxlength="10" name="pass" />
				</td>
			</tr>
			<%} %>
			<tr>
				<td colspan="2" align="center"  class="lightgrey" ><input
					type="submit" value="글쓰기" /> <input type="reset" value="다시작성" />
					<input type="button" value="목록"
					onClick="window.location='mainPage.jsp'"></td>
			</tr>
		</table>
	</form>
		</main>
	<%
	} catch (Exception e) {
	}
	%>
