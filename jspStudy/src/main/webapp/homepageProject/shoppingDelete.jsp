<%@page import="co.kh.dev.homepageproject.model.ProductsVO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));


ProductsDAO bdao = ProductsDAO.getInstance();
ProductsVO vo = new ProductsVO();
boolean check = bdao.deleteDB(num);
		if(check){
%>
<script>
	alert("삭제되었습니다");
	window.location.href = "mainPage.jsp?flag=shop";
</script>
	
<%
		}else{
%>
	<script>
		alert("DB처리 실패");
		history.go(-1);	
	</script>
<%
		}
%>