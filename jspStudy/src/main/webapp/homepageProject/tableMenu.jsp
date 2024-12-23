<%@page import="co.kh.dev.homepageproject.model.BoardMemberDAO"%>
<%@page import="co.kh.dev.homepageproject.model.BoardMemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
// 1. 페이징기법 -  페이지 사이즈:1페이지에 10개 보이기
int pageSize = 10;
int count = 0;
// 2. 페이징기법 - 페이지번호 선택
request.setCharacterEncoding("utf-8");
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}
//3. 현재페이지 설정, start, end 
int currentPage = Integer.parseInt(pageNum);
int start = (currentPage - 1) * pageSize + 1; //4페이지 시작보여줘		(4-1)*10+1=>31
int end = (currentPage - 1) * pageSize + 10; //4페이지 끝번호 보여줘 4*10 =>40
String searchCheck = (String)session.getAttribute("searchType");
String searchData = (String)session.getAttribute("search");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
//4. 해당된 페이지 10개를 가져온다
int number = 0;
ArrayList<BoardMemberVO> BoardMemberList = null;
BoardMemberDAO bdao = BoardMemberDAO.getInstance();
BoardMemberVO bmmmvo = new BoardMemberVO();
if(searchCheck == null){
	searchCheck = "none";
	bmmmvo.setSearchCheck(searchCheck);
	count = bdao.selectCountDB(bmmmvo);//전체 글수
}else if(searchCheck.equals("subject")){
	bmmmvo.setSearchCheck(searchCheck);
	bmmmvo.setSubject(searchData);
	System.out.println("본문 문제"+"%"+searchData+"%");
	count = bdao.selectCountDB(bmmmvo);//전체 글수
}else if(searchCheck.equals("writer")){
	bmmmvo.setSearchCheck(searchCheck);
	bmmmvo.setWriter(searchData);
	count = bdao.selectCountDB(bmmmvo);//전체 글수
}else if(searchCheck.equals("content")){
	bmmmvo.setSearchCheck(searchCheck);
	bmmmvo.setContent(searchData);
	count = bdao.selectCountDB(bmmmvo);//전체 글수
}
System.out.println("count = "+count);
if (count > 0) {
	//현재페이지 내용 10개만 가져온다
	BoardMemberList = bdao.selectStartEndDB(start, end,bmmmvo);
}
//솔직히 좋은방법은 아닌듯
session.setAttribute("searchType",null);
session.setAttribute("search", null);



//5. 만약 4페이지를 가져왔다면(31~40)을 가져왔따면 NUMBER = 40 전체객수 100 1페이지(100~91) 2페이지(90~81)
number = count - (currentPage - 1) * pageSize;
%>

	<main>
		<b>글목록(전체 글:<%=count%>)
		</b>
		<table width="800">
			<tr>
				<td align="right"   class="lightgrey" >
				<a href="mainPage.jsp">목록</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="mainPage.jsp?tableflag=write">글쓰기</a>
				</td>
			</tr>
		</table>
		<%
		if (count == 0) {
		%>
		<table width="800"   cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
		</table>
		<%
		} else {
		%>
		<table   width="800" cellpadding="0" cellspacing="0"
			align="center">
			<tr height="30">
				<td align="center" width="50"  class="lightgrey" >번 호</td>
				<td align="center" width="250"  class="lightgrey" >제 목</td>
				<td align="center" width="100"  class="lightgrey" >작성자</td>
				<td align="center" width="150"  class="lightgrey" >작성일</td>
				<td align="center" width="50"  class="lightgrey" >조 회</td>
				<td align="center" width="50"  class="lightgrey" >댓 글</td>
				<td align="center" width="100"  class="lightgrey" >IP</td>
			</tr>
			<%
			for (BoardMemberVO bmvo : BoardMemberList) {
				
			%>
			<tr height="30">
				<td align="center" width="50"  class="lightgrey"><%=number--%></td>
				<td width="250"  bgcolor="white"  >
					<!-- 수정 <5> --> 
					<%-- <a href="content.jsp">  --%>
					<a href="mainPage.jsp?num=<%=bmvo.getNum()%>&pageNum=1&tableflag=select&cPageNum=1"> 
					<!-- 수정<6> -->
					<%
					//6. depth 값에 따라서 5배수 증가를 해서 화면에 보여줘야한다
					//depth : 1 => 길이:5, 2=>10
					int wid = 0;
					if (bmvo.getDepth() > 0) {
						wid = 5 * bmvo.getDepth();
					%>
						<img src="img/level.gif" width="<%=wid%>" height="16">	<!-- 공백 -->
  					<img src="img/re.gif">
						<%
					}
						%>
						<%=bmvo.getSubject()%></a> 
<%
 if (bmvo.getReadcount() >= 20) {
 %> <img src="img/hot.gif" border="0" height="16"> 
 <%
 }
 %>
				</td>
				<td align="center" width="100" bgcolor="white" ><%=bmvo.getWriter()%></td>
				<td align="center" width="150" bgcolor="white" ><%=sdf.format(bmvo.getRegdate())%></td>
				<td align="center" width="50" bgcolor="white" ><%=bmvo.getReadcount()%></td>
				<td align="center" width="50" bgcolor="white" ><%=bmvo.getComments()%></td>
				<td align="center" width="100" bgcolor="white" ><%=bmvo.getIp()%></td>
			</tr>
			<%
			}
			%>
		</table>
		<%
		}
		%>
		<!-- 수정 <7> -->
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
 				<a href="mainPage.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
<%
 				}
 			for (int i = startPage ; i <= endPage ; i++) { 
				if(currentPage == i){
%>					
 				<a href="mainPage.jsp?pageNum=<%= i %>">[[<%= i %>]]</a>
<% 				
				}else{
%>					
 				<a href="mainPage.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<% 				
				}
%>
<%
				}
 			if (endPage < pageCount) { %>
 				<a href="mainPage.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
<%
 				}
 %>
 <% 			
		 }
%>
</div>
<br>
<div>
		<form method="POST" name="searchForm" action="searchProc.jsp">
		<select name="searchType">
            <option value="subject">제목</option>
            <option value="writer">작성자</option>
            <option value="content">내용</option>
   	</select>
		<input class="search" type="text" name="search"	size="20" maxlength="20" required="required">
		<input class="search" type="submit" value="검색"> 
		</form>
</div>