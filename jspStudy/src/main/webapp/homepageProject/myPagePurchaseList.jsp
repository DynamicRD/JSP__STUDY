<%@page import="co.kh.dev.homepageproject.model.BasketDAO"%>
<%@page import="co.kh.dev.homepageproject.model.BasketVO"%>
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
String searchCheck = (String)session.getAttribute("searchType");
String searchData = (String)session.getAttribute("search");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
//4. 해당된 페이지 10개를 가져온다
int number = 0;
String id = (String)session.getAttribute("id");
if(id == null){
	id = "none";
}
System.out.println("id = "+ id);
ArrayList<BasketVO> BasketList = null;
BasketDAO bdao = BasketDAO.getInstance();
count = bdao.selectCountDB(id);
System.out.println("count = "+count);
if (count > 0) {
	//현재페이지 내용 10개만 가져온다
	BasketList = bdao.selectIdDB(id);
}
int purchaseSum = 0;
int productPrice = 0;
%>

	<main>
		<b>장바구니목록(전체 상품:<%=count%>)
		</b>
		<table width="800">
			<tr>
				<td align="right"   class="lightgrey" >
				<a href="mainPage.jsp?flag=myPage">뒤로</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
		if (count == 0) {
		%>
		<table width="800"   cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">장바구니에 담긴 상품이 없습니다.</td>
		</table>
		<%
		} else {
		%>
		<table   width="800" cellpadding="0" cellspacing="0"
			align="center">
			<tr height="30">
				<td align="center" width="50"  class="lightgrey" >이미지</td>
				<td align="center" width="150"  class="lightgrey" >상품명</td>
				<td align="center" width="100"  class="lightgrey" >가격</td>
				<td align="center" width="150"  class="lightgrey" >갯수</td>
				<td align="center" width="150"  class="lightgrey" >담은 일자</td>
				<td align="center" width="150"  class="lightgrey" >합계 가격</td>
				<td align="center" width="150"  class="lightgrey" > </td>
			</tr>
			<%
			for (BasketVO bmvo : BasketList) {
				productPrice = bmvo.getPrice() * bmvo.getAmount();
			%>
			<tr height="30">
				<td width="250"  bgcolor="white"  >
					<a href="mainPage.jsp?num=<%=bmvo.getpNum()%>&pageNum=1&flag=product&cPageNum=1">
						<img src="<%=bmvo.getImgUrl()%>" alt="" class="myPageShopImg">
					</a> 	
				</td>
				<td align="center" width="100" bgcolor="white" >
					<a href="mainPage.jsp?num=<%=bmvo.getpNum()%>&pageNum=1&flag=product&cPageNum=1">
						<%=bmvo.getName() %>
					</a> 
				</td>
				<td align="center" width="50" bgcolor="white" ><%=bmvo.getPrice()%></td>
				<td align="center" width="50" bgcolor="white" ><%=bmvo.getAmount()%></td>
				<td align="center" width="150" bgcolor="white" ><%=sdf.format(bmvo.getRegDate())%></td>
				<td align="center" width="100" bgcolor="white" ><%=productPrice%></td>
				<td align="center" width="100" bgcolor="white" >
					<a href="myPageProductDelete.jsp?num=<%=bmvo.getNum()%>&amount=<%=bmvo.getAmount()%>&pNum=<%=bmvo.getpNum()%>">
						장바구니에서 제외하기
					</a>
				</td>
			</tr>
			<%
			purchaseSum += productPrice;
			}
			%>
		</table>
		<%
		}
		%>
	</main>
<br>
<div>
		<form method="POST" name="myPagePurchase" action="myPagePurchaseProc.jsp">
		<input type="hidden" name="totalPrice" value="<%=purchaseSum%>" required="required">
		<input class="search" type="submit" value="<%=purchaseSum%>원 결제하기"> 
		</form>
</div>