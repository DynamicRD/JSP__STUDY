<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>여기서 아래에 있는 멤버변수를 쓸것이다. <%= declation %></h1>
	<h1>여기서 아래에 있는 멤버함수를 콜할수 있다. <%= getDeclation() %></h1>
	<h1>연산처리</h1>
	<%
		//여기에 몇가지 객체가 있을까? 
		//내장객체: context,config,request,reponse,pageContext,Session,out,page
		//자바연산처리(제어문,반복문): 서비스에서 진행이 된다.
		String message = "연산처리문입니다. "; //message : 지역변수(서비스에있는)
		out.println("내장객체를 이용한 출력"+message);
	%>
	<h1>멤버변수선언</h1>
	<%!
		//멤버변수선언
		String declation = "멤버변수 선언문입니다.";
	%>
	<h1>멤버함수선언</h1>
	<%!
		//멤버변수선언
		public String getDeclation(){
			return declation;
	};
	%>
</body>
</html>