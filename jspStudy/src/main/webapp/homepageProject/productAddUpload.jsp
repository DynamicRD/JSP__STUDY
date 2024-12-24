<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
//1. 서버에서 업로드 진행해야할 순서(업로드 경로를 적는다)
String uploadPath = request.getRealPath("upload");
//2. 업로드할 최대사이즈를 설정
int size = 10 * 1024 * 1024;
String name = "";
String price = "";
String amount = "";
String tag = "";
String filename1 = "";
String origfilename1 = "";
try {
	//3. MultipartRequest 객체생성을 시키고 매개변수(5개를 )보낸다
	MultipartRequest multiRequest = new MultipartRequest(request, uploadPath, size, "UTF-8", 
	new DefaultFileRenamePolicy());
	name = multiRequest.getParameter("name");
	price = multiRequest.getParameter("price");
	amount = multiRequest.getParameter("amount");
	tag = multiRequest.getParameter("tag");
	//4. Enumeration files = multiRequest.getFileNames();
	Enumeration files = multiRequest.getFileNames();
	String file1 = (String) files.nextElement();	//String file1 = fileName2
	origfilename1 = multiRequest.getOriginalFileName(file1);	//orange.png (사용자가 작명한 이름)
	filename1 = multiRequest.getFilesystemName(file1);	//orange.png (서버에서 저장된 이름)
	
	System.out.println(file1);
	System.out.println(uploadPath);
} catch (Exception e) {
	e.printStackTrace();
}
%>
<html>
<body>
<a href="/jspStudy/upload/<%=filename1%>"> <%=origfilename1%></a>
<img alt="/jspStudy/upload/<%=filename1%>" src="#">
	<%-- <form name="filecheck" action="fileCheck.jsp" method="post">
		<input type="hidden" name="name" value="<%=name%>"> 
		<input type="hidden" name="price" value="<%=price%>"> 
		<input type="hidden" name="amount" value="<%=amount%>"> 
		<input type="hidden" name="tag" value="<%=tag%>"> 
		<input type="hidden" name="filename1" value="<%=filename1%>"> 
		<input type="hidden" name="origfilename1" value="<%=origfilename1%>">
	</form>
	<a href="#" onclick="javascript:filecheck.submit()"> 업로드 확인 및 다운로드
		페이지 이동</a> --%>
</body>
</html>