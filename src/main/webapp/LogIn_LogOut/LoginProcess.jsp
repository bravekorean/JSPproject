<%@page import="utils.JSFunction"%>
<%@page import="utils.CookieManager"%>
<%@ page import = "membership.MemberDAO"%>
<%@ page import = "membership.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Process</title>
</head>
<body>

<%
request.setCharacterEncoding("UTF-8");
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");
String save_check = request.getParameter("save_check");

String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

MemberDAO dao = new MemberDAO(oracleDriver,oracleURL,oracleId,oraclePwd);
MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
dao.close();

if (userId.equals(memberDTO.getId()) && userPwd.equals(memberDTO.getPass())) { 
    // 로그인 성공
    if (save_check != null && save_check.equals("Y")) { 
		CookieManager.makeCookie(response,"loginId", userId, 86400);
    } 
    else {
		CookieManager.deleteCookie(response, "loginId");
    }  //체크박스   
}

if(memberDTO.getId()!= null){
	session.setAttribute("UserId", memberDTO.getId());
	session.setAttribute("UserName", memberDTO.getName());
	session.setAttribute("UserPhonenumber", memberDTO.getPhonenumber());
	session.setAttribute("isAdmin",memberDTO.getRole());
	response.sendRedirect("Login.jsp");
}else {
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	request.getRequestDispatcher("Login.jsp").forward(request, response);
}
%>
</body>
</html>
