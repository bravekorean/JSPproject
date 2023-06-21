<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <% String theater = "A000";
  	 String musical = "B000";
  	 String exhi = "D000";
  	HttpServletRequest contextroot = (HttpServletRequest) pageContext.getRequest();
    String contextPath = contextroot.getContextPath();
  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>

<style>
.hidden {
  display: none;
}
</style>

<script type="text/javascript">

function redirectToLink(url) {
  window.location.href = url;
}

</script>
<link href="Main.css" rel="stylesheet" type="text/css" />
<link href="slide.css" rel = "stylesheet" type = "text/css" />
</head>
<body>

<div class = "hidden">
<jsp:include page="board/all/all.jsp"/>
</div>
<%
int length = (int)session.getAttribute("length");
String thumbnail[]= new String[length];
String startDate[]= new String[length];
String seq[]= new String[length];
for(int i = 0; i < length; i ++){
	
	thumbnail[i]=(String)session.getAttribute("thumbnail"+i);
	seq[i]=(String)session.getAttribute("seq"+i);
	startDate[i]=(String)session.getAttribute("startDate"+i);
}

%>
<!-- header -->
<div id = "main">
<div id = "header">
	<div class = "logo">
		<a href = "Main.jsp"><img src = "image/로고.png"></a>
	</div>
	<div class = "headerlog">
	<%if (session.getAttribute("UserId") == null ) { %>
	<a href="./LogIn_LogOut/Login.jsp" id="hd">로그인</a>&nbsp;&nbsp;
	<a href="./Register/Form.jsp" id="hd">회원가입</a>	
	<%} else {%>
	<a href="./mypage/mypage.jsp" id="hd">마이페이지</a>&nbsp;&nbsp;
	<a href="./LogIn_LogOut/LogOut.jsp" id="hd">로그아웃</a>	
	<%}%>
	</div>
</div>

<!--메뉴바 생성 -->
<nav id="menu">
    <ul>
    	<li><a href="board/all/all.jsp" id="ct">전체</a></li>
        <li><a href="board/exhibition/exhibition.jsp" id="ct">전시회</a></li>
      	<li><a href="board/theater/theater.jsp?real=<%= theater %>" id="ct">연극</a></li>
      	<li><a href="board/musical/Musical.jsp?real=<%= musical %>" id="ct">뮤지컬</a></li>
      	<li><a href="board/review/review.jsp" id="ct">후기</a></li>
    </ul>
</nav>

<!-- 슬라이드 사진 -->
 <div id="slideShow">
  <ul class="slides">
    
      	 <li><img class = "slideimage" src="./image-Main/최근게시물1.jpg" onclick = "goPage('244137', 'http://www.culture.go.kr/upload/rdf/23/05/show_2023050114591374457.jpg')"></li>

      	 <li><img class = "slideimage" src="./image-Main/최근게시물2.jpg" onclick = "goPage('246854', 'http://www.culture.go.kr/upload/rdf/23/05/show_2023052917215212315.png')"></li>
     
      	 <li><img class = "slideimage" src="./image-Main/최근게시물3.jpg"onclick = "goPage('247692', 'http://www.culture.go.kr/upload/rdf/23/06/show_20230612114201112.png')"></li>
   
  </ul>
  <p class="controller">
    <!-- &lang: 왼쪽 방향 화살표 &rang: 오른쪽 방향 화살표 --> 
    <span class="prev">&lang;</span> 
    <span class="next">&rang;</span>
  </p>
</div>
 <script src="slide.js"></script>

<!-- 추천 -->
<div id = "circles">
	<div class = "circle1" style="background-image: url(image/전시회.jpg);" onclick="redirectToLink('<%= contextPath %>/board/exhibition/exhibition.jsp');">
</div>	
	<div class = "circle2" style="background-image: url(image/연극.jpg);" onclick="redirectToLink('<%= contextPath %>/board/theater/theater.jsp');">
</div>
	<div class = "circle3" style="background-image: url(image/뮤지컬.jpg);"onclick="redirectToLink('<%= contextPath %>/board/musical/Musical.jsp');" >
</div>
</div>

<!-- 공통footer -->
<%@include file="../footer/footer.jsp"%>
</div>
</body>
</html>