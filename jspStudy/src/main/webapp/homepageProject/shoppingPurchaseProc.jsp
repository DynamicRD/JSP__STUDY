<%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="co.kh.dev.homepageproject.model.BasketVO"%>
<%@page import="co.kh.dev.homepageproject.model.BasketDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
BasketDAO bdao = BasketDAO.getInstance();
BasketVO bvo = new BasketVO();
String pNum = request.getParameter("productNum");
String price = request.getParameter("productPrice");
String name = request.getParameter("productName");
String imgUrl = request.getParameter("productImgUrl");
String amount = request.getParameter("productAmount");
String shopAmount = request.getParameter("productShopAmount");
String id = (String)session.getAttribute("id");

if (id ==null || pNum ==null || price== null) {
%>
<script>
	alert("장바구니 등록에 실패했습니다");
	history.go(-1);
</script>
<%
}else if( (Integer.parseInt(shopAmount))<(Integer.parseInt(amount))){
%>
<script>
	alert("구매하시려는 양이 재고보다 많습니다");
	history.go(-1);
</script>
<% 	
}else{
bvo.setpNum((Integer.parseInt(pNum)));
bvo.setPrice((Integer.parseInt(price)));
bvo.setName(name);
bvo.setImgUrl(imgUrl);
bvo.setAmount((Integer.parseInt(amount)));
bvo.setId(id);
bvo.setRegDate(new Timestamp(System.currentTimeMillis()));
boolean flag = bdao.insertDB(bvo);

ProductsDAO pdao = ProductsDAO.getInstance();
boolean purchaseFlag = pdao.updatePurchaseDB((Integer.parseInt(amount)), (Integer.parseInt(pNum)));
%>
<!-- 3.화면출력한다 -->
<%
if (flag) {
%>
<script type="text/javascript">
	alert("성공적으로 장바구니에 등록했습니다.");
	window.location.href = "mainPage.jsp?flag=shop"; // 알림창 후 로그인 페이지로 이동
</script>
<%
} else {
%>
<script>
	alert("장바구니 등록에 실패했습니다");
	history.go(-1);
</script>
<%
}
}
%>