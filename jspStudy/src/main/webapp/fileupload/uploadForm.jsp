<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<title>파일 업로드 폼</title>
</head>
<body>
<main>
	<form action="processFileUpload.jsp" method="post"
		enctype="multipart/form-data">
		파일1: <input type="file" name="file1"><br> 
		파일2: <input type="file" name="file2"><br> 
		파일3: <input type="file" name="file3"><br> 
		파라미터1: <input type="text" name="param1"><br> 
		파라미터2: <input type="text" name="param2"><br> 
		파라미터3: <input type="text" name="param3"><br> 
		<input type="submit" value="전송">
	</form>
</main>
</body>
</html>