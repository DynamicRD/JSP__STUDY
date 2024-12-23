<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.kh.edu.board.model.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="view/color.jsp"%>
<%
int currentPage = (Integer)request.getAttribute("currentPage");
int startRow = (Integer) request.getAttribute("startRow");
int endRow = (Integer) request.getAttribute("endRow");
int count = (Integer) request.getAttribute("count");
int pageSize = (Integer) request.getAttribute("pageSize");
int number = (Integer) request.getAttribute("number");
List<BoardVO> articleList = (List<BoardVO>)request.getAttribute("articleList");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
	<main>
		<b>글목록(전체 글:<%=count%>)
		</b>
		<table width="700">
			<tr>
				<td align="right" bgcolor="<%=value_c%>"><a
					href="writeForm.do">글쓰기</a></td>
			</tr>
		</table>
		<%
		if (count == 0) {
		%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
		</table>
		<%
		} else {
		%>
		<table border="1" width="700" cellpadding="0" cellspacing="0"
			align="center">
			<tr height="30" bgcolor="<%=value_c%>">
				<td align="center" width="50">번 호</td>
				<td align="center" width="250">제 목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
				<td align="center" width="50">조 회</td>
				<td align="center" width="100">IP</td>
			</tr>
			<%
			for (BoardVO article : articleList) {
				
			%>
			<tr height="30">
				<td align="center" width="50"><%=number--%></td>
				<td width="250">
					<!-- 수정 <5> --> 
					<a href="content.do?num=<%=article.getNum()%>&ppageNum=<%=currentPage%>"> 
					<!-- 수정<6> -->
					<%
					//6. depth 값에 따라서 5배수 증가를 해서 화면에 보여줘야한다
					//depth : 1 => 길이:5, 2=>10
					int wid = 0;
					if (article.getDepth() > 0) {
						wid = 5 * article.getDepth();
					%>
						<img src="images/level.gif" width="<%=wid%>" height="16">	<!-- 공백 -->
  					<img src="images/re.gif">
						<%
					}
						%>
						<%=article.getSubject()%></a> 
<%
 if (article.getReadcount() >= 20) {
 %> <img src="images/hot.gif" border="0" height="16"> 
 <%
 }
 %>
				</td>
				<td align="center" width="100"><a
					href="mailto:<%=article.getEmail()%>"> <%=article.getWriter()%></a></td>
				<td align="center" width="150"><%=sdf.format(article.getRegdate())%></td>
				<td align="center" width="50"><%=article.getReadcount()%></td>
				<td align="center" width="100"><%=article.getIp()%></td>
			</tr>
<%
			}
%>
<%
		}
%>
		</table>
</main>
<br>
<div  align="center">
<%
 			if (count > 0) {
 			int pageBlock = 5;
 			int imsi = count % pageSize == 0 ? 0 : 1;
 			int pageCount = count / pageSize + imsi;
 			int startPage = (int)((currentPage-1)/pageBlock)*pageBlock + 1;
 			int endPage = startPage + pageBlock - 1;
 			if (endPage > pageCount) endPage = pageCount;
 			if (startPage > pageBlock) { 
%>
 				<a href="list.do?pageNum=<%=startPage-pageBlock%>">[이전]</a>
<%
 				}
 			for (int i = startPage ; i <= endPage ; i++) { 
				if(currentPage == i){
%>					
 				<a href="list.do?pageNum=<%= i %>">[[<%= i %>]]</a>
<% 				
				}else{
%>					
 				<a href="list.do?pageNum=<%= i %>">[<%= i %>]</a>
<% 				
				}
%>
<%
				}
 			if (endPage < pageCount) { %>
 				<a href="list.do?pageNum=<%=startPage+pageBlock%>">[다음]</a>
<%
 				}
 %>
 <% 			
		 }
%>
</div>
</body>
</html>