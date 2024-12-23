<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="co.kh.dev.login.model.LoginDAO"%>
<%@ page import="co.kh.dev.login.model.LoginVO"%>
<!-- 1.사용자정보 가져옴 -->
<!-- 2. curd -->

	<%
	String message = null;
		boolean successFlag = false;
	if (session != null) {
		String id = (String) session.getAttribute("id");
		LoginDAO ldao = new LoginDAO();
		LoginVO lvo = new LoginVO(id);
			successFlag = 	ldao.deleteLogin(lvo);

		if (successFlag) {
			session.invalidate(); // 세션 무효화
			message = "탈퇴 성공했습니다";
		}else{
			message = "탈퇴 실패했습니다";
		}
	}else{
			message = "세션이 존재하지 않습니다 재로그인하세요";
	}
	%>

	<script>
		alert('<%= message%>');
		window.location.href = 'login_main.jsp'; // 리다이렉트
	</script>
