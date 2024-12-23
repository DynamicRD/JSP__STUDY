package com.kh.edu.board.control;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.edu.board.action.CommandAction;

public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// Key: ~~~.do, value:컨트롤 객체, 서비스 객체, DAO객체
	// 1. board/list.do
	// 키값: "board/list.do" 객체: Class.Load(com.kh.edu.board.action.ListAction);
	//
	private Map<String, Object> commandMap = new HashMap<String, Object>();

	// CommandPro.properties 키값과 밸류값을 가져와서
	// 미리 객체를 만들고 commandMap에 저장한다(프리로딩하는것과같다)
	@SuppressWarnings("deprecation")
	public void init(ServletConfig config) throws ServletException {
		// 2. props = "CommandPro.properties
		String props = config.getInitParameter("propertyConfig");
		// CommandPro.porperties 파일을 가져오기위한 경로 찾기
		Properties pr = new Properties();
		FileInputStream file = null;
		String path = config.getServletContext().getRealPath("/WEB-INF");
		try {
			// Command.properties파일의 내용을 읽어옴
			file = new FileInputStream(new File(path, props));
			// Command.properties파일의 정보를 Properties객체에 저장
			pr.load(file);
		} catch (IOException e) {
			throw new ServletException(e);
		} finally {
			if (file != null)
				try {
					file.close();
				} catch (IOException ex) {
				}
		}
		// /board/list.do=com.kh.edu.board.action.ListAction 키값에 "board/list.do" Set 등록
		Iterator<Object> keyIter = pr.keySet().iterator();
		while (keyIter.hasNext()) {
			// key값 : "board/list.do"
			String command = (String) keyIter.next();
			// value값 : "com.kh.edu.board.action.ListAction"
			String className = pr.getProperty(command);
			try {
				// 해당 이름"com.kh.edu.board.action.ListAction"을 가진 클래스를 찾아라
				Class commandClass = Class.forName(className);
				// "com.kh.edu.board.action.ListAction" 객체를 만든다
				Object commandInstance = commandClass.newInstance();// 해당클래스의 객체를 생성
				// Map객체인 commandMap에 객체 저장
				commandMap.put(command, commandInstance);
			} catch (ClassNotFoundException e) {
				throw new ServletException(e);
			} catch (InstantiationException e) {
				throw new ServletException(e);
			} catch (IllegalAccessException e) {
				throw new ServletException(e);
			}
		}
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward af = null;
		CommandAction com = null;
		try {
			//http://localhost:8080/jspStudy3/board/index.do?name=kdj
			//command == "/jspStudy3/board/index.do"
			String command = request.getRequestURI();
			//request.getContextPath() == "/jspStudy3"
			if (command.indexOf(request.getContextPath()) == 0) {
				//command = "/board/index.do"
				command = command.substring(request.getContextPath().length());
			}
			com = (CommandAction) commandMap.get(command);
			af = com.execute(request, response);
			if(af.isRedirect() == true) {
				response.sendRedirect(af.getUrl()); 
			}else {
				RequestDispatcher rd = request.getRequestDispatcher(af.getUrl());
				rd.forward(request, response); 
			}
		} catch (Throwable e) {
			throw new ServletException(e);
		}
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

}
