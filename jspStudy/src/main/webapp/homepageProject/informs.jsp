<%@page import="java.util.ArrayList"%>
<%@page import="co.kh.dev.homepageproject.model.BoardMemberDAO"%>
<%@page import="co.kh.dev.homepageproject.model.BoardMemberVO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%

request.setCharacterEncoding("utf-8");

// 변수에 admin 접두사 추가
int adminNumber = 0;
ArrayList<BoardMemberVO> adminBoardMemberList = null;
BoardMemberDAO adminBdao = BoardMemberDAO.getInstance();
int adminCount = adminBdao.selectAdminCountDB(); // 전체 글수

if (adminCount > 0) {
    // 현재 페이지 내용 10개만 가져온다
    adminBoardMemberList = adminBdao.selectAdminStartEndDB();
}
%>
<%
if (adminCount == 0) {
%>
<table width="250px"  cellpadding="0" cellspacing="0">
    <tr>
        <td bgcolor="whitegrey" align="center">공지사항이 없습니다.</td>
    </tr>
</table>
<%
} else {
%>
<table width="250px"  cellpadding="0" cellspacing="0" align="center">
<%
for (BoardMemberVO bmvo : adminBoardMemberList) {
%>
    <tr height="30">
        <td bgcolor="white">
            <a href="mainPage.jsp?num=<%=bmvo.getNum()%>&pageNum=1&tableflag=select&cPageNum=1"> 
                <%=bmvo.getSubject()%>
            </a> 
        </td>
    </tr>
<%
}
%>
</table>
<%
}
%>