<%@ page contentType="text/html; charset=UTF-8"%>
<%

if (session != null) {
	session.invalidate();
}

// 로그아웃 완료 메시지 출력
System.out.println("로그아웃 완료");

// 로그인 페이지로 리다이렉트
response.sendRedirect("mainPage.jsp");
%>