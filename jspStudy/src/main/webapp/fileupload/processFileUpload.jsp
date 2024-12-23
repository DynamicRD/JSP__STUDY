<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileUpload"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
//1.사용자가 전송할때 form에 enctype="multipart/form-data"
  request.setCharacterEncoding("UTF-8");
if (FileUpload.isMultipartContent(request)) {
	//2.임시파일지정
	String temporaryDir = "D:\\temp";
	//3. MultipartRequest(request,위치,사이즈,인코딩,이름정책) 객체가 같은 기능
	DiskFileUpload fileUpload = new DiskFileUpload();
	//3.1. 위치
	fileUpload.setRepositoryPath(temporaryDir);
	//3.2. 사이즈 최대 1메가까지 업로드 가능
	fileUpload.setSizeMax(1024 * 1024);
	//3.3. 한번에 100K 까지는 메모리에 저장.
	fileUpload.setSizeThreshold(1024 * 100);
	//4.Enumeration files = multiRequest.getFileNames(); FileItem의 리스트
	//4. (String) fils.nextElement();
	java.util.List fileItemList = fileUpload.parseRequest(request);
	for (int i = 0; i < fileItemList.size(); i++) {
		//4.1 해당되는 파일정보
		FileItem fileItem = (FileItem) fileItemList.get(i);
		System.out.println(fileItemList.size());
		//4.2 폼파라미터에서 보내온 <input type="file">아닌것만 찾음 
		//text, password,checkbox,radio인가
		if (fileItem.isFormField()) {// <input type="file">인경우
		  out.println("폼 파라미터:"); 	
		  out.println(fileItem.getFieldName() +" = "+ fileItem.getString()+"<br>");
		} else { // 파일인 경우
			out.println("파일:"); 
			out.println(fileItem.getFieldName() 
					+" = "+ fileItem.getString()+"(" +fileItem.getSize() +"bytes) <br>");
			if (fileItem.isInMemory()) {
				out.println("메모리에 저장 <br>"); 
			} else {
				out.println("디스크에 저장 <br>"); 
			}

			//upload 위치를 알려준다
			String filepath = application.getRealPath("upload");
		//업로드한 파일이 사이즈가 있는지 체크
			if (fileItem.getSize() > 0) {
				// 경로에 //있는지 확인
				int idx = fileItem.getName().lastIndexOf("\\");
				if (idx == -1) {
					idx = fileItem.getName().lastIndexOf("/");
				}
				//썰어 orange.png
				String fileName = fileItem.getName().substring(idx + 1);
				try {
					//ilepath = application.getRealPath("upload");
					//new File(upload/orange.png);
					File uploadedFile = new File(filepath, fileName);
					//d://temp/orange.png = > /jspStudy/upload/orange.png
					fileItem.write(uploadedFile);
				} catch (IOException ex) {
				// 예외 처리
				}
			}// 업로드한 파일이 존재하는 경우
		}// 파일인 경우
	}//end of for
} else { //1.사용자가 전송할때 form에 enctype="multipart/form-data"
	out.println("인코딩 타입이 multipart/form-data가 아님.");
}

%>
