<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="Form.css" rel="stylesheet" type="text/css" />
<meta charset="UTF-8">
<title>이메일 변경</title>
</head>
<body>
<div id = "wrapper">
<div id = "main">
<div class="logo"> 
	<a href="../../Main.jsp" target="_blank" title="메인화면"><img src="../../image/로고.png"
class="image"></a><br>
</div>
<hr>
	<form action="Process.jsp" method="post">
		변경할 이메일 : <input type="text" name="user_new_email" /><br />
		패스워드 : <input type="password" name="user_pw" /><br />
		<br>
<hr>
		<input type="submit" value="정보수정하기" />
	</form>
	<form action="../UpdateMainForm.jsp" method="post">	
		<input type="submit" value="Cancel" />
	</form>
</div>
</div>
<footer>
<%@include file="../../footer/footer.jsp"%>
</footer>
</body>
</html>