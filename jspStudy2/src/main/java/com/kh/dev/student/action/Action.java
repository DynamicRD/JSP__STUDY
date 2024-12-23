package com.kh.dev.student.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
	//추상메소드
	public com.kh.dev.student.control.ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException;

}
