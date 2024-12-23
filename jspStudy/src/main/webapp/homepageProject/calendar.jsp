<%@ page contentType="text/html; charset=UTF-8"%>
<%
    // 현재 날짜를 구하는 코드
    java.util.Calendar calendar = java.util.Calendar.getInstance();
    int year = calendar.get(java.util.Calendar.YEAR);
    int month = calendar.get(java.util.Calendar.MONTH); // 0부터 시작, 예: 0 = 1월
    int day = calendar.get(java.util.Calendar.DAY_OF_MONTH);
    int firstDayOfMonth = calendar.getActualMinimum(java.util.Calendar.DAY_OF_MONTH);
    int lastDayOfMonth = calendar.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
    
    // 월 이름 구하기
    String[] monthNames = {"1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"};
    String currentMonth = monthNames[month];
%>

<div class="calendar">
    <h3><%= year %>년 <%= currentMonth %></h3>
    <table>
        <thead>
            <tr>
                <th>일</th>
                <th>월</th>
                <th>화</th>
                <th>수</th>
                <th>목</th>
                <th>금</th>
                <th>토</th>
            </tr>
        </thead>
        <tbody>
            <%
                // 1일이 무슨 요일인지 계산
                calendar.set(year, month, 1);
                int firstDayOfWeek = calendar.get(java.util.Calendar.DAY_OF_WEEK); // 1 (일요일) ~ 7 (토요일)
                
                // 첫 번째 주의 공백을 채우기 위한 변수
                int dayCounter = 1;
                boolean firstRow = true;

                for (int i = 0; i < 6; i++) {  // 최대 6개의 주
                    out.print("<tr>");
                    for (int j = 0; j < 7; j++) {
                        // 첫 번째 주에 첫 번째 날이 올 위치까지 공백 채우기
                        if (i == 0 && j < firstDayOfWeek - 1) {
                            out.print("<td></td>");
                        } else {
                            if (dayCounter <= lastDayOfMonth) {
                                // 현재 날짜가 오늘인 경우, CSS 클래스 추가
                                if (dayCounter == day) {
                                    out.print("<td class='current-day'>" + dayCounter + "</td>");
                                } else {
                                    out.print("<td>" + dayCounter + "</td>");
                                }
                                dayCounter++;
                            }
                        }
                    }
                    out.print("</tr>");
                    if (dayCounter > lastDayOfMonth) {
                        break;
                    }
                }
            %>
        </tbody>
    </table>
</div>