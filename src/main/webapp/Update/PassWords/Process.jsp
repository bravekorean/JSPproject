<%@ page import="membership.MemberDTO"%>
<%@ page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 프로세스</title>
</head>
<body>
<%
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");

	String user_id = (String)session.getAttribute("UserId");
	String user_pw = request.getParameter("user_pw");
	String new_user_pw = request.getParameter("new_user_pw");
	
	MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	if(dao.checkpass(user_id, user_pw)){
		MemberDTO update_memberDTO = dao.updateMemberDTO(user_id, "pass" ,new_user_pw );
		dao.close();
	
		if(dao!=null){
%>
		<script>
			alert('정보수정이 완료되었습니다.');
			location.href='../UpdateMainForm.jsp';
		</script>
<%
		}
	}else{
%>
	
	<script>
		alert('비밀번호가 틀렸습니다.');
		history.back();
	</script>
<%
	 }
%>
</body>
</html>