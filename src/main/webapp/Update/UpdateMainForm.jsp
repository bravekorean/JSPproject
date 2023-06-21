<%@ page import="membership.MemberDTO"%>
<%@ page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="UpdateMainForm.css?after" rel="stylesheet" type="text/css" />
<meta charset="UTF-8">
<title>정보수정</title>
</head>
<body>
<%
	String userId = (String)session.getAttribute("UserId");

	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");

	MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	MemberDTO memberDTO = dao.getMemberDTO(userId);
	
	String user_id = memberDTO.getId();
	String user_name = memberDTO.getName();
	String user_pw = memberDTO.getPass();
	String show_Pass = "";
	String user_email = memberDTO.getEmail();
	String user_phoneNum = memberDTO.getPhonenumber();
	String show_PhoneNum = "010 - **** - ";
	
	for(int i = 0 ;i < user_pw.length();i++){
		show_Pass += "*";
	}//비번길이 만큼 * 출력
	
	for(int i = 7; i < user_phoneNum.length(); i++){
		show_PhoneNum += user_phoneNum.charAt(i);
	}
dao.close();
%>
<div id = "wrapper">
<div id = "main">
	<div class="logo" style="text-align: center;"> 
        <a href="../Main.jsp" target="_blank" title="홈페이지"><img src="../image/로고.png"
        class="image"></a>
    </div>
<h3>기본정보</h3>
<!-- 아이디 -->
<div class="sid">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
</svg>
<%=user_id %><br>
</div><hr class = "hr">
<!-- 메일, 이름, 비번, 번호 -->
<div class="enpp">
이메일:<%=user_email %><a href="Email/Form.jsp" class="as">수정</a><br><hr class = "hr">
이 름:<%=user_name %>   <a href="Name/Form.jsp" class="as">수정</a><br>
비밀번호:<%=show_Pass %><a href="PassWords/Form.jsp" class="as">수정</a><br><hr class = "hr">
전화번호:<%=show_PhoneNum %><a href="PhoneNumber/Form.jsp" class="as">수정</a><br>
</div>   
   <form action="../mypage/mypage.jsp" method="post">   
      <input type="submit" value="Cancel" />
   </form>
</div>
</div>

<footer>
<%@include file = "../footer/footer.jsp" %>
</footer>
</body>
</html>