<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link href="Signup.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!-- 로고 -->
	<div class="logo" style="text-align: center;"> 
        <a href="../Main.jsp" target="_blank" title="홈페이지"><img src="../image/로고.png"
        class="image"></a>
    </div>
<div id="wrapper">
<div id="content">
	<form method="post" action="Process.jsp" onsubmit="return validateForm(this);">
		
		 <!-- ID -->
		<h3 class="title"><label for="u_id">아이디</label></h3>
			<span class="box_id">
			<input type="text" id="u_id" name="r_id" class="inp" placeholder = "아이디">
			<span id = "idError" style="color:red"></span>
		</span>
		
		<!-- PW -->
		<h3 class="title"><label for="u_pwd">비밀번호</label></h3>
			<span class="pass">
				<input type="password" id="u_pass" name="r_pass" class="inp" placeholder = "비밀번호">
				<span id = "passwordError" style="color:red"> </span>
			</span>
		
		<!-- NAME -->
			<h3 class="title"><label for="u_name">이름</label></h3>
			<span class="box_name">
				<input type="text" id="u_name" name="r_name" class="inp"placeholder = "닉네임">
				<span id = "nameError" style="color:red"> </span>
			</span>	
		
		<!-- EMAIL -->
		 	<h3 class="title"><label for ="u_email">이메일</label></h3>
		 	<span class="box_email">
				<input type = "text" id = "u_email" name = "r_email" class="inp" placeholder = "이메일">
				<span id = "emailError" style="color:red"> </span>
			</span>
	
		 <!-- MOBILE -->
			<h3 class="title"><label for ="u_phonenumber">휴대전화</label></h3>
			<span class="box_mobile">
				<input type = "text" id = "u_number" name = "r_number" class="inp" maxlength="16" placeholder="전화번호 입력">
				<span id = "numError" style="color:red"> </span>
			</span>
		
		<!-- GENDER -->
			<h3 class="title"><label for = "u_gender">성별</label></h3>
			<span class="box_gender">
				<select name ="gender">
					<option value = "male" selected>남성</option>
					<option value = "female">여성 </option>
				</select>
			</span>
		  
		  <input type = "hidden" id = "u_admin" name = "r_admin" class = "inp" value = "user">
		<!-- JOIN BTN -->
			<div class="btn">
            	    <button type="submit" id="btnJoin">
            	        <span>가입하기</span>
            	    </button>
            	</div>
		</form>
			<script type="text/javascript" src="Register_validateForm.js"></script>
	</div>
	</div>
</body>
	
</html>