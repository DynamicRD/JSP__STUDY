<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="view/color.jsp"%>
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
<!DOCTYPE html>
<html>
<head>
<title>My Board</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script src="script.js?timestamp=<%=System.currentTimeMillis()%>">
</script>
</head>
<!--// 나중에 새글 답별글 구분하는 코드 추가 <1> -->
<body bgcolor="<%=bodyback_c%>">
	<main>
		<b>글쓰기</b>
	</main>
	<br></br>
	<form method="post" name="writeForm" action="writeProc.jsp"
		onsubmit="return writeSave()">
		<input type="hidden" name="num" value="<%=num%>"> <input
			type="hidden" name="ref" value="<%=ref%>"> <input
			type="hidden" name="step" value="<%=step%>"> <input
			type="hidden" name="depth" value="<%=depth%>">
		<table width="400" border="1" cellpadding="0" cellspacing="0"
			align="center" bgcolor="<%=bodyback_c%>">
			<tr>
				<td align="right" colspan="2" bgcolor="<%=value_c%>"><a
					href="list.jsp">글목록</a></td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">이름</td>
				<td width="330"><input type="text" size="12" maxlength="12"
					name="writer" /></td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">이메일</td>
				<td width="330"><input type="text" size="30" maxlength="30"
					name="email" /></td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">제목</td>
				<td width="330">
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
				<td width="70" bgcolor="<%=value_c%>" align="center">내용</td>
				<td width="330"><textarea name="content" rows="13" cols="50"></textarea>
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
				<td width="330"><input type="password" size="10" maxlength="10"
					name="pass" /></td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="<%=value_c%>" align="center"><input
					type="submit" value="글쓰기" /> <input type="reset" value="다시작성" />
					<input type="button" value="목록"
					onClick="window.location='list.jsp'"></td>
			</tr>
		</table>
	</form>
	<%
	} catch (Exception e) {
	}
	%>
</body>
</html>