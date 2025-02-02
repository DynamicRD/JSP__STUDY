
<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@page import="co.kh.dev.homepageproject.model.MemberVO"%>
<%@page contentType="text/html; charset=UTF-8"%>
<!-- 1. 사용자 정보를 가져온다 -->
<!-- 2. curd -->
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");

MemberVO mvo = new MemberVO();
mvo.setId(id);
MemberDAO mdao = MemberDAO.getInstance();
boolean flag = mdao.selectIdCheck(mvo);
%>

<!-- 3.화면설계 -->
<!DOCTYPE html>
<html>
<head>
<title>ID중복체크</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>
<body>
	<br>
		<div>
<%
			if (flag) {
				out.println(id+"는 이미 존재하는 ID입니다.<br></br>");
			} else {
			out.println(id+"는 사용 가능 합니다.<br></br>");
			}
%>
		<hr>
		<button onClick="javascript:self.close()">닫기</button>
		</div>
</body>
</html>