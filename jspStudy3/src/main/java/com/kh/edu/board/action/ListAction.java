package com.kh.edu.board.action;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.edu.board.control.ActionForward;
import com.kh.edu.board.model.BoardDAO;
import com.kh.edu.board.model.BoardVO;

public class ListAction implements CommandAction {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		String pageNum = request.getParameter("pageNum");// 페이지번호 
		if (pageNum == null) {
		pageNum = "1";

		int pageSize = 5;// 한 페이지의 글의 개수
		int currentPage = Integer.parseInt(pageNum);
		// 한 페이지의 시작글 번호
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;// 한 페이지의 마지막 글번호 
		int count  = 0;
		int number = 0;
		List<BoardVO> articleList = null;
		BoardDAO dbPro = BoardDAO.getInstance();// DB연동
		count = dbPro.selectCountDB();// 전체 글의 수
		if (count > 0) {// 현재 페이지에 해당하는 글 목록
			articleList = dbPro.selectStartEndDB(startRow, endRow);
		} else {
			articleList = Collections.emptyList();
		}
		number = count - (currentPage - 1) * pageSize;// 글목록에 표시할 글번호 //해당 뷰에서 사용할 속성 new Integer(currentPage)
														// deprecated
		// new Integer(currentPage) => currentPage 적어도 된다.
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("startRow", startRow);
		request.setAttribute("endRow", endRow);
		request.setAttribute("count", count);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("number", number);
		request.setAttribute("articleList", articleList);
	} // 뷰
		return new ActionForward("/board/list.jsp", false);
	}
}
