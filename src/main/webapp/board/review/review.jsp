<%@page import="java.util.List"%>
<%@page import="review.reviewDTO"%>
<%@page import="review.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
reviewDAO dao = new reviewDAO(application);
List<reviewDTO> list = null;
if(request.getParameter("sort")!= null){
	String sort = request.getParameter("sort");
	if(sort.equals("visitcount")){
		list= dao.getAllReviewByVisitCount();
	}else if(sort.equals("like_num")){
		list= dao.getAllReviewByLikeNum();
	}else {
		list= dao.getAllReviewByNum();
	}
}else{
	list= dao.getAllReview();
}
dao.close();
%>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>
<link href="review.css" rel="stylesheet" type="text/css" />
<link href="../header.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!-- 공통메뉴 -->
<%@include file = "../header.jsp" %>


<ul class="into-ul">
<li class="into-li" ><a href = "review.jsp?sort=visitcount"> 조회순 </a></li>
<li class="into-li"><a href = "review.jsp?sort=like_num">인기순</a></li>
<li class="into-li"><a href = "review.jsp?sort=num">최신순</a></li>
</ul><br>

<div class="review-btn">
<button onClick="location.href='WriteReview.jsp'">리뷰작성</button>
<button>전체보기</button>
</div>
<div class="review-box">
<% for (reviewDTO dto : list){
%>
	<div class="data">
	<ul class="data-ul">
		<li class="data-li">
			<span class="id"><%=dto.getId()%></span>
			<span class="buyer">예매자</span>
		</li>
		<li class="data-li"><%=dto.getRdate()%></li>
		<li class="data-li">조회수:<%=dto.getVisitcount()%></li>
		<li class="data-li"><%=dto.getLike_num()%></li>
 		<button class="like"></button>
	</ul>
	</div>
	<div class="review-contents">
		<strong><%=dto.getTitleR()%></strong>
    	<p><%=dto.getContent()%></p>
		<!-- 이미지후기 -->
		<img alt="" src="">
		<p><%=dto.getTitle() %></p>
	</div>
	<i class="text" onclick="location.href='View.jsp?num=<%=dto.getNum()%>'"></i>
	<%} %>
</div>

</body>
</html>