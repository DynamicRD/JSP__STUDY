package com.kh.edu.board.action;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.edu.board.control.ActionForward;
import com.kh.edu.board.model.BoardDAO;
import com.kh.edu.board.model.BoardVO;

public class DeleteProAction implements CommandAction {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String pass = request.getParameter("pass");
		BoardDAO dbPro = BoardDAO.getInstance();
		BoardVO vo = new BoardVO();
		vo.setNum(num);
		vo.setPass(pass);
		boolean flag = dbPro.deleteDB(vo);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("flag", flag);
		return new ActionForward("/board/deletePro.jsp", false);
	}
}
