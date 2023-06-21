<%@page import="ticket.ticketDAO"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
 int code = Integer.parseInt(request.getParameter("de_code"));
 String payinfo = request.getParameter("de_paycode");

  ticketDAO dao = new ticketDAO(application);
  int rsCount = dao.deleteticket(code);
  
  if (rsCount == 1 ) {
	  dao.deletecinfoDTO(payinfo); // 예매정보가 DB에서 삭제되면 결제정보를 삭제함.
	  JSFunction.alertLocation("예매취소가 완료되었습니다.","../../mypage/mypage.jsp",out);
  } else {
	  JSFunction.alertBack("입력하신 정보를 확인하시거나, 관리자에게 문의해주십시오.", out);
  }
%>
<html>
<head>
<meta charset="UTF-8">
<title>예매취소처리페이지</title>
</head>
<body>

</body>
</html>