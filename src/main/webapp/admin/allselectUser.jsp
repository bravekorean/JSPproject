<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="membership.adminDAO"%>
<%@page import="membership.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 adminDAO dao = new adminDAO(application);

 Map<String,Object> param = new HashMap<String,Object>();
 
 String searchField = request.getParameter("searchField");
 String searchWord = request.getParameter("searchWord");
 if (searchWord != null) {
	 param.put("searchField",searchField);
	 param.put("searchWord", searchWord);
 }
 
 int totalCount = dao.userCount(param);
 List<MemberDTO> memberlist = dao.selectUserinfo(param);
 dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../LogIn_LogOut/Login.css" rel="stylesheet" type="text/css" />
<link href="admin.css" rel="stylesheet" type="text/css" />
<title>유저 관리</title>
</head>
<body>
<div class = "main">
<div class="logo"> 
	<a href="../Main.jsp" target="_blank" title="메인화면"><img src="../image/로고.png"
class="image"></a><br>
<h2 class = "adminheader"> 관리자 페이지</h2>
</div>
</div>
<nav id="menu">
    <ul>
    <li>전체회원조회</li>
    <li><a href="adminView.jsp">관리자페이지</a></li>
    </ul>
</nav>
<div class = "search">
<form method = "get">
<table class ="searchinfo">
<tr>
<td>
<select name = "searchField">
<option value = "id">아이디 </option>
<option value = "name">닉네임 </option>
<option value = "phonenumber">전화번호</option>
<option value = "role">권한</option>
</select>
<input type = "text" name="searchWord" class="input-t" />
<input type = "submit" value="검색하기" class="select-b"/>
</td>
</tr>
</table>
</form>
</div>

<div class = "memberlist">
<table class = "userinfotbl" style="margin: 0 auto;">
<tbody class = "tbodytbl">
<tr>
<th width = "5%">번호</th>
<th width = "15%">아이디</th>
<th width = "15%">비밀번호</th>
<th width = "5%">권한</th>
<th width = "10%">닉네임</th>
<th width = "5%">성별</th>
<th width = "25%">이메일</th>
<th width = "10%">전화번호</th>
<th width = "10%">가입일</th>
</tr>
<%if (memberlist.isEmpty()) {%>
 <tr>
 <td> 등록된 회원정보가 없습니다.</td>
 </tr>
 <%} else {
	int virtualNum = 1;
	
	for(MemberDTO dto : memberlist) {
	%>
	<tr>
	<td align ="center"><%=virtualNum %></td>
	<td align ="center"><%=dto.getId() %></td>
	<td align ="center"><%=dto.getPass() %></td>
	<td align ="center"><%=dto.getRole() %></td>
	<td align ="center"><%=dto.getName() %></td>
	<td align ="center"><%=dto.getGender() %></td>
	<td align ="center"><%=dto.getEmail() %></td>
	<td align ="center"><%=dto.getPhonenumber() %></td>
	<td align ="center"><%=dto.getRegidate() %></td>
	</tr>
	<%virtualNum++;}}  %>

	
	
 
 
</tbody>
</table>
<div class="backbutton"> 
  <br>
  <form action="updateadminProcess.jsp" method="post" class="updateform">
    <details class="updateinfoform">
      <summary>회원정보변경</summary>
      <p class ="notice">(아이디와 가입일은 변경 불가능합니다.)</p>
      
      <div id="mem_info_form">
        비밀번호 :  <input type="text" id="cpass" name="aup_pass" >
         권한 : <input type="text" id="crole" name="aup_role" >
         닉네임 : <input type="text" id="cname" name="aup_name" >
         성별 : <input type="text" id="cgender" name="aup_gender" >
         이메일 : <input type="text" id="cemail" name="aup_email" >
         휴대폰번호 : <input type="text" id="cphonenumber" name="aup_phonenumber" >
        <p class ="notice">변경 대상의 아이디를 입력해주세요 </p>
        아이디 : <input type = "text" id = aup_id name = aup_id>
        <br>
        <br>
	      <button type = "submit" class = "updatebutton"> 변경하기 </button>
      </div>
    </details>
  </form>
   <form action="deleteadminProcess.jsp" method="post" class="updateform">
    <details class="updateinfoform">
      <summary>회원삭제</summary>
      <p class ="notice">삭제할 아이디를 입력해주세요.</p>
      
      <div id="mem_info_form">
        아이디 : <input type = "text" id = dup_id name = dup_id>
        <br>
        <br>
	      <button type = "submit" class = "deletebutton"> 삭제하기 </button>
      </div>
    </details>
  </form>
</div>
</body>
</html>