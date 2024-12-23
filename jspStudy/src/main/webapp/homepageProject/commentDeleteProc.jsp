<%@page import="co.kh.dev.homepageproject.model.BoardMemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.BoardMemberDAO"%>
<%@page import="co.kh.dev.homepageproject.model.CommentMemberVO"%>
<%@page import="co.kh.dev.homepageproject.model.CommentMemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String pass = request.getParameter("pass");
String truePass = request.getParameter("truePass");
String returnPage = request.getParameter("returnPage");
String admincheck = (String)session.getAttribute("id");
int deleteNum = Integer.parseInt(request.getParameter("deleteNum"));
%>
<% 
if (pass.equals(truePass) || (session.getAttribute("id")!= null && admincheck.equals("admin"))) {
CommentMemberDAO bdao = CommentMemberDAO.getInstance();
CommentMemberVO vo = new CommentMemberVO();
vo.setNum(deleteNum);
boolean check = bdao.deleteDB(vo);
		if(check){
			int returnPageInt = 0;
			if(returnPage != null){
				returnPageInt = Integer.parseInt(returnPage);
			}
						//댓글 카운트 -1
						BoardMemberDAO bmdao = BoardMemberDAO.getInstance();
						BoardMemberVO bvo = new BoardMemberVO();
						bvo.setNum(returnPageInt);
						bmdao.commentDownDB(bvo);
%>

<script>
	alert("삭제되었습니다");
	location.href = "http://localhost:8080/jspStudy/homepageProject/mainPage.jsp?num=<%=returnPage%>&pageNum=1&tableflag=select&cPageNum=1";
</script>
<%
		}else{
%>
	<script>
		alert("DB처리 실패");
		history.go(-1);
	</script>
<%
		}
} else {
%>
<script>
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
</script>
<%
}
%>