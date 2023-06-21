<%@page import="utils.JSFunction"%>
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
<title>Register Process</title>
</head>
<body>
<%
Connection con;
request.setCharacterEncoding("UTF-8");


	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	String rid = request.getParameter("r_id");
	String rpass = request.getParameter("r_pass");
	String rname = request.getParameter("r_name");
	String rem = request.getParameter("r_email");
	String rpn = request.getParameter("r_number");
	String rgn = request.getParameter("gender");
	String adm = request.getParameter("r_admin");
	
	

	MemberDAO dao = new MemberDAO(oracleDriver,oracleURL,oracleId,oraclePwd);
    boolean result = dao.insertMemberDTO(rid,rpass,rname,rem,rpn,rgn,adm);
    dao.close();
    if(!result){
    	JSFunction.alertBack("회원가입을 진행 할 수없습니다.", out);
    }
    else{
 
    
%>
 <script>
location.href = '../LogIn_LogOut/Login.jsp';
</script>
<%}  %>



</body>
</html>