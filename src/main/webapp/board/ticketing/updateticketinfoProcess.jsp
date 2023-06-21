<%@page import="ticket.ticketDAO"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
 String dateparam = request.getParameter("up_date");
 String timeparam = request.getParameter("up_time");
 int numparam = Integer.parseInt(request.getParameter("up_code"));
 int time;
 java.sql.Date date1;
 
 if(dateparam != null) {
	 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	 java.util.Date utilDate = dateFormat.parse(dateparam);
	 java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	 date1 = sqlDate;
	 //out.println(date1);
	 } else {
	 	JSFunction.alertBack("날짜변환에 오류가 있습니다.",out);
	 	return;
	 }
 if ("1".equals(timeparam)) {
		time = 1; // 1회차
		
	} else {
		time = 2; // 2회차
	}
 
  ticketDAO dao = new ticketDAO(application);
  int result = dao.updateticketinfo(date1,time,numparam);
  
  if (result == 1) {
	  JSFunction.alertLocation("변경이 완료되었습니다.","../../mypage/mypage.jsp",out);
  } else {
	  JSFunction.alertBack("예매코드를 다시 한번 확인해주시거나 관리자에게 문의바랍니다.",out);
  }
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매정보변경페이지</title>
</head>
<body>

</body>
</html>