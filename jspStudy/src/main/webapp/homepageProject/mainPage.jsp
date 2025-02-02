<%@page contentType="text/html; charset=UTF-8"%>

<%
//메인페이지 가운데 페이지 전환플래그
String flag = request.getParameter("flag");
if (flag == null) {
	flag = "none";
}
String tableflag = request.getParameter("tableflag");
if (tableflag == null) {
	tableflag = "none";
}
%>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/regform.css" type="text/css">
<script language="javascript" src="js/hompage.js"></script>
<script language="javascript" src="js/regform.js"></script>
<script src="https://kit.fontawesome.com/de7b35df6f.js" async
	crossorigin="anonymous"></script>

<style>
@charset "UTF-8";

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	display: flex;
	background-color: #f0f2f5; /* 부드러운 회색 배경 */
	text-align: center;
	flex-direction: column;
}

main {
	width: 80%;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
	flex-wrap: wrap;
	justify-content: center;
	align-content: center;
}

.login_table {
	width: 600px;
}

.login_block {
	background-color: #D6F5D6; /* 부드러운 초록색 */
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

TD, SELECT, .search {
	font-size: 14px;
	color: #4B4B4B; /* 차분한 그레이 */
	line-height: 1.6;
	padding: 10px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.search {
	font-size: 14px;
	color: #4B4B4B;
	line-height: 1.4;
	padding: 10px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 4px;
}

ul {
	list-style-type: none;
	display: flex;
	flex-direction: row;
	padding: 10px 0;
}

ul>li {
	margin-right: 20px;
}

.header {
    border: 1px solid #ddd;
    width: 1500px;
    height: 100px;
    display: flex;
    flex-direction: row;
    font-size: 22px;
    text-align: center;
    justify-content: space-between;
    align-items: center;
    padding: 20px 30px;
    background-color: #E5F1F4; /* 차분한 파스텔 블루 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin: 0 auto;
    border-radius: 8px;
    font-family: 'Poppins', sans-serif;
    font-weight: 600;
}

@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

.header ul>li>a {
	display: inline-block;
	width: 180px;
	padding: 12px;
	text-align: center;
	background-color: #F2F6F9; /* 라이트 그레이 */
	border-radius: 4px;
	font-weight: 500;
	color: #333;
	transition: background-color 0.3s;
}

.header ul>li:hover>a {
	background-color: #3498db; /* 세련된 파란색 */
	color: #fff;
}

.dropdown {
    position: relative;
}

div.dropdown-content {
    display: none;
    position: absolute;
    background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
    min-width: 160px;
    z-index: 2;
    box-shadow: 0 8px 16px rgba(66, 68, 90, 0.2);
    border-radius: 8px;
    opacity: 0;
    transform: translateY(-10px);
    transition: opacity 0.3s ease, transform 0.3s ease;
}

div.dropdown-content a {
    display: block;
    padding: 12px;
    color: white;
    text-decoration: none;
    font-weight: 500;
    transition: background-color 0.3s, padding-left 0.3s;
    padding-left: 20px;
}

div.dropdown-content a:hover {
    background-color: rgba(255, 255, 255, 0.2);
    padding-left: 25px;
}

.dropdown:hover .dropdown-content {
    display: block;
    opacity: 1;
    transform: translateY(0);
}

div.slideshow {
	background-color: black;
	height: 465px;
	width: 1500px;
	position: relative;
	margin: 0 auto;
	overflow: hidden;
	border-radius: 8px;
}

div.slideshow_slides {
	position: absolute;
	width: 100%;
	height: 100%;
}

div.slideshow_slides a {
	position: absolute;
	width: 100%;
	height: 100%;
	display: inline-block;
	text-align: center;
}

div.slideshow_slides a img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 8px;
}

div.slideshow_nav a {
	position: absolute;
	left: 50%;
	top: 50%;
	color: white;
	font-size: 62px;
	transform: translateY(-50%);
	opacity: 0.5;
	transition: opacity 0.3s;
}

div.slideshow_nav a:hover {
	opacity: 1;
}

div.slideshow_nav a.prev {
	margin-left: -462px;
}

div.slideshow_nav a.next {
	margin-left: 400px;
}

div.shlideshow_indicator {
	position: absolute;
	bottom: 20px;
	left: 0;
	right: 0;
	text-align: center;
}

div.shlideshow_indicator a {
	display: inline-block;
	color: white;
	padding: 7px;
	font-size: 24px;
	transition: color 0.3s;
}

div.shlideshow_indicator a.active {
	color: #d54909;
}

.tbody {
	display: flex;
	flex-direction: row;
	background-color: #f4f4f4;
	margin: 0 auto;
}

div.left, div.center, div.right {
	border: 1px solid #ddd;
	background-color: #E8F6F3; /* 라이트 민트 그린 */
	padding: 20px;
	border-radius: 8px;
}

div.left {
	width: 300px;
	height: 1000px;
	height: auto;
}

.left .left1 {
	margin: 0 auto;
	border: 1px solid #ddd;
	width: 250px;
	height: auto;
	margin-bottom: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.left .left2, .left .left3 {
	margin: 0 auto;
	border: 1px solid #ddd;
	width: 250px;
	height: auto;
	margin-bottom: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

div.center {
	width: 900px;
	min-height: 1000px;
	height: auto;
}

.maintable {
	margin: 0 auto;
	border: 1px solid #ddd;
	width: 850px;
	height: auto;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.maintable th, tr, td {
	margin: 0 auto;
	border: 1px solid #ddd;
	padding: 5px;
	font-weight: 400;
	color: #333;
}

.maintable .num, .maintable .writer, .maintable .day, .maintable .recommend {
	width: 100px;
}

.maintable .title {
	width: 300px;
}

.maintable .comments {
	width: 50px;
}

.writeForm {
	margin: 20px auto;
	display: flex;
	justify-content: center;
	padding: 10px;
}

.lightgrey {
	background-color: #f1f1f1; /* 부드러운 회색 */
}

.lightgreen {
	background-color: #D1F7E2; /* 연한 초록색 */
}

.shopMenuImg {
	width: 150px;
	height: 200px;
	object-fit: cover;
}

.shopProductImg {
	width: 400px;
	height: 600px;
	object-fit: cover;
}

.myPageShopImg {
	width: 100px;
	height: 150px;
	object-fit: cover;
}

.myPageMenu {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin: 10px 0;
	padding: 15px 20px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

.myPageMenu a {
	color: #333;
	text-decoration: none;
	font-size: 18px;
	font-weight: 500;
	display: inline-flex;
	align-items: center;
	transition: color 0.3s ease;
}

.myPageMenu i {
	font-size: 22px;
	margin-right: 10px;
}

.myPageMenu:hover {
	background-color: #f0f0f0;
	transform: translateY(-3px);
}

.myPageMenu:hover a {
	color: #3498db;
}

.section {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.schedule {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.content {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin: 20px 0;
	display: flex;
	flex-direction: column;
}

.faq {
	margin-top: 20px;
}

.faq h2 {
	font-size: 22px;
	color: #333;
	margin-bottom: 15px;
}

.faq-item {
	margin-bottom: 10px;
	background-color: #f9f9f9;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding: 10px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.faq-item:hover {
	background-color: #f1f1f1;
}

.faq-item .answer {
	display: none;
	margin-top: 10px;
	font-size: 16px;
	color: #555;
}
/* 우측 */
div.right {
	width: 300px;
	min-height: 1000px;
	height: auto;
	margin: 0 auto;
}

.right .login {
	margin: 0 auto;
	border: 1px solid #ddd;
	width: 250px;
	height: auto;
	display: flex;
	flex-direction: row;
	justify-content: center;
	background-color: #A8D8C9; /* 세련된 민트 색상 */
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.login_table {
	margin: 0 auto;
}

.login_block {
	font-size: 14px;
}

.login_block input {
	margin: 10px auto;
	width: 100%;
	padding: 5px;
	font-size: 14px;
	border-radius: 4px;
	border: 1px solid #ddd;
	transition: border-color 0.3s;
}

.login_block input:focus {
	border-color: #3498db; /* 세련된 파란색 */
}

.login tr, td, th {
	border: 1px solid #ddd;
}

.footer {
	margin: 20px auto;
	width: 1400px;
	background-color: #F1E2B7; /* 부드러운 연한 노란색 */
	height: 300px;
	color: white;
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.footer p {
	font-size: 16px;
}

.calendar {
	width: 250px;
	border: 1px solid #ccc;
	border-radius: 8px;
	padding: 10px;
	text-align: center;
	font-family: Arial, sans-serif;
	background-color: #F9FAFB; /* 부드러운 회색 배경 */
}

.calendar h3 {
	margin: 10px 0;
	color: #333; /* 어두운 회색 텍스트 */
}

.calendar table {
	width: 100%;
	border-collapse: collapse;
}

.calendar table th, .calendar table td {
	width: 30px;
	height: 30px;
	text-align: center;
	border: 1px solid #ddd;
	vertical-align: middle;
}

.calendar table th {
	background-color: #E9F1F5; /* 부드러운 파스텔 블루 */
}

.calendar table td {
	background-color: #fff;
}

.calendar .current-day {
	background-color: #ffeb3b; /* 밝은 노란색 */
}

.links-container {
	display: flex;
	justify-content: space-between;
	padding: 10px 20px;
}
</style>

</head>
<body onload="carousel(); inputCheck(); inputCheck2();">
	<div class="header">
		<%@ include file="./dropMenu.jsp"%>
	</div>
	<%@ include file="./carousel.jsp"%>
	<div class="tbody">
		<div class="left">
			공지사항
			<div class="left1">
				<%@ include file="./informs.jsp"%>
			</div>
			<br> <br> 광고1 <a href="#" target="_blank"> <img
				src="/images/ad-1.png" alt="" />
			</a> <br> <br> <br> 광고2 <a href="#" target="_blank"> <img
				src="/images/ad-2.png" alt="" />
			</a>
		</div>
		<div class="center">
			<%if(flag.equals("deleteMember")) { %>
			<%@ include file="./deleteMember.jsp"%>
			<%
			}else if (flag.equals("qna")) {
			%>
			<%@ include file="./qna.jsp"%>
			<%
			} else if (flag.equals("download")) {
			%>
			<%@ include file="./download.jsp"%>
			<%
			} else if (flag.equals("history")) {
			%>
			<%@ include file="./history.jsp"%>
			<%
			} else if (flag.equals("background")) {
			%>
			<%@ include file="./background.jsp"%>
			<%
			} else if (flag.equals("myComment")) {
			%>
			<%@ include file="./commentMenu.jsp"%>
			<%
			} else if (flag.equals("addMoney")) {
			%>
			<%@ include file="./addMoney.jsp"%>
			<%
			} else if (flag.equals("shoppingUpdate")) {
			%>
			<%@ include file="./shoppingUpdate.jsp"%>
			<%
			} else if (flag.equals("myPagePurchaseList")) {
			%>
			<%@ include file="./myPagePurchaseList.jsp"%>
			<%
			} else if (flag.equals("myPage")) {
			%>
			<%@ include file="./myPageMenu.jsp"%>
			<%
			} else if (flag.equals("shop")) {
			%>
			<%@ include file="./shoppingMenu.jsp"%>
			<%
			} else if (flag.equals("regform")) {
			%>
			<%@ include file="./regForm.jsp"%>
			<%
			} else if (flag.equals("newProduct")) {
			%>
			<%@ include file="./productAddForm.jsp"%>
			<%
			//회원정보변경화면을 메인에 띄운다
			} else if (flag.equals("memberChange")) {
			%>
			<%@ include file="./memberChange.jsp"%>
			<%
			//글목록 메인화면 
			} else if (flag.equals("findMemberForm")) {
			%>
			<%@ include file="./findMemberForm.jsp"%>
			<%
			} else if (flag.equals("findPassForm")) {
			%>
			<%@ include file="./findPassForm.jsp"%>
			<%
			} else if (flag.equals("product")) {
			%>
			<%@ include file="./shoppingProduct.jsp"%>
			<%
			} else if (tableflag.equals("none")) {
			%>
			<%@ include file="./tableMenu.jsp"%>
			<%
			//
			} else if (tableflag.equals("write")) {
			%>
			<%@ include file="./writeForm.jsp"%>
			<%
			} else if (tableflag.equals("select")) {
			%>
			<%@ include file="./content.jsp"%>
			<%@ include file="./commentMenu.jsp"%>
			<%
			} else if (tableflag.equals("update")) {
			%>
			<%@ include file="./updateForm.jsp"%>
			<%
			} else if (tableflag.equals("delete")) {
			%>
			<%@ include file="./deleteForm.jsp"%>
			<%
			}
			%>
		</div>

		<!-- 		오른쪽 -->
		<div class="right">
			로그인창
			<div class="login">
				<%
				if (session.getAttribute("id") == null) {
				%>
				<%@ include file="./loginMenu.jsp"%>
				<%
				} else if (session != null) {
				%>
				<%@ include file="./loginComplete.jsp"%>
				<%
				}
				%>
			</div>
			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br> <br>
			<%@ include file="./calendar.jsp"%>


		</div>
	</div>
	<div class="footer">
		<div>
			<ul>
				<li><a href="#">회사소개</a></li>
				<li><a href="#">인재채용</a></li>
				<li><a href="#">제휴제안</a></li>
				<li><a href="#">이용약관</a></li>
				<li><a href="#">개인정보처리방침</a></li>
				<li><a href="#">청소년보호정책</a></li>
				<li><a href="#">회사정책</a></li>
				<li><a href="#">고객센터</a></li>
			</ul>
		</div>
	</div>
</body>
</html>