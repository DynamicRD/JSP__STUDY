<%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
// 1. 페이징기법 -  페이지 사이즈:1페이지에 10개 보이기
int pageSize = 8;
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
int end = (currentPage - 1) * pageSize + 8; //4페이지 끝번호 보여줘 4*10 =>40
String searchCheck = (String)session.getAttribute("shopSearchType");
String searchData = (String)session.getAttribute("shopSearch");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
//4. 해당된 페이지 10개를 가져온다
int number = 0;
ArrayList<ProductsVO> ProductsList = null;
ProductsDAO pdao = ProductsDAO.getInstance();
ProductsVO pvo = new ProductsVO();

if(searchCheck == null){
	searchCheck = "none";
	pvo.setSearchCheck(searchCheck);
	count = pdao.selectCountDB(pvo);//전체 글수
}else if(searchCheck.equals("subject")){
	pvo.setSearchCheck(searchCheck);
	pvo.setName(searchData);
	System.out.println("본문 문제"+"%"+searchData+"%");
	count = pdao.selectCountDB(pvo);//전체 글수
}else if(searchCheck.equals("tag")){
	pvo.setSearchCheck(searchCheck);
	pvo.setTag(searchData);
	count = pdao.selectCountDB(pvo);//전체 글수
}

System.out.println("count = "+count);
if (count > 0) {
	//현재페이지 내용 10개만 가져온다
	ProductsList = pdao.selectStartEndDB(start, end,pvo);
}
//솔직히 좋은방법은 아닌듯
session.setAttribute("shopSearchType",null);
session.setAttribute("shopSearch", null);



//5. 만약 4페이지를 가져왔다면(31~40)을 가져왔따면 NUMBER = 40 전체객수 100 1페이지(100~91) 2페이지(90~81)
number = count - (currentPage - 1) * pageSize;
%>

	<main>
		<br>
		<br>
		<table width="800">
			<tr>
				<td align="right"   class="lightgrey" >
				<a href="mainPage.jsp?flag=shop">목록</a>&nbsp;&nbsp;&nbsp;&nbsp;
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
		<table   width="800" cellpadding="0" cellspacing="0" align="left">
			<tr height="30" align="left">
			<%
			int rowCount = 0;
			for (ProductsVO ppvo : ProductsList) {
				if(rowCount <4){
			%>
				<td width="250"  bgcolor="white"  >
					<a href="mainPage.jsp?num=<%=ppvo.getNum()%>&pageNum=1&flag=product&cPageNum=1"> 
						&nbsp;&nbsp;&nbsp;<img src="<%=ppvo.getImgUrl()%>" alt="" class="shopMenuImg"><br>
<%
						if(ppvo.getAmount() <= 0){
%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ppvo.getName()%>(품절)
<% 
						}else{
%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ppvo.getName()%>
<%
						}
%>
					</a> 
				</td>
				<%
				}  
				if(rowCount == 4){
					%>	
					<tr align="left">
				<%	
				}
				if(rowCount >= 4){
				%>	
					<td width="250"  bgcolor="white"  >
					<a href="mainPage.jsp?num=<%=ppvo.getNum()%>&pageNum=1&flag=product&cPageNum=1"> 
						&nbsp;&nbsp;&nbsp;<img src="<%=ppvo.getImgUrl()%>" alt="" class="shopMenuImg"><br>
<%
						if(ppvo.getAmount() <= 0){
%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ppvo.getName()%>(품절)
<% 
						}else{
%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ppvo.getName()%>
<%
						}
%>
					</a> 
				</td>
				
				<% 	
				}
				rowCount++;
			}
			%>
			</tr>
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
 				<a href="mainPage.jsp?flag=shop&pageNum=<%=startPage-pageBlock%>">[이전]</a>
<%
 				}
 			for (int i = startPage ; i <= endPage ; i++) { 
				if(currentPage == i){
%>					
 				<a href="mainPage.jsp?flag=shop&pageNum=<%= i %>">[[<%= i %>]]</a>
<% 				
				}else{
%>					
 				<a href="mainPage.jsp?flag=shop&pageNum=<%= i %>">[<%= i %>]</a>
<% 				
				}
%>
<%
				}
 			if (endPage < pageCount) { %>
 				<a href="mainPage.jsp?flag=shop&pageNum=<%=startPage+pageBlock%>">[다음]</a>
<%
 				}
 %>
 <% 			
		 }
%>
</div>
<br>
<div>
		<form method="POST" name="searchForm" action="shopSearchProc.jsp">
		<select name="shopSearchType">
            <option value="subject">제목</option>
            <option value="tag">태그</option>
   	</select>
		<input class="search" type="text" name="shopSearch"	size="20" maxlength="20" required="required">
		<input class="search" type="submit" value="검색"> 
		</form>
</div>