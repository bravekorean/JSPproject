<%@page import="review.reviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="review.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
reviewDAO dao = new reviewDAO(application);
List<reviewDTO> list= dao.getAllReview();


%>
<html>
<head>
<meta charset="UTF-8">
<link href="../LogIn_LogOut/Login.css" rel="stylesheet" type="text/css" />
<link href="admin.css" rel="stylesheet" type="text/css" />
<title>게시판 관리</title>

<script type="text/javascript">
function deletePost(num) {
    var confirmed = confirm("정말로 삭제하겠습니까?");
    if (confirmed) {
        var form = document.querySelector('.tbodytbl');
        form.method = "post";
        form.action = "BoardDeleteProcess.jsp?num="+num;
        form.submit();
    }
}
</script>

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
    <li>게시판관리</li>
    <li><a href="adminView.jsp">관리자페이지</a></li>
    </ul>
</nav>
<form class = "tbodytbl" method="post">
<table class = "boardinfotbl">
<tr>
<th width = "5%">번호</th>
<th width = "15%">아이디</th>
<th width = "15%">작품제목</th>
<th width = "5%">리뷰 제목</th>
<th width = "10%">content</th>
<th width = "5%">rating</th>
<th width = "25%">좋아요 횟수</th>
<th width = "10%">visit count</th>
<th width = "10%">img</th>
</tr>
<%if (list.isEmpty()) {%>
 <tr>
 <td> 등록된 리뷰정보가 없습니다.</td>
 </tr>
 <%} else {
	
	for(reviewDTO dto : list) {
	%>
	<tr>
	<td align ="center"><%=dto.getNum() %></td>
	<td align ="center"><%=dto.getId() %></td>
	<td align ="center"><%=dto.getTitle()%></td>
	<td align ="center"><%=dto.getTitleR() %></td>
	<td align ="center"><%=dto.getContent() %></td>
	<td align ="center"><%=dto.getRating()%></td>
	<td align ="center"><%=dto.getLike_num()%></td>
	<td align ="center"><%=dto.getVisitcount() %></td>
	<td align ="center"><%=dto.getImg() %></td>
	<td align="center">
	  <button type="button" onclick="deletePost('<%=dto.getNum()%>');">삭제</button>
	</td>	
	</tr>
	<%} }
	dao.close(); %>
 
</table>
</form>


</body>



</html>