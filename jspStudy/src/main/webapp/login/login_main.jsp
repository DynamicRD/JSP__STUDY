<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // 세션 객체 가져오기
    session = request.getSession(false);
    String superID = "admin";
%>

<%-- 세션이 없을 경우 로그인 폼 출력 --%>
<% if (session == null) { %>
<html>
<head>
    <style>
        #my_table {
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <form method="post" action="/jspStudy/loginCheck.do">
        <table border="1" width="300" id="my_table">
            <tr>
                <th width="100">아이디</th>
                <td width="200">&nbsp;<input type="text" name="id"></td>
            </tr>
            <tr>
                <th width="100">비번</th>
                <td width="200">&nbsp;<input type="password" name="pass"></td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <input type="button" onclick="location.href='/jspStudy/loginMemberServlet.do'" value="회원가입">
                    <input type="submit" value="로그인">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
<%-- 세션이 있고, 관리자가 로그인한 경우 --%>
<% } else if (session != null && session.getAttribute("id").equals(superID)) { %>
<%
    String id = (String) session.getAttribute("id");
    String pass = (String) session.getAttribute("pass");
    String name = (String) session.getAttribute("name");
%>
<html>
<head>
    <style>
        #my_table {
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <table border="1" width="500" id="my_table">
        <tr>
            <td width="500" align="center">관리자 계정 <?= id ?> 입니다.</td>
        </tr>
        <tr>
            <td width="500" align="center"><?= pass ?> 패스워드입니다.</td>
        </tr>
        <tr>
            <td width="500" align="center"><?= name ?> 이름입니다.</td>
        </tr>
        <tr>
            <td align="center">
                <input type="button" onclick="location.href='/jspStudy/loginMemberList.do'" value="회원들 정보">
                <input type="button" onclick="location.href='/jspStudy/logoutServlet.do'" value="로그아웃">
            </td>
        </tr>
    </table>
</body>
</html>
<%-- 세션이 있고, 일반 사용자가 로그인한 경우 --%>
<% } else if (session != null) { %>
<%
    String id = (String) session.getAttribute("id");
    String pass = (String) session.getAttribute("pass");
    String name = (String) session.getAttribute("name");
%>
<html>
<head>
    <style>
        #my_table {
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <table border="1" width="500" id="my_table">
        <tr>
            <td width="500" align="center"><?= id ?> 님 로그인 되었습니다.</td>
        </tr>
        <tr>
            <td width="500" align="center"><?= pass ?> 패스워드입니다.</td>
        </tr>
        <tr>
            <td width="500" align="center"><?= name ?> 이름입니다.</td>
        </tr>
        <tr>
            <td align="center">
                <input type="button" onclick="location.href='/jspStudy/loginMemberChange.do'" value="회원정보변경">
                <input type="button" onclick="location.href='/jspStudy/logoutServlet.do'" value="로그아웃">
                <input type="button" onclick="location.href='/jspStudy/memberReallyDelete.do'" value="탈퇴하기">
            </td>
        </tr>
    </table>
</body>
</html>
<% } %>