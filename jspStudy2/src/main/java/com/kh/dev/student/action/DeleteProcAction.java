package com.kh.dev.student.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.dev.student.control.ActionForward;
import com.kh.dev.student.model.StudentDAO;
import com.kh.dev.student.model.StudentVO;

public class DeleteProcAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
	HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("EUC-KR");
		StudentDAO dao = StudentDAO.getInstance();
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String pass = request.getParameter("pass");
		StudentVO svo = new StudentVO();
		svo.setId(id);
		svo.setPass(pass);
		boolean flag = dao.deleteDB(svo);
		if (flag) {
		session.invalidate();
		}
		request.setAttribute("flag", flag);
		return new ActionForward(
		"/mvcmem/deleteProc.jsp", false);
	}
}
