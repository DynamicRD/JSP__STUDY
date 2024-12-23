<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Map"%>
<%
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String address = request.getParameter("address");
//체크박스에서 체크한것만 가져온다. 4개에서 2개를 체크한다. values.size() == 2
String[] values = request.getParameterValues("pet");

System.out.println(name);
System.out.println(address);

for(int i = 0;i < values.length;i++){
System.out.println("values["+i+"] = "+ values[i]);
}
//==========================================
Enumeration enumData = request.getParameterNames();
while(enumData.hasMoreElements()){
	String enumName = (String)enumData.nextElement();
	System.out.println("enumName="+enumName);
}
//==========================================
//키값과 value값으로 분류해서 나누어 버린다.
Map parameterMap = request.getParameterMap();
String[] nameParam = (String[])parameterMap.get("name");
System.out.println("name="+nameParam[0]);
%>
