package co.kh.dev.mvc.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.kh.dev.mvc.control.ActionForward;

public class IndexAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse reponse) throws IOException {
		System.out.println("사용자 정보를 받고 ->데이터베이스를 조회하고->결과를 request에 넣고"
				+ "-> 화면 jsp를 설정과->redirect인지 foward인지 보내주는 IndexAction이다.");
		return new ActionForward("index.jsp",false);
	}

}
