<%@page import="co.kh.dev.homepageproject.model.BoardMemberDAO"%>
<%@page import="co.kh.dev.homepageproject.model.BoardMemberVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	BoardMemberVO vo = new BoardMemberVO();
	vo.setNum(num);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
try{
BoardMemberDAO bdao = BoardMemberDAO.getInstance();
BoardMemberVO bvo =  bdao.selectBoardMemberDB(vo);
int _num = vo.getNum();
int ref=bvo.getRef();
int step=bvo.getStep();
int depth=bvo.getDepth();
%>
	<main>
		<br></br>
		<form>
			<table width="700"   cellspacing="0" cellpadding="0"
				 align="center">
				<tr height="30">
					<td align="center" width="75"   class="lightgrey">글번호</td>
					<td align="center" width="100" align="center" bgcolor="white"><%=bvo.getNum()%></td>
					<td align="center" width="75"   class="lightgrey">작성자</td>
					<td align="center" width="125" align="center" bgcolor="white"><%=bvo.getWriter()%></td>
					<td align="center" width="75"   class="lightgrey">작성일</td>
					<td align="center" width="125" align="center" bgcolor="white"><%= sdf.format(bvo.getRegdate())%></td>
					<td align="center" width="75"   class="lightgrey">조회수</td>
					<td align="center" width="50" align="center" bgcolor="white"><%=bvo.getReadcount()%></td>
				<tr height="30">
					<td align="center" width="125"   class="lightgrey">글제목</td>
					<td align="center" width="375" align="center" colspan="7" bgcolor="white"><%=bvo.getSubject()%></td>
				</tr>
				<tr>
    			<td align="center" width="125"   class="lightgrey">글내용</td>
    			<td align="left" width="375" colspan="7" bgcolor="white" style="height: 400px; overflow: auto; vertical-align: top;">
        	<%=bvo.getContent() %>
   			 </td>
				</tr>
				<tr height="30">
					<td colspan="8 align="right"   class="lightgrey">
						<%
    		String sessionId = (String) session.getAttribute("id");  // 회원 id
    		String writer = bvo.getWriter();  // 글쓴이 이름
    		boolean isMember = sessionId != null;  // 회원인지 확인

    		// 글쓴이 이름에서 '(비회원)'이 포함되어 있는지 체크
    		boolean isNonMemberPost = writer.endsWith("(비회원)");
    		boolean isAdmin = writer.endsWith("(관리자)");
				%>

				<%-- 수정 권한 체크 --%>
				<% if (isNonMemberPost || (isMember && sessionId.equals(writer))) { %>
    				<input type="button" value="글수정" onclick="document.location.href='mainPage.jsp?num=<%=_num%>&pageNum=<%=pageNum%>&tableflag=update'">
						&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="button" value="글삭제" onclick="document.location.href='mainPage.jsp?num=<%=_num%>&pageNum=<%=pageNum%>&tableflag=delete&writer=<%=writer%>'">
						&nbsp;&nbsp;&nbsp;&nbsp; <!-- 수정<1> --> 
					<% } 
						if( isMember && sessionId.equals("admin")){
						%>
						<input type="button" value="관리자 권한 삭제" onclick="document.location.href='mainPage.jsp?num=<%=_num%>&pageNum=<%=pageNum%>&tableflag=delete&writer=<%=writer%>'">
						&nbsp;&nbsp;&nbsp;&nbsp; <!-- 수정<1> --> 
						<%
						}
						%>
						<input type="button" value="글목록" onclick="document.location.href='mainPage.jsp?pageNum=<%=pageNum%>'">

					</td>
				</tr>
			</table>
		</form>
	</main>
			<%
 }catch(Exception e){e.printStackTrace();} 
%>
