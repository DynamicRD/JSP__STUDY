<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*" %>
<%@ page session="true"%>
<%
    // 세션 무효화
    if (session != null) {
        session.invalidate();
    }

    // 로그인 페이지로 샌드리다이렉트
    String loginPage = "login.jsp";
    response.sendRedirect(loginPage);
%>
