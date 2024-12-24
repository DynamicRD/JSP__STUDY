<%@page contentType="text/html; charset=UTF-8"%>
	<main >
<form method="post" action="productAddUpload.jsp" name="productAddForm" enctype="multipart/form-data">
    <table>
        <tr>
            <td class="login_table" colspan="2" align="center">물건 입력</td>
        </tr>
        <tr>
            <td>상품명</td>
            <td align="left">
                &nbsp;&nbsp;<input type="text" name="name" required /><span></span>&nbsp;
            </td>
        </tr>
        <tr>
            <td>가격</td>
            <td align="left">&nbsp;&nbsp;<input type="text" name="price" required /><span></span></td>
        </tr>
        <tr>
            <td>재고수량</td>
            <td align="left">&nbsp;&nbsp;<input type="text" name="amount" required /><span></span></td>
        </tr>
        <tr>
            <td>태그</td>
            <td align="left">&nbsp;&nbsp;<input type="text" name="tag" required /><span></span></td>
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
                <input type="submit" value="상품등록" />&nbsp;&nbsp;
                <input type="reset" value="다시입력" />&nbsp;&nbsp;
                <input type="button" onclick="location.href = 'mainPage.jsp?flag=none'" value="뒤로가기">
            </td>
        </tr>
    </table>
</form>
	</main>
