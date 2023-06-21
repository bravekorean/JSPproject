<%@page import="utils.JSFunction"%>
<%@page import="membership.adminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
     String id = request.getParameter("dup_id");
    
    adminDAO dao = new adminDAO(application);
    int result = dao.deleteuserinfo(id);
    
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