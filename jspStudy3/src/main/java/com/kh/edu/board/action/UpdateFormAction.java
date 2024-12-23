package com.kh.edu.board.action;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.edu.board.control.ActionForward;
import com.kh.edu.board.model.BoardDAO;
import com.kh.edu.board.model.BoardVO;

public class UpdateFormAction implements CommandAction {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		BoardDAO dbPro = BoardDAO.getInstance();
		BoardVO vo = new BoardVO();
		vo.setNum(num);
		BoardVO article = dbPro.selectBoardDB(vo);
		// 해당 뷰에서 사용할 속성
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("article", article);
		return new ActionForward("/board/updateForm.jsp", false);
	}
}
