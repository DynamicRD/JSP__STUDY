package co.kh.dev.mvc.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.kh.dev.mvc.action.Action;

@WebServlet("*.do")
public class ControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		//1.사용자 정보를 가져온다,사용자가 무엇을 요청하는지 파악한다
		//http://localhost:8080/jspStudy/index.do?name=kdj index.do만 뽑아낸다
		request.setCharacterEncoding("UTF-8");
		String uri = request.getRequestURI(); // 	/jspStudy/index.do
		String cmd = uri.substring(uri.lastIndexOf("/"));	// /index.do
		
		if(cmd != null) {
			//2.ActionFactory 관련된 Action객체를 만들것을 요청
			ActionFactory factory = ActionFactory.getInstance();
			Action action = (Action) factory.getAction(cmd);
			if(action != null) {
				ActionForward af = action.execute(request, response);
				
				//3. 화면을 요청한다. (sendRedirect,foward)
				if(af.isRedirect()) {
					response.sendRedirect(af.getUrl());
				}else {
					RequestDispatcher rd = request.getRequestDispatcher(af.getUrl());
					rd.forward(request, response);
				}
			}
		}else {
			RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
			rd.forward(request, response);
		}
		RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
		rd.forward(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
