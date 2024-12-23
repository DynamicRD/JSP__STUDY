package com.kh.edu.board.action;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.edu.board.control.ActionForward;
import com.kh.edu.board.model.BoardDAO;
import com.kh.edu.board.model.BoardVO;

public class ContentAction implements CommandAction {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8"); 
		//해당 글번호
		 int num = Integer.parseInt(request.getParameter("num"));
		 //해당 페이지 번호
		 String pageNum = request.getParameter("pageNum");
		 BoardDAO dbPro = BoardDAO.getInstance();//DB처리
		 BoardVO vo = new BoardVO();
		 vo.setNum(num);
		 //해당 글번호에 대한 해당 레코드
		 BoardVO article = dbPro.selectBoardDB(vo);
		 //해당 뷰에서 사용할 속성
		 request.setAttribute("num", num);
		 request.setAttribute("pageNum", pageNum);
		 request.setAttribute("article", article);
		 return new ActionForward("/board/content.jsp", false);
	}
}
