<%@ page contentType="text/html; charset=UTF-8"%>
<main>
  <div class="section">
        <h1>프로젝트 개요</h1>
        <br>
        <p>이 프로젝트는 <strong>JDK 21.0.4</strong>와 <strong>Tomcat 9.0</strong> 서버를 기반으로 <strong>JSP</strong>(JavaServer Pages) 기술을 사용하여 동적 웹 페이지를 개발하는 것을 목표로 했습니다. 또한, <strong>Oracle DB 23c Express Edition</strong>과 <strong>SQL Developer 23.1</strong>을 활용하여 데이터베이스 연동을 통해 실시간 데이터 처리 및 관리 기능을 구현했습니다.</p>
    </div>

    <div class="section">
        <h2>개발 환경</h2>
         <br>
        <ul>
            <li><strong>JDK</strong>: Java 21.0.4</li>
            <li><strong>서버</strong>: Tomcat 9.0</li>
            <li><strong>IDE</strong>: Eclipse</li>
            <li><strong>데이터베이스</strong>: Oracle DB 23c Express Edition</li>
            <li><strong>SQL 개발 도구</strong>: SQL Developer 23.1</li>
        </ul>
    </div>

    <div class="section">
        <h2>주요 기술 스택 및 기능</h2>
         <br>
        <h3>1. JSP (JavaServer Pages)</h3>
        <p>JSP를 사용하여 HTML과 Java 코드의 결합을 통해 동적 웹 페이지를 개발하였습니다. 사용자 요청에 따라 데이터를 처리하고, 동적으로 페이지를 생성하는 기능을 구현했습니다. <strong>JSP EL (Expression Language)</strong>와 <strong>JSTL (JavaServer Pages Standard Tag Library)</strong>을 활용하여 데이터 바인딩 및 로직 처리를 간소화했습니다.</p>
        
        <h3>2. Tomcat 9.0</h3>
        <p>Tomcat 9.0을 서블릿 컨테이너로 사용하여 JSP 페이지를 실행하고 HTTP 요청/응답을 처리하였습니다. 여러 페이지 간의 라우팅 및 세션 관리, 인증 기능 등을 구현했습니다.</p>

        <h3>3. Oracle DB 23c Express Edition</h3>
        <p>데이터베이스에 저장된 정보를 웹 페이지에서 실시간으로 조회하고 수정하는 기능을 제공하였습니다. <strong>JDBC (Java Database Connectivity)</strong>를 사용하여 JSP와 데이터베이스 간의 연결을 구현했습니다. 다양한 SQL 쿼리를 사용하여 데이터를 삽입, 조회, 업데이트, 삭제하는 기능을 제공하였습니다.</p>

        <h3>4. SQL Developer 23.1</h3>
        <p>Oracle DB와의 연동을 위해 SQL Developer 23.1을 사용하여 데이터베이스 관리 및 SQL 쿼리 실행을 수행했습니다. 데이터베이스 구조 설계 및 SQL 쿼리 최적화를 위해 SQL Developer를 활용하여 효율적인 데이터 처리를 구현했습니다.</p>
    </div>
    
    <div class="section">
        <h2>학습한 내용</h2>
         <br>
        <ul>
            <li><strong>JSP의 동작 원리와 활용</strong>: JSP는 HTML과 Java 코드를 결합하여 동적 웹 페이지를 생성하는 데 사용됩니다. 이를 통해 사용자 요청에 따라 데이터를 처리하고, 실시간으로 결과를 출력할 수 있습니다.</li>
            <li><strong>JDBC를 통한 데이터베이스 연동</strong>: JSP에서 데이터베이스와의 연동을 위해 JDBC를 사용하여 SQL 쿼리를 실행하고 데이터를 처리하는 방법을 학습했습니다.</li>
            <li><strong>Tomcat 서버 관리</strong>: Tomcat을 로컬 환경에서 설정하고 실행하여 웹 애플리케이션을 배포하는 방법을 익혔습니다.</li>
            <li><strong>SQL Developer의 활용</strong>: SQL Developer를 사용하여 데이터베이스 쿼리 작성, 디버깅 및 성능 최적화를 진행하면서 SQL 실력을 향상시켰습니다.</li>
        </ul>
    </div>
    <div class="section">
    <a href="mainPage.jsp?flag=none">이전 페이지로</a>
    </div>
</main>