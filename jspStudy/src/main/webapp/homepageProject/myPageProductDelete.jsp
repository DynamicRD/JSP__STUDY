<%@page import="co.kh.dev.homepageproject.model.ProductsVO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@page import="co.kh.dev.homepageproject.model.BasketDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String num = request.getParameter("num");
String pNum = request.getParameter("pNum");
String amount = request.getParameter("amount");

if(num == null || amount == null || pNum ==null){
%>
<script>
	alert("오류가 발생해서 삭제 실패했습니다");
	history.go(-1);
</script>
<%	
}
int numInt = Integer.parseInt(num);
int pNumInt = Integer.parseInt(pNum);
int amountInt = Integer.parseInt(amount);

BasketDAO bdao = BasketDAO.getInstance();
boolean check = bdao.deleteDB(numInt);

ProductsDAO pdao = ProductsDAO.getInstance();
ProductsVO pvo = new ProductsVO();
pvo.setAmount(amountInt);
pvo.setNum(pNumInt);
boolean check2 =  pdao.updateRecallDB(pvo);


if (check&&check2) {
%>
<script type="text/javascript">
	window.location.href = "mainPage.jsp?flag=myPagePurchaseList"; // 알림창 후 로그인 페이지로 이동
</script>
<%}else{ %>
<script>
	alert("오류가 발생해서 제거 실패했습니다");
	history.go(-1);
</script>
<%
}
%>