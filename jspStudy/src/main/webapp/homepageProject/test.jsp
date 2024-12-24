<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsVO"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%

		

    String uploadPath = application.getRealPath("/") + "homepageProject/img";  // 파일을 저장할 디렉토리
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();  // 디렉토리가 없으면 생성
    }
    int maxSize = 10 * 1024 * 1024;
    MultipartRequest multiRequest = new MultipartRequest(request, uploadPath, maxSize, "UTF-8");
    
    String name = multiRequest.getParameter("name");
    String price = multiRequest.getParameter("price");
    String amount = multiRequest.getParameter("amount");
    String content = multiRequest.getParameter("content");
    String tag = multiRequest.getParameter("tag");
    String productImagePath = null;  // 저장된 이미지 경로
    try {
        // 파일 업로드를 처리할 객체 생성
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        // request에서 업로드된 파일을 파싱
        List<FileItem> items = upload.parseRequest(request);

        // 각 아이템 처리
        
				
        int priceInt = 0;
        if(price != null){
        	priceInt = Integer.parseInt(price);
        }
       	int amountInt = 0; 
        if(amount != null){
        	amountInt = Integer.parseInt(amount);
        }
        
        for (FileItem item : items) {
                // 파일 업로드 처리
                if ("productImage".equals(item.getFieldName())) {
                    String fileName = item.getName();
                    if (fileName != null && !fileName.isEmpty()) {
                        // 파일명에서 경로 제거
                        fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);

                        // 파일 저장
                        item.write(storeFile);
                        productImagePath = "img/" + fileName;  // 이미지 경로 저장
                    }
                }
            
        }
				
        // 상품 DB에 입력
        ProductsVO pvo = new ProductsVO();
        ProductsDAO pdao = ProductsDAO.getInstance();
	      pvo.setName(name);
	      pvo.setPrice(priceInt);
	      pvo.setAmount(amountInt);
	      pvo.setTag(tag);
	      pvo.setContent(content);
	      pvo.setImgUrl(productImagePath);
	      pvo.setRegdate(new Timestamp(System.currentTimeMillis()));
	     	System.out.println(pvo.toString());
	     	//진짜 저장된 경로
				//C:\dev\eclipseWorkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\jspStudy\homepageProject\img
        // 이미지 경로 반환 (다른 JSP 페이지에서 사용할 수 있도록 할 수 있습니다)
        //session.setAttribute("productImagePath", productImagePath);
       	boolean flag = pdao.insertDB(pvo);
        if(flag){
        %>
        <script type="text/javascript">
					alert("상품등록에 성공했습니다");
				window.location.href = "mainPage.jsp"; // 알림창 후 로그인 페이지로 이동
				</script>
				<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
   <script>
					alert("상품등록에 실패했습니다");
					history.go(-1);
	 </script>

