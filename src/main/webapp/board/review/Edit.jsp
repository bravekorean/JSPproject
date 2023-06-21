<%@page import="java.io.InputStream"%>
<%@page import="java.util.Base64"%>
<%@page import="review.reviewDTO"%>
<%@page import="review.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
int num = Integer.parseInt(request.getParameter("num"));
reviewDAO dao = new reviewDAO(application);
reviewDTO dto = dao.getReviewByNum(num);
dao.close();
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="review.css" rel="stylesheet" type="text/css" />
<link href="../header.css" rel="stylesheet" type="text/css" />
</head>
<body onload="changeStarColor(<%=dto.getRating()%>)">
<!-- 공통메뉴 -->
<%@include file = "../header.jsp" %>

<script src="rating.js"></script>

<div class="review-box">
<form action="updateProcess.jsp" method="post" enctype="multipart/form-data">
	<input type = "hidden" name = "num" value = "<%=dto.getNum() %>">
	<input type="text" name="title" value = "<%=dto.getTitleR() %>">
	
	<hr style="color: #dfe5ed;">
	
	<input type="text" name="content" value = "<%=dto.getContent() %>">

	<div class="rating">
		<a>rating</a>
  		<span class="star" onclick="changeStarColor(1)">&#9734;</span>
  		<span class="star" onclick="changeStarColor(2)">&#9734;</span>
  		<span class="star" onclick="changeStarColor(3)">&#9734;</span>
  		<span class="star" onclick="changeStarColor(4)">&#9734;</span>
  		<span class="star" onclick="changeStarColor(5)">&#9734;</span>	
	</div>
	<input type = "hidden" id="ratingValue" name="ratingValue">
	<input type="text" name="title_artwork" value = "<%=dto.getTitle() %>">
	<a>사진바꾸기</a><br/>
	<input type="file" name="imageFile" accept="image/*" id="imageInput">
	<button type = submit> 업로드</button>
</form>

</div>
</body>
