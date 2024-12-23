<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setAttribute("PAGETITLE", "정보보기");
	request.setAttribute("CONTENTPAGE", "info_view.jsp");
	
	RequestDispatcher rd = request.getRequestDispatcher("/temp/template/template.jsp");
	rd.forward(request, response);
%>

<%-- <jsp:forward page="/temp/template/template.jsp">
	<jsp:param name="CONTENTPAGE" value="info_view.jsp" />
</jsp:forward> --%>