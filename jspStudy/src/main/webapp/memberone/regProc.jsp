<%@page import="co.kh.dev.memberone.model.StudentDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1.사용자 정보를 가져온다 -->
<!-- 2.curd 한다 -->
<%
request.setCharacterEncoding("utf-8");
StudentDAO sdao = new StudentDAO();
%>
<jsp:useBean id="svo" class="co.kh.dev.memberone.model.StudentVO" />
<jsp:setProperty name="svo" property="*" />
<%
boolean flag = sdao.insertDB(svo);
%>
<!-- 3.화면출력한다 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br></br>
	<main>
		<%
		if (flag) {
			out.println("<b>회원가입을 축하 드립니다.</b><br/>");
			out.println("<a href=login.jsp>로그인</a>");
		} else {
			out.println("<b>다시 입력하여 주십시오.</b><br/>");
			out.println("<a href=regForm.jsp>다시 가입</a>");
		}
		%>
	</main>
</body>
</html>