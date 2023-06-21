<%@page import="utils.JSFunction"%>
<%@page import="membership.adminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	String pass = request.getParameter("aup_pass");
 	String name = request.getParameter("aup_name");
 	String email = request.getParameter("aup_email");
 	String phonenumber = request.getParameter("aup_phonenumber");
 	String gender = request.getParameter("aup_gender");
 	String role = request.getParameter("aup_role");
 	String id = request.getParameter("aup_id");
  adminDAO dao = new adminDAO(application);
  int result = dao.updateadminuserinfo(pass,name,email,phonenumber,gender,role,id);
  dao.close();
  if(result == 1) {
	  JSFunction.alertLocation("완료되었습니다.","allselectUser.jsp", out);
  } else {
	  JSFunction.alertBack("처리하지 못했습니다. ", out);
  }
 %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>