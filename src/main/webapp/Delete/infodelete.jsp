<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="delete.css?after" rel="stylesheet" type="text/css" />
<title>회원삭제</title>
</head>
<script>
function removeCheck(Form) {

	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인

	     document.removeform.submit();

	 }else{   //취소

	     return false;

	 }

	}
</script>
<body>
<div id ="wrapper">
<div id ="main">


<div class="logo"> 
	<a href="../Main.jsp" target="_blank" title="메인화면"><img src="../image/로고.png"
class="image"></a><br>
</div>
<hr>
<form action="Deleteinfo.jsp" method="post" name = "removeform" onsubmit = "return removeCheck(this)">
비밀번호 : <input type = "password" name = "d_pw" class = "pw_input" />
<br>
<br>
<br>
<hr>
<input type = "submit" value = "삭제하기" /> <br>
</form>
<form action="../mypage/mypage.jsp" method="post">   
    <input type="submit" value="Cancel" />
</form>



<footer>
<%@include file="../footer/footer.jsp"%>
</footer>

</div>
</div>
</body>
</html>