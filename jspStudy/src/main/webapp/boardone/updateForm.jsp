<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="co.kh.dev.boardone.model.BoardVO"%>
<%@page import="co.kh.dev.boardone.model.BoardDAO"%>
<%@ include file="view/color.jsp"%>
<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
BoardVO vo = new BoardVO();
vo.setNum(num);
%>
<%
try {
	BoardDAO bdao = BoardDAO.getInstance();
	BoardVO article = bdao.selectBoardOneDB(vo);
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
			action="updateProc.jsp?pageNum=<%=pageNum%>"
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
						<input type="button" value="목록보기" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
					</td>
				</tr>
			</table>
		</form>
	</main>
	<%
	} catch (Exception e) {
	}
	%>
</body>
</html>
