<%@page contentType="text/html; charset=UTF-8"%>
<main>
<form method="post" action="deleteMemberProc.jsp" name="memberDeleteProc">
    <table>
        <tr>
            <td class="login_table" colspan="2" align="center">회원탈퇴</td>
        </tr>
        <tr>
            <td>비밀번호를 입력해주세요</td>
            <td align="center">
               <input type="password" name="pass" required />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="탈퇴하기" />&nbsp;&nbsp;
                <input type="reset" value="다시입력" />&nbsp;&nbsp;
                <input type="button" onclick="location.href = 'mainPage.jsp?flag=myPage'" value="뒤로가기">
            </td>
        </tr>
    </table>
</form>
	</main>
