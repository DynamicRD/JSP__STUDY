<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*, java.nio.file.*" %>
<%
    // 파일 업로드를 처리하는 코드
    String uploadDir = "C:/dev/eclipseWorkspace/jspStudy/src/main/webapp/homepageProject/img";  // 이미지 저장 경로
    Part filePart = request.getPart("productImage"); // "productImage"는 form에서 사용된 name 속성
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // 파일 이름 추출

    // 파일이름이 비어있는지 확인
    if (fileName != null && !fileName.isEmpty()) {
        // 파일을 저장할 전체 경로 설정
        File uploadFile = new File(uploadDir, fileName);

        // 파일을 지정된 경로에 저장
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, uploadFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            out.println("파일이 성공적으로 업로드되었습니다.");
        } catch (IOException e) {
            e.printStackTrace();
            out.println("파일 업로드 중 오류가 발생했습니다.");
        }

        // 저장된 이미지의 경로를 DB에 저장하거나, 이 경로를 사용할 수 있음
        String imagePath = "img/" + fileName; // 웹상에서 접근 가능한 경로
        out.println("이미지 경로: " + imagePath);
        
        // 예: 데이터베이스에 imagePath를 저장하는 코드 추가 가능
        // 예: UPDATE products SET imgUrl = imagePath WHERE ...;
    } else {
        out.println("이미지가 선택되지 않았습니다.");
    }
%>