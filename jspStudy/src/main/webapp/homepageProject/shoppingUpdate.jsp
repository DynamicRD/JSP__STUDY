<%@page import="co.kh.dev.homepageproject.model.ProductsVO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
ProductsDAO pdao = ProductsDAO.getInstance();
ProductsVO pvo = new ProductsVO();
pvo.setNum(num);
pvo = pdao.selectProductsDB(pvo);
%>
	<main >
<form method="post" action="shoppingUpdateProc.jsp?num=<%=num%>" name="productAddForm" enctype="multipart/form-data">
    <table>
        <tr>
            <td class="login_table" colspan="2" align="center">상품 수정</td>
        </tr>
        <tr>
            <td>상품명</td>
            <td align="left">
                &nbsp;&nbsp;<input type="text" name="name" required value="<%=pvo.getName()%>"/><span></span>&nbsp;
            </td>
        </tr>
        <tr>
            <td>가격</td>
            <td align="left">&nbsp;&nbsp;<input type="text" name="price" required value="<%=pvo.getPrice()%>"/><span></span></td>
        </tr>
        <tr>
            <td>재고수량</td>
            <td align="left">&nbsp;&nbsp;<input type="text" name="amount" required value="<%=pvo.getAmount()%>"/><span></span></td>
        </tr>
        <tr>
            <td>설명</td>
            <td align="left">&nbsp;&nbsp;<textarea name="content" rows="13" cols="50" required ">
            <%=pvo.getContent()%>
            </textarea><span></span></td>
        </tr>
        <tr>
            <td>태그</td>
            <td align="left">&nbsp;&nbsp;<input type="text" name="tag" required value="<%=pvo.getTag()%>"/><span></span></td>
        </tr>
        <!-- 이미지 선택 -->
        <tr>
            <td>이미지 선택</td>
            <td align="left">
                &nbsp;&nbsp;<input type="file" name="productImage" accept="image/*" /><span></span>
            </td>
        </tr>
        <!-- ------- -->
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="상품수정" />&nbsp;&nbsp;
                <input type="reset" value="다시입력" />&nbsp;&nbsp;
                <input type="button" onclick="location.href = 'mainPage.jsp?num=<%=num%>&pageNum=1&flag=product&cPageNum=1'" value="뒤로가기">
            </td>
        </tr>
    </table>
</form>
	</main>
