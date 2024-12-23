<%@page import="java.util.Collections"%>
<%@page import="java.util.Collection"%>
<%@page import="co.kh.dev.homepageproject.model.CommentMemberDAO"%>
<%@page import="co.kh.dev.homepageproject.model.CommentMemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
// 1. 페이징기법 - 페이지 사이즈:1페이지에 10개 보이기
int cPageSize = 10;
// 2. 페이징기법 - 페이지번호 선택
request.setCharacterEncoding("utf-8");
String cPageNum = request.getParameter("cPageNum");
if (cPageNum == null) {
    cPageNum = "1";
}
String comment = request.getParameter("comment");
if (comment == null) {
		comment = "no";
}
// 3. 현재페이지 설정, start, end 
int cCurrentPage = Integer.parseInt(cPageNum);
int cStart = (cCurrentPage - 1) * cPageSize +1 ; // 4페이지 시작보여줘 (4-1)*10+1=>31
int cEnd = (cCurrentPage - 1) * cPageSize + 10; // 4페이지 끝번호 보여줘 4*10 =>40
//게시판 목록의 번호를 받아온다
int numInt = 0;
int commentNum = -1;
if(request.getParameter("num") != null){
numInt = Integer.parseInt(request.getParameter("num"));
}
if(request.getParameter("commentNum") != null){
	commentNum = Integer.parseInt(request.getParameter("commentNum"));
}

SimpleDateFormat cSdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
//---------여까지 이상 없음
// 4. 해당된 페이지 10개를 가져온다
int cNumber = 0;
ArrayList<CommentMemberVO> cCommentMemberList = null;
CommentMemberDAO cBdao = CommentMemberDAO.getInstance();

//현재페이지의 댓글 개수 가져온다
CommentMemberVO cccmvo = new CommentMemberVO();
cccmvo.setBnum(numInt);
int cCount = cBdao.selectCountDB(cccmvo); // 전체 글수

 if (cCount > 0) {
    // 현재페이지 내용 10개만 가져온다
    // 현재 페이지의 내용만 가져온다
    cCommentMemberList = cBdao.selectStartEndDB(cStart, cEnd,numInt);
    Collections.reverse(cCommentMemberList);
}
// 5. 만약 4페이지를 가져왔다면(31~40)을 가져왔다면 NUMBER = 40 전체객수 100 1페이지(100~91) 2페이지(90~81)
cNumber = (cCurrentPage - 1) * cPageSize +1;
%>

    <main>
        <b>댓글(전체 댓글수:<%=cCount%>)
        </b>
        <%
        if (cCount == 0) {
        %>
        <table width="600"   cellpadding="0" cellspacing="0">
            <tr>
                <td align="center"  class="lightgrey">댓글이 없습니다.</td>
        </table>
        <%
        } else {
        %>
        <table   width="600" cellpadding="0" cellspacing="0"
            align="center">
            <%
            for (CommentMemberVO cmvo : cCommentMemberList) {
                cmvo.toString();
            %>
            <tr height="30">
            	<%if(cmvo.getStep()==0){ %>
                <td align="center" width="50"  class="lightgrey"><%=cNumber++%></td>
                <td align="center" width="100"  class="lightgrey"><%=cmvo.getWriter()%></td>
                <td align="center" width="100"  class="lightgrey"><%=cmvo.getIp()%></td>
                <td align="center" width="150"  class="lightgrey"><%=cSdf.format(cmvo.getRegdate())%></td>
                <td align="center" width="50"  class="lightgrey">
                	<input type="button" value="답변" onclick="document.location.href='mainPage.jsp?num=<%=numInt %>&pageNum=1&tableflag=select&cPageNum=1&comment=yes&commentNum=<%=cNumber%>'">
								</td>
								<td align="center" width="100"  class="lightgrey">
                <%}else{ %>
                <td align="center" width="50"  class="lightgreen"><%=cNumber++%></td>
                <td align="center" width="100"  class="lightgreen"><%=cmvo.getWriter()%></td>
                <td align="center" width="100"  class="lightgreen"><%=cmvo.getIp()%></td>
                <td align="center" width="150"  class="lightgreen"><%=cSdf.format(cmvo.getRegdate())%></td>
                <td align="center" width="50"  class="lightgreen">
                	<input type="button" value="답변" onclick="document.location.href='mainPage.jsp?num=<%=numInt %>&pageNum=1&tableflag=select&cPageNum=1&comment=yes&commentNum=<%=cNumber%>'">
								</td>
								<td align="center" width="100"  class="lightgreen">
                <%} %>
										<form method="post" name="cDeleteForm" action="commentDeleteProc.jsp">
											<input type="hidden" name="truePass" value="<%=cmvo.getPass() %>" />
											<input type="hidden" name="returnPage" value="<%=numInt%>" />
											<input type="hidden" name="deleteNum" value="<%=cmvo.getNum() %>" />
											<%
												if(session.getAttribute("id")!=null && ((String)(session.getAttribute("id"))).equals("admin")){
											%>
											<input type="submit" value="관리자 권한삭제" />
											<%}else{ %>
											<input type="password" name="pass" placeholder="패스워드" style="width: 80%;" />
											<input type="submit" value="삭제하기" />
											<%}%>
										</form>
								</td>		
            </tr>
            <tr>
                <td width="250" colspan="6" bgcolor="white" align="left">
                    <%
                    // 6. depth 값에 따라서 5배수 증가를 해서 화면에 보여줘야한다
                    // depth : 1 => 길이:5, 2=>10
                    int cWid = 0;
                    if (cmvo.getDepth() > 0) {
                        cWid = 5 * cmvo.getDepth();
                    %>
                        <img src="img/level.gif" width="<%=cWid%>" height="16">    <!-- 공백 -->
                        <img src="img/re.gif">
                        <%
                    }
                        %>
                        <%=cmvo.getContent()%></a> 
                </td>
            </tr>
            
            <%
						//댓글 바로아래 다는 기능            
            if(comment.equals("yes")&&cNumber==commentNum){
            	 // 새로운 글로 입력(num=0, ref=0, step=0, depth=0)
            	 // 부모글에 대한 답변으로 입력(num=부모값, ref=부모값, step=부모값, depth=부모값)
            	/*  int cNum = 0, cRef = 1, cStep = 0, cDepth = 0; */
            	 
            	     if (request.getParameter("cNum") != null) {
            	        /*  cNum = Integer.parseInt(request.getParameter("cNum"));
            	         cRef = Integer.parseInt(request.getParameter("cRef"));
            	         cStep = Integer.parseInt(request.getParameter("cStep"));
            	         cDepth = Integer.parseInt(request.getParameter("cDepth")); */
            	     }
            	%>
            	
            	    <form method="post" name="cWriteForm" action="commentWriteProc.jsp?commentPage=<%=numInt%>" onsubmit="return writeSave()">
            	        <%if(session.getAttribute("id")!=null){%>
            	            <input type="hidden" size="30" maxlength="30" name="cPass" value="<%=session.getAttribute("pass")%>" />
            	        <%} %>        
            	        	<input type="hidden" name="cNum" value="1"> 
            	        	<input type="hidden" name="checkNum" value="1"> 
            	        	<input type="hidden" name="cRef" value="<%=cmvo.getRef()%>"> 
            	        	<input type="hidden" name="cStep" value="<%=cmvo.getStep()%>"> 
            	        	<input type="hidden" name="cDepth" value="<%=cmvo.getDepth()%>">
            	            <tr>
            	                <td align="center" bgcolor="#9FF781">이름</td>
            	                <td align="left"  bgcolor="#E0F8E0">
            	                <%if(session.getAttribute("id")!=null){%>
            	                    <input type="hidden" size="12" maxlength="12" name="cWriter" value="<%=session.getAttribute("id")%>"/>
            	                    <%=session.getAttribute("id")%>
            	                <%}else{ %>
            	                    <input type="text" size="12" maxlength="12" name="cWriter" />
            	                <%} %>
            	                </td>
            	                <td align="center" bgcolor="#9FF781">비밀번호</td>
            	                <td  align="left"  bgcolor="#E0F8E0">
            	                  <%if(session.getAttribute("id")==null){%>
            	                    <input type="password" size="10" maxlength="10" name="cPass" />
            	                   <%} %>        
            	                </td>
            	                <td colspan="2" align="center" bgcolor="#9FF781">
            	                    <input type="submit" value="댓글쓰기" /> 
            	                    <input type="reset" value="다시작성" />
            	                </td>
            	            </tr>
            	            <tr>
            	                <td align="center" bgcolor="#9FF781">내용</td>
            	                <td  align="left" colspan="5" bgcolor="#E0F8E0">
            	                    <textarea name="cContent" cols="60"></textarea>
            	                </td>
            	            </tr>
            	    </form>
            	<%
            
            	%>
<% 
            }
%>
            
            
<%
            }
        }
%>
        </table>


<div  align="center">
<%
            if (cCount > 0) {
            int cPageBlock = 5;
            int cImsi = cCount % cPageSize == 0 ? 0 : 1;
            int cPageCount = cCount / cPageSize + cImsi;
            int cStartPage = (int)((cCurrentPage-1)/cPageBlock)*cPageBlock + 1;
            int cEndPage = cStartPage + cPageBlock - 1;
            if (cEndPage > cPageCount) cEndPage = cPageCount;
            if (cStartPage > cPageBlock) { 
%>
                <a href="mainPage.jsp?pageNum=<%=cStartPage-cPageBlock%>">[이전]</a>
<%
                }
            for (int cI = cStartPage ; cI <= cEndPage ; cI++) { 
                if(cCurrentPage == cI){
%>                    
                <a href="mainPage.jsp?pageNum=<%= cI %>">[[<%= cI %>]]</a>
<%                 
                }else{
%>                    
                <a href="mainPage.jsp?pageNum=<%= cI %>">[<%= cI %>]</a>
<%                 
                }
%>
<%
                }
            if (cEndPage < cPageCount) { %>
                <a href="mainPage.jsp?pageNum=<%=cStartPage+cPageBlock%>">[다음]</a>
<%
                }
%>
<%            
        }
%>
		</div>
<br><br>
<!-- 쓰기영역 -->
<%
 // 새로운 글로 입력(num=0, ref=0, step=0, depth=0)
 // 부모글에 대한 답변으로 입력(num=부모값, ref=부모값, step=부모값, depth=부모값)
 int cNum = 0, cRef = 1, cStep = 0, cDepth = 0;
 try {
     if (request.getParameter("cNum") != null) {
         cNum = Integer.parseInt(request.getParameter("cNum"));
         cRef = Integer.parseInt(request.getParameter("cRef"));
         cStep = Integer.parseInt(request.getParameter("cStep"));
         cDepth = Integer.parseInt(request.getParameter("cDepth"));
     }
%>
<div>
    <form method="post" name="cWriteForm" action="commentWriteProc.jsp?commentPage=<%=numInt%>" onsubmit="return writeSave()">
        <%if(session.getAttribute("id")!=null){%>
            <input type="hidden" size="30" maxlength="30" name="cPass" value="<%=session.getAttribute("pass")%>" />
        <%} %>        
        	<input type="hidden" name="cNum" value="<%=cNum%>"> 
        	<input type="hidden" name="cRef" value="<%=cRef%>"> 
        	<input type="hidden" name="cStep" value="<%=cStep%>"> 
        	<input type="hidden" name="cDepth" value="<%=cDepth%>">
        <table width="600"   cellpadding="0" cellspacing="0" align="center">
            <tr>
                <td width="50" align="center"  class="lightgrey">이름</td>
                <td width="100"align="left"  bgcolor="white">
                <%if(session.getAttribute("id")!=null){%>
                    <input type="hidden" size="10" maxlength="12" name="cWriter" value="<%=session.getAttribute("id")%>"/>
                    <%=session.getAttribute("id")%>
                <%}else{ %>
                    <input type="text" size="10" maxlength="12" name="cWriter" />
                <%} %>
                </td>
                <td width="100" align="center"  class="lightgrey">비밀번호</td>
                <td width="100" align="left"  bgcolor="white">
                  <%if(session.getAttribute("id")==null){%>
                    <input type="password" size="10" maxlength="10" name="cPass" />
                   <%} %>        
                </td>
                <td width="100" colspan="2" align="center"  class="lightgrey">
                    <input type="submit" value="댓글쓰기" /> 
                    <input type="reset" value="다시작성" />
                </td>
            </tr>
            <tr>
                <td align="center"  class="lightgrey">내용</td>
                <td  align="left" colspan="4" bgcolor="white">
                    <textarea name="cContent" cols="60"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>
<%
} catch (Exception e) {
}
%>




	</main>
