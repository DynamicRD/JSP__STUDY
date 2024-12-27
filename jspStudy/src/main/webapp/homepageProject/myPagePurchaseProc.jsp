<%@page import="co.kh.dev.homepageproject.model.MemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsVO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@page import="co.kh.dev.homepageproject.model.BasketDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String totalPrice = request.getParameter("totalPrice");
String id = (String) session.getAttribute("id");

if (totalPrice == null || id == null) {
%>
<script>
	alert("오류가 발생해서 삭제 실패했습니다");
	window.location.href = "mainPage.jsp?flag=myPagePurchaseList";
	history.go(-1);
</script>
<%
} else {
int totalPriceInt = Integer.parseInt(totalPrice);

MemberDAO mdaoo = MemberDAO.getInstance();
int money = mdaoo.selectMoney(id);

if (money < totalPriceInt) {
%>
<script>
	alert("잔액이 부족합니다!");
	history.go(-1);
  </script>
<%
} else {
MemberVO mvvo = new MemberVO();
mvvo.setId(id);
mvvo.setMoney(totalPriceInt);
boolean check = mdaoo.memberMinusMoney(mvvo);
mvvo = mdaoo.selectOneDB(mvvo);
String add1 = mvvo.getAddress1();
String add2 = mvvo.getAddress2();

BasketDAO bdao = BasketDAO.getInstance();
boolean check2 = bdao.deleteIdDB(id);
if (check && check2) {
%>
<script type="text/javascript">
    var add1 = "<%= add1 %>";
    var add2 = "<%= add2 %>";
    alert(add1 + " " + add2 + "로 상품이 배송시작하였습니다. 구매해주셔서 감사합니다.");
    window.location.href = "mainPage.jsp?flag=myPage"; // 알림창 후 로그인 페이지로 이동
</script>
<%
} else {
%>
<script>
	alert("오류가 발생해서 결제 실패했습니다");
	history.go(-1);
</script>
<%
}
}
}
%>