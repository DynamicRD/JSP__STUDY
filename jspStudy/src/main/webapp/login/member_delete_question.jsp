<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<script type="text/javascript">
	window.onload = function() {
		let flag = window.confirm("정말 탈퇴하시겠습니까?");
		if (flag === true) {
			let flag1 = window.confirm("진짜 정말 참말로 탈퇴하시겠습니까?");
			if (flag1 === true) {
				window.location.href = 'member_delete.jsp';
			} else {
				window.location.href = 'login_main.jsp';
			}
		} else {
			window.location.href = 'login_main.jsp';
		}
	};
</script>
</head>
<body>
</body>
</html>