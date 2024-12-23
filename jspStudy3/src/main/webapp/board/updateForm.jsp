<%@page import="com.kh.edu.board.model.BoardVO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="view/color.jsp"%>
<%
	String pageNum = (String)request.getAttribute("pageNum");
	BoardVO article = (BoardVO)request.getAttribute("article");
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="script.js?timestamp=<%=System.currentTimeMillis()%>"></script>
</head>
<body bgcolor="<%=bodyback_c%>">
	<main>
		<b>글수정</b> <br>
		<form method="post" name="writeform"
			action="updatePro.do?pageNum=<%=pageNum%>"
			onsubmit="return writeSave()">
			<input type="hidden" name="num" value="<%=article.getNum()%>">
			<table width="400" border="1" cellspacing="0" cellpadding="0"
				bgcolor="<%=bodyback_c%>" align="center">
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">이 름</td>
					<td align="left" width="330"><input type="text" size="10"
						maxlength="10" name="writer" value="<%=article.getWriter()%>">
					</td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">제 목</td>
					<td align="left" width="330"><input type="text" size="40"
						maxlength="50" name="subject" value="<%=article.getSubject()%>"></td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">Email</td>
					<td align="left" width="330"><input type="text" size="40"
						maxlength="30" name="email" value="<%=article.getEmail()%>"></td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">내 용</td>
					<td align="left" width="330"><textarea name="content"
							rows="13" cols="40">
 <%=article.getContent()%></textarea></td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
					<td align="left" width="330"><input type="password" size="8"
						maxlength="12" name="pass"></td>
				</tr>
				<tr>
					<td colspan=2 bgcolor="<%=value_c%>" align="center">
						<input type="submit" value="글수정"> 
						<input type="reset"	value="다시작성"> 
						<input type="button" value="목록보기" onclick="document.location.href='list.do?pageNum=<%=pageNum%>'">
					</td>
				</tr>
			</table>
		</form>
	</main>
 </body>
</html>
