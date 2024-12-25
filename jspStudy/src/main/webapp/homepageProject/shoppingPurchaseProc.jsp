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
String id = (String)session.getAttribute("id");

if (id ==null || pNum ==null || price== null) {
%>
<script>
	alert("장바구니 등록에 실패했습니다");
	history.go(-1);
</script>
<%
}
bvo.setpNum((Integer.parseInt(pNum)));
bvo.setPrice((Integer.parseInt(price)));
bvo.setName(name);
bvo.setImgUrl(imgUrl);
bvo.setAmount((Integer.parseInt(amount)));
bvo.setId(id);
bvo.setRegDate(new Timestamp(System.currentTimeMillis()));
boolean flag = bdao.insertDB(bvo);
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
%>