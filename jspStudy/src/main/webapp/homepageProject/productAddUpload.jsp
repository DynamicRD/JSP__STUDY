<%@page import="java.sql.Timestamp"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsDAO"%>
<%@page import="co.kh.dev.homepageproject.model.ProductsVO"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");

    String uploadPath = application.getRealPath("/") + "homepageProject/img";  // 파일을 저장할 디렉토리
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();  // 디렉토리가 없으면 생성
    }

    try {
        // 파일 업로드를 처리할 객체 생성
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");  // 파일 업로드 시 인코딩 설정

        // request에서 업로드된 파일을 파싱
        List<FileItem> items = upload.parseRequest(request);

        // 각 아이템 처리
        String name = "";
        String price = "";
        String amount = "";
        String tag = "";
        String content = "";
        String productImagePath = "";  // 저장된 이미지 경로

        for (FileItem item : items) {
            if (item.isFormField()) {
                // 텍스트 필드 처리
                if ("name".equals(item.getFieldName())) {
                    name = item.getString("UTF-8"); // 한글 인코딩을 맞추기 위해 UTF-8로 처리
                } else if ("price".equals(item.getFieldName())) {
                    price = item.getString("UTF-8");
                } else if ("amount".equals(item.getFieldName())) {
                    amount = item.getString("UTF-8");
                } else if ("tag".equals(item.getFieldName())) {
                    tag = item.getString("UTF-8");
                } else if ("content".equals(item.getFieldName())) {
                    content = item.getString("UTF-8");
                }
            } else {
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
        }

        int priceInt = 0;
        if(price != null && !price.isEmpty()){
            priceInt = Integer.parseInt(price);
        }
        int amountInt = 0; 
        if(amount != null && !amount.isEmpty()){
            amountInt = Integer.parseInt(amount);
        }

        // 상품 DB에 입력
        ProductsVO pvo = new ProductsVO();
        ProductsDAO pdao = ProductsDAO.getInstance();
        pvo.setName(name);
        pvo.setPrice(priceInt);
        pvo.setAmount(amountInt);
        pvo.setTag(tag);
        pvo.setContent(content);
      	//진짜 저장된 경로
				//C:\dev\eclipseWorkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\jspStudy\homepageProject\img
        pvo.setImgUrl(productImagePath);
        pvo.setRegdate(new Timestamp(System.currentTimeMillis()));

        boolean flag = pdao.insertDB(pvo);
        if(flag) {
        	System.out.println(pvo.toString());
%>
            <script type="text/javascript">
                alert("상품등록에 성공했습니다");
                window.location.href = "mainPage.jsp"; // 알림창 후 로그인 페이지로 이동
            </script>
<%
        } else {
%>
            <script>
                alert("상품등록에 실패했습니다");
                history.go(-1);
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>