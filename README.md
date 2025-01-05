# HomePage-Project
자바 + Oracle SQL + Tomcat 개인 홈페이지


## 🏠 프로젝트 소개
로그인, 게시판, 웹쇼핑 기능을 구현한 홈페이지

## 🕰️ 개발 기간
24.12.12목 - 24.12.29일


### ⚙️ 개발 환경
- `Java`
- `JDK-21.0.4`
- `Tomcat 9.0 Server`
- **IDE** : Eclipse
- **Database**: Oracle DB (23c Express Edition)
- **SQL Developer**: Version 23.1


### 📌 기능
- 회원가입 및 로그인 기능
- 아이디, 비밀번호 검색 기능
- 비회원, 회원, 관리자에 따른 차등 권한
- 게시판 글 및 댓글 작성 기능
- 댓글 답변형 기능 탑재
- 홈쇼핑 상품 등록, 구매, 장바구니 기능
- 게시판 및 홈쇼핑 검색기능
- 마이페이지에서 개인 기록 추적,수정 가능
- 자바를 이용한 달력
- 일정 시간마다 이미지 전환기능



### ⌨ 주요 구현 기능

** 이미지 슬라이드쇼**
<details>
<summary>- 일정 시간마다 이미지가 전환되고 버튼을 눌러서 원하는대로 이미지 전환이 가능한 슬라이드쇼</summary>
```javascript
  function carousel(){
    //화면객체 가져온다.
    let slideshow = document.querySelector(".slideshow");
    let slideshow_slides = document.querySelector(".slideshow_slides");
    let slidesArray = document.querySelectorAll(".slideshow_slides a");
    let prev = document.querySelector(".prev");
    let next = document.querySelector(".next");
    let indicatorArray = document.querySelectorAll(".shlideshow_indicator a");
 
    //현재이미지 인덱스, 인터벌아이디, 슬라이드갯수
    let currentIndex = 0; 
    let timerID = null; 
    let slideCount = slidesArray.length;
    
    //현재이미지를 한줄로 정렬한다.
    for(let i=0; i<slideCount; i++){
     let newLeft = `${i*100}%`;
     slidesArray[i].style.left = newLeft; 
    }
 
    //화면전환해주는 함수
    function gotoslide(index){
     currentIndex = index;
     let newLeft = `${index* -100}%`;
     slideshow_slides.style.left = newLeft;
     
     //indicater 그 위치를 가르켜줘야 한다. 
     for(let i=0;i<slideCount;i++){
         indicatorArray[i].classList.remove('active');
     }
     indicatorArray[index].classList.add('active');
    } //end of gotoslide
 
    
 
    //3초마다 gotoslide() 불러주자. 
    //불러주되, index 0,1,2,3,0,1,..
    function startTimer(){
     timerID = setInterval(()=>{
         let index = (currentIndex + 1) % slideCount;
         currentIndex = index; 
         gotoslide(index);  
     }, 3000); 
    }
    startTimer(); 
 
    //이벤트등록 핸들러기능
    slideshow_slides.addEventListener("mouseenter", (event)=>{
     clearInterval(timerID);
    });
    
    slideshow_slides.addEventListener("mouseleave", (event)=>{
     startTimer();
    });
    
    prev.addEventListener("mouseenter", (event)=>{
     clearInterval(timerID);
    });
    prev.addEventListener("mouseleave", (event)=>{
     startTimer();
    });
 
    next.addEventListener("mouseenter", (event)=>{
     clearInterval(timerID);
    });
    next.addEventListener("mouseleave", (event)=>{
     startTimer();
    });
 
    prev.addEventListener("click", (event)=>{
         event.preventDefault(); 
         currentIndex = currentIndex - 1; 
         if(currentIndex < 0){
             currentIndex = slideCount -1; 
         }
         gotoslide(currentIndex);
    });
    
    next.addEventListener("click", (event)=>{
         event.preventDefault();  
         currentIndex = currentIndex + 1; 
         if(currentIndex > (slideCount -1)){
             currentIndex = 0; 
         }
         gotoslide(currentIndex);
    });

    indicatorArray.forEach((obj)=>{
     obj.addEventListener("mouseenter",(event)=>{
         clearInterval(timerID);
     });
    });
 
    indicatorArray.forEach((obj)=>{
     obj.addEventListener("mouseleave",(event)=>{
         startTimer();
     });
    });

    indicatorArray.forEach((obj,index)=>{
     obj.addEventListener("click",(event)=>{
         event.preventDefault();
         gotoslide(index);
     });
    });
 }
</details> 
```
    
- ** 답변형 댓글 게시판**
  - num,step,depth,ref를 활용한을 활용하여 답변한 위치에 따라 댓글의 순서와 위치가 달라지는 댓글작성DAO
```java
  private final String SELECT_START_END_BNUM_SQL = " select * from "
		+ "(select rownum AS rnum, num,numref,b_num, writer, pass, regdate, ref, step, depth, content, ip "
		+ "from (select * from CommentMember order by ref desc, step desc)) where numref>=? and numref<=? and b_num = ?";
  private final String SELECT_MAX_NUM_SQL = "select max(numref) as numref from CommentMember where b_num = ?";
  private final String SELECT_MAX_STEP_SQL = "select max(step) as step from CommentMember where b_num = ? and ref =?";
  private final String INSERT_SQL = "insert into CommentMember(num,numref,b_num, writer, pass, regdate, ref, step, depth, content, ip)       
    values(commentmember_SEQ.nextval,?,?,?,?,?,?,?,?,?,?)";
    
  public Boolean insertDB(CommentMemberVO vo) throws SQLException {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number = 0;
		int step = 0;
		int depth = 0;
		int ref = 1;
		int count = 0;
		int bcount = 0;
		int highstep =0;
		try {
			pstmt = con.prepareStatement(SELECT_COUNT_BNUM_SQL);
			pstmt.setInt(1, vo.getBnum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bcount = rs.getInt("count")+1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		// num 현재 보드속에 가장최고값에 +1, 값이 하나도 없으면 1
		try {
			pstmt = con.prepareStatement(SELECT_MAX_NUM_SQL);
			pstmt.setInt(1, vo.getBnum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number = bcount;
			} else {
				number = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 답변글일경우
		if (vo.getNum() != 0) {
			try {
				pstmt = con.prepareStatement(SELECT_MAX_STEP_SQL);
				pstmt.setInt(1, vo.getBnum());
				pstmt.setInt(2, vo.getRef());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					highstep = rs.getInt("step");
				} else {
					highstep = 1;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			ref = vo.getRef();
			step = highstep + 1;
			depth = vo.getDepth() + 1;
		} else {// 새 글일 경우
			ref = number; // 가장 최고값+1
			step = 0;
			depth = 0;
		} // 쿼리를 작성
  
		// 게시판글 등록하기
		try {
			pstmt = con.prepareStatement(INSERT_SQL);
			pstmt.setInt(1, bcount);
			pstmt.setInt(2, vo.getBnum());
			pstmt.setString(3, vo.getWriter());
			pstmt.setString(4, vo.getPass());
			pstmt.setTimestamp(5, vo.getRegdate());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, step);
			pstmt.setInt(8, depth);
			pstmt.setString(9, vo.getContent());
			pstmt.setString(10, vo.getIp());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt,rs);
		}
		return (count > 0) ? true : false;
	}
```

- ** 쇼핑몰 상품 출력**
  - 가로 최대 4개, 세로2개 최대 8개씩 상품을 출력하고 9개 이상부턴 페이지 이동으로 다른 상품을 출력가능하며 제목과 태그에 따라 검색이 가능한 홈쇼핑 페이지
```jsp
  <%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
// 1. 페이징기법 -  페이지 사이즈:1페이지에 10개 보이기
int pageSize = 8;
int count = 0;
// 2. 페이징기법 - 페이지번호 선택
request.setCharacterEncoding("utf-8");
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}
//3. 현재페이지 설정, start, end 
int currentPage = Integer.parseInt(pageNum);
int start = (currentPage - 1) * pageSize + 1; //4페이지 시작보여줘		(4-1)*10+1=>31
int end = (currentPage - 1) * pageSize + 8; //4페이지 끝번호 보여줘 4*10 =>40
String searchCheck = (String)session.getAttribute("shopSearchType");
String searchData = (String)session.getAttribute("shopSearch");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
//4. 해당된 페이지 10개를 가져온다
int number = 0;
ArrayList<ProductsVO> ProductsList = null;
ProductsDAO pdao = ProductsDAO.getInstance();
ProductsVO pvo = new ProductsVO();

if(searchCheck == null){
	searchCheck = "none";
	pvo.setSearchCheck(searchCheck);
	count = pdao.selectCountDB(pvo);//전체 글수
}else if(searchCheck.equals("subject")){
	pvo.setSearchCheck(searchCheck);
	pvo.setName(searchData);
	System.out.println("본문 문제"+"%"+searchData+"%");
	count = pdao.selectCountDB(pvo);//전체 글수
}else if(searchCheck.equals("tag")){
	pvo.setSearchCheck(searchCheck);
	pvo.setTag(searchData);
	count = pdao.selectCountDB(pvo);//전체 글수
}

System.out.println("count = "+count);
if (count > 0) {
	//현재페이지 내용 10개만 가져온다
	ProductsList = pdao.selectStartEndDB(start, end,pvo);
}

number = count - (currentPage - 1) * pageSize;
%>

	<main>
		<br>
		<br>
		<table width="800">
			<tr>
				<td align="right"   class="lightgrey" >
				<a href="mainPage.jsp?flag=shop">목록</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
		if (count == 0) {
		%>
		<table width="800"   cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
		</table>
		<%
		} else {
		%>
		<table   width="800" cellpadding="0" cellspacing="0" align="left">
			<tr height="30" align="left">
			<%
			int rowCount = 0;
			for (ProductsVO ppvo : ProductsList) {
				if(rowCount <4){
			%>
				<td width="250"  bgcolor="white"  >
					<a href="mainPage.jsp?num=<%=ppvo.getNum()%>&pageNum=1&flag=product&cPageNum=1"> 
						&nbsp;&nbsp;&nbsp;<img src="<%=ppvo.getImgUrl()%>" alt="" class="shopMenuImg"><br>
<%
						if(ppvo.getAmount() <= 0){
%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ppvo.getName()%>(품절)
<% 
						}else{
%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ppvo.getName()%>
<%
						}
%>
					</a> 
				</td>
				<%
				}  
				if(rowCount == 4){
					%>	
					<tr align="left">
				<%	
				}
				if(rowCount >= 4){
				%>	
					<td width="250"  bgcolor="white"  >
					<a href="mainPage.jsp?num=<%=ppvo.getNum()%>&pageNum=1&flag=product&cPageNum=1"> 
						&nbsp;&nbsp;&nbsp;<img src="<%=ppvo.getImgUrl()%>" alt="" class="shopMenuImg"><br>
<%
						if(ppvo.getAmount() <= 0){
%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ppvo.getName()%>(품절)
<% 
						}else{
%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ppvo.getName()%>
<%
						}
%>
					</a> 
				</td>
				
				<% 	
				}
				rowCount++;
			}
			%>
			</tr>
		</table>
		<%
		}
		%>
	</main>
	<br>
<div  align="center">
<%
 			if (count > 0) {
 			int pageBlock = 5;
 			int imsi = count % pageSize == 0 ? 0 : 1;
 			int pageCount = count / pageSize + imsi;
 			int startPage = (int)((currentPage-1)/pageBlock)*pageBlock + 1;
 			int endPage = startPage + pageBlock - 1;
 			if (endPage > pageCount) endPage = pageCount;
 			if (startPage > pageBlock) { 
%>
 				<a href="mainPage.jsp?flag=shop&pageNum=<%=startPage-pageBlock%>">[이전]</a>
<%
 				}
 			for (int i = startPage ; i <= endPage ; i++) { 
				if(currentPage == i){
%>					
 				<a href="mainPage.jsp?flag=shop&pageNum=<%= i %>">[[<%= i %>]]</a>
<% 				
				}else{
%>					
 				<a href="mainPage.jsp?flag=shop&pageNum=<%= i %>">[<%= i %>]</a>
<% 				
				}
%>
<%
				}
 			if (endPage < pageCount) { %>
 				<a href="mainPage.jsp?flag=shop&pageNum=<%=startPage+pageBlock%>">[다음]</a>
<%
 				}
 %>
 <% 			
		 }
%>
</div>
<br>
<div>
		<form method="POST" name="searchForm" action="shopSearchProc.jsp">
		<select name="shopSearchType">
            <option value="subject">제목</option>
            <option value="tag">태그</option>
   	</select>
		<input class="search" type="text" name="shopSearch"	size="20" maxlength="20" required="required">
		<input class="search" type="submit" value="검색"> 
		</form>
</div>
```
   
 - ** 장바구니 처리 PROCEDURE**
  - 현재 로그인세션의 유무, 잔액, DB오류등을 체크해서 성공시 사용자의 금액을 줄이고 회원가입시 입력했던 주소로 상품배송하는 PROCEDURE
```jsp
<%@page import="co.kh.dev.homepageproject.model.MemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.MemberDAO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsVO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@page import="co.kh.dev.homepageproject.model.BasketDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String totalPrice = request.getParameter("totalPrice");
String id = (String) session.getAttribute("id");

if (totalPrice == null || id == null) {
%>
<script>
	alert("세션이 초기화되어 결재 실패했습니다");
	window.location.href = "mainPage.jsp?flag=myPagePurchaseList";
	history.go(-1);
</script>
<%
} else {
int totalPriceInt = Integer.parseInt(totalPrice);

MemberDAO mdaoo = MemberDAO.getInstance();
int money = mdaoo.selectMoney(id);

if (money < totalPriceInt) {
%>
<script>
	alert("잔액이 부족합니다!");
	history.go(-1);
  </script>
<%
} else {
MemberVO mvvo = new MemberVO();
mvvo.setId(id);
mvvo.setMoney(totalPriceInt);
boolean check = mdaoo.memberMinusMoney(mvvo);
mvvo = mdaoo.selectOneDB(mvvo);
String add1 = mvvo.getAddress1();
String add2 = mvvo.getAddress2();

BasketDAO bdao = BasketDAO.getInstance();
boolean check2 = bdao.deleteIdDB(id);
if (check && check2) {
%>
<script type="text/javascript">
    var add1 = "<%= add1 %>";
    var add2 = "<%= add2 %>";
    alert(add1 + " " + add2 + "로 상품이 배송시작하였습니다. 구매해주셔서 감사합니다.");
    window.location.href = "mainPage.jsp?flag=myPage"; // 알림창 후 로그인 페이지로 이동
</script>
<%
} else {
%>
<script>
	alert("오류가 발생해서 결제 실패했습니다");
	history.go(-1);
</script>
<%
}
}
}
%>
```   


### 📊 ERD 다이어그램


### 💻 실행 화면
