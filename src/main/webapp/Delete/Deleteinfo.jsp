<%@page import="utils.CookieManager"%>
<%@ page import="membership.MemberDTO" %>
<%@ page import="membership.MemberDAO" %>
<%@ page import="common.JDBCConnect" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원삭제</title>
</head>
<body>
<%
Connection con;
request.setCharacterEncoding("UTF-8");

	String user_id = (String)session.getAttribute("UserId");
	String user_pw = request.getParameter("d_pw");
	String driver = application.getInitParameter("OracleDriver"); // 드라이버 받아오기
	String url = application.getInitParameter("OracleURL");
	String id = application.getInitParameter("OracleId");
	String pwd = application.getInitParameter("OraclePwd");
	 
	 // ---- DB 접속 
	 
		MemberDAO dao = new MemberDAO(driver, url, id, pwd);
	if(dao.checkpass(user_id, user_pw)){
		MemberDTO memberDTO = dao.deleteMemberDTO(user_id,user_pw);
		session.invalidate();
		CookieManager.deleteCookie(response, "LoginId");
%>

<script>
location.href = '../Main.jsp';
</script>
<%}else{%>

<script>
	alert('정보 잘못 입력하셨습니다.');
	history.back();
</script>
<%
 }
%>
</body>
</html>