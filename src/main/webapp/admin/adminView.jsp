<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../LogIn_LogOut/Login.css" rel="stylesheet" type="text/css" />
<link href="admin.css" rel="stylesheet" type="text/css" />
<title>관리자 페이지</title>
</head>
<body>
<div class = "main">
<div class="logo"> 
	<a href="../Main.jsp" target="_blank" title="메인화면"><img src="../image/로고.png"
class="image"></a><br>
</div>
</div>
<h2 class = "adminheader"> 관리자 페이지</h2>
<nav id="menu">
    <ul>
    <li><a href="../admin/allselectUser.jsp" id="ct">전체회원조회</a></li>
      <li><a href="../admin/allselectBoard.jsp" id="ct">게시판관리</a></li>
    </ul>
</nav>
</body>
</html>