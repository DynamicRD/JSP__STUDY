<%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String sessionId = (String)session.getAttribute("id");
ProductsVO vo = new ProductsVO();
vo.setNum(num);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
try {
	ProductsDAO bdao = ProductsDAO.getInstance();
	ProductsVO bvo = bdao.selectProductsDB(vo);
%>
<main>
	<br></br>
	<form method="POST" name="shoppingPurchaseProc" action="shoppingPurchaseProc.jsp">
		<table width="700" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td rowspan="5" align="center"><img src="<%=bvo.getImgUrl()%>" alt=""
					class="shopProductImg" >
					<input type="hidden" name="productNum" value="<%=bvo.getNum()%>"> 
					<input type="hidden" name="productPrice" value="<%=bvo.getPrice()%>"> 
					<input type="hidden" name="productName" value="<%=bvo.getName()%>"> 
					<input type="hidden" name="productImgUrl" value="<%=bvo.getImgUrl()%>"> 
					<input type="hidden" name="productShopAmount" value="<%=bvo.getAmount()%>"> 
				</td>
				<td align="center"  align="center" bgcolor="white"><%=bvo.getName()%></td>
			</tr>
			<tr>
				<td align="center"  align="center" bgcolor="white"><%=bvo.getPrice()%>원</td>
			</tr>
			<tr>
				<td align="center" align="center" bgcolor="white"><%=bvo.getTag()%></td>
			</tr>
			
			<tr>
				<td align="center"  align="center" bgcolor="white">
				재고:<%=bvo.getAmount()%>
				<br><br><br>
				구매수량 : 
					<select id="number" name="productAmount">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
						<option value="9">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
						<option value="24">24</option>
						<option value="25">25</option>
						<option value="26">26</option>
						<option value="27">27</option>
						<option value="28">28</option>
						<option value="29">29</option>
						<option value="30">30</option>
				</select>
				</td>
			</tr>
			<tr>
				<td align="center"  align="center" bgcolor="white">
<%
 					if (sessionId != null && sessionId.equals("admin")) {
%>
				 관리자 ID 입니다
<%
 					}else if(sessionId != null && bvo.getAmount() <= 0){
%>
					품절되었습니다
<%
 					}else if(sessionId != null){
%>
					<input class="search" type="submit" value="장바구니에 담기"> 
<%
 					}else{
%>				
				 먼저 로그인해주세요.
<%
 					}
%>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left"  align="center" bgcolor="white"><%=bvo.getContent()%></td>
			</tr>
			<tr>
				<td align="right"  class="lightgrey" colspan="2">
<%
 if (sessionId != null && sessionId.equals("admin")) {
 %>
					<input type="button" value="상품 수정"
					onclick="document.location.href='mainPage.jsp?flag=shoppingUpdate&num=<%=bvo.getNum()%>'">
					&nbsp;&nbsp;&nbsp;&nbsp; <!-- 수정<1> --> <input type="button"
					value="상품 삭제" onclick="document.location.href='shoppingDelete.jsp?num=<%=bvo.getNum()%>'">
					&nbsp;&nbsp;&nbsp;&nbsp; <!-- 수정<1> --> <%
 }
 %> <input type="button" value="상품 목록"
					onclick="document.location.href='mainPage.jsp?flag=shop'">
				</td>
			</tr>
		</table>
	</form>
</main>
<%
} catch (Exception e) {
e.printStackTrace();
}
%>
