<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <% String theater = "A000";
  	 String musical = "B000";
  	 String exhi = "D000";
  
  %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>헤더</title>
</head>
<body>
<div id = "header">
	<div class = "logo">
		<a href = "../../Main.jsp"><img src = "../../image/로고.png"></a>
	</div>
	<div class = "headerlog">
	<%if (session.getAttribute("UserId") == null ) { %>
	<a href="../../LogIn_LogOut/Login.jsp" id="hd">로그인</a>&nbsp;&nbsp;
	<a href="../../Register/Form.jsp" id="hd">회원가입</a>	
	<%} else {%>
	<a href="../../mypage/mypage.jsp" id="hd">마이페이지</a>&nbsp;&nbsp;
	<a href="../../LogIn_LogOut/LogOut.jsp" id="hd">로그아웃</a>	
	<%}%>
	</div>
</div>

<!--메뉴바 생성 -->
<nav id="menu">
    <ul>
    <li><a href="../../board/all/all.jsp" id="ct">전체</a></li>
      <li><a href="../exhibition/exhibition.jsp?real=<%= exhi %>" id="ct">전시회</a></li>
      <li><a href="../theater/theater.jsp?real=<%= theater %>" id="ct">연극</a></li>
      <li><a href="../musical/Musical.jsp?real=<%= musical %>" id="ct">뮤지컬</a></li>
      <li><a href="../review/review.jsp" id="ct">후기</a></li>
    </ul>
</nav>
</body>
</html>