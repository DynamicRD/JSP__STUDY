package com.kh.edu.board.action;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.edu.board.control.ActionForward;
import com.kh.edu.board.model.BoardDAO;
import com.kh.edu.board.model.BoardVO;

public class UpdateProAction implements CommandAction {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		String pageNum = request.getParameter("pageNum");
		BoardVO article = new BoardVO();
		article.setNum(Integer.parseInt(request.getParameter("num")));
		article.setWriter(request.getParameter("writer"));
		article.setEmail(request.getParameter("email"));
		article.setSubject(request.getParameter("subject"));
		article.setContent(request.getParameter("content"));
		article.setPass(request.getParameter("pass"));
		BoardDAO dbPro = BoardDAO.getInstance();
		int check = dbPro.updateDB(article);
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("check", check);

		return new ActionForward("/board/updatePro.jsp", false);
	}
}
