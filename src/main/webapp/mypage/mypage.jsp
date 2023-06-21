<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="../LogIn_LogOut/Login.css" rel="stylesheet" type="text/css" />
<link href="mypage.css" rel="stylesheet" type="text/css" />

<meta charset="UTF-8">
<title>마이페이지</title>
</head>

<body>
<div class = "main">
<div class="logo"> 
	<a href="../Main.jsp" target="_blank" title="메인화면"><img src="../image/로고.png"
class="image"></a><br>
<% if(session.getAttribute("isAdmin").equals("user")) { %>
	<%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br/>
	<a href="../Update/UpdateMainForm.jsp">[정보수정]</a>
	<a href="../Delete/infodelete.jsp">[계정삭제]</a>
	<a href="../board/ticketing/ticketinfo.jsp">[예매/결제페이지]</a>
	<a href="../Main.jsp" onclick = "location.href = '../Main.jsp'">[메인화면]</a>
	<% } else if (session.getAttribute("isAdmin").equals("admin")) {  %>
		<%= session.getAttribute("UserName") %>[<%= session.getAttribute("isAdmin") %>]님, 로그인하셨습니다.<br/>
	<a href="../Update/UpdateMainForm.jsp">[정보수정]</a>
	<a href="../Delete/infodelete.jsp">[계정삭제]</a>
	<a href="../board/ticketing/ticketinfo.jsp">[예매/결제페이지]</a>
	<a href="../admin/adminView.jsp">[관리자페이지]</a>
	<a href="../Main.jsp" onclick = "location.href = '../Main.jsp'">[메인화면]</a>
	<% } else {
		JSFunction.alertBack("잘못된 접근입니다.",out); }	%>
	
</div>
</div>
<br>
<br>
<br>
<footer>
<%@include file="../../footer/footer.jsp"%>
</footer>
</body>
</html>