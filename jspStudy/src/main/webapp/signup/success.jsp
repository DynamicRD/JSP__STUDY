<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>환영합니다</title>
</head>
<body>
    <%
    
        String id = (session != null) ? (String) session.getAttribute("id") : null;

        if (id != null) {
    %>
        <h2><%= id %>님, 환영합니다!</h2>
        <a href="logout.jsp">로그아웃</a> 
    <%
        } else {
            response.sendRedirect("login.jsp");
        }
    %>
</body>
</html>
