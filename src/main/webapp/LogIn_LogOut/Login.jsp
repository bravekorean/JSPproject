<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="Login.css" rel="stylesheet" type="text/css" />
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>


<!--  아이디저장 쿠키체크 -->
<% String loginId = CookieManager.readCookie(request, "loginId");

String cookieCheck = "";
if (!loginId.equals("")) {
	cookieCheck = "checked";
} %>

<div class = "main">
<div class="logo"> 
	<a href="../Main.jsp" target="_blank" title="메인화면"><img src="../image/로고.png"
class="image"></a>
</div>

<!--  로그인 되기전 화면 -->
<% if(session.getAttribute("UserId")==null){ %>
<!--  아이디, 패스워드창 입력체크 -->
<script>
function validateForm(form){
	if(!form.user_id.value){
		alert("아이디를 입력하세요.");
		return false;	
	}
	if(form.user_pw.value==""){
		alert("패스워드를 입력하세요.");
		return false;
	}
}


</script>

<!--웹페이지 상단-->
        
<!--로그인 부분-->
<form action="LoginProcess.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this);">
	<div class = "id-wrap">
		<input placeholder = "아이디" type="text" name="user_id"  value = "<%= loginId %>" class = "input-id"/>
	</div>
	<div class = "pw-wrap">
		<input placeholder = "비밀번호" type="password" name="user_pw" class = "input-pw"/>
	</div>
	<span style="color:red; font-size:1.2em;">
<%= request.getAttribute("LoginErrMsg")==null? "":request.getAttribute("LoginErrMsg") %>
</span>
	<div class = "login-btn-box">
		<button type= "submit" class = "login-btn">로그인</button>
	</div>
	<span class= "stay-check">
		<input type="checkbox" name="save_check" value="Y" <%= cookieCheck %>/> 아이디 저장
	</span>
</form>

<!--  회원가입 정보를 보냄 -->
<!--  <form action = "../Register/Form.jsp" method = "post" name ="Regiform" >
<button type = "submit" class = "register.btn">회원가입</button>
</form> -->
<span class="sign-up">
	<a href="" onclick = "location.href = '../Register/Form.jsp'" target="_blank">회원가입</a>
</span> 

<!--  로그인이 되고난 후 -->
<%
}else {
%>
	<% response.sendRedirect("../Main.jsp"); %>
	<!--   
 //session.getAttribute("UserName") 회원님, 로그인하셨습니다.<br/>
	<a href="../Update/UpdateMainForm.jsp">[정보수정]</a>
	<a href="../Delete/infodelete.jsp">[계정삭제]</a>
	<a href="LogOut.jsp">[로그아웃]</a> -->
<%
}
%>
</div>
</body>

</html>