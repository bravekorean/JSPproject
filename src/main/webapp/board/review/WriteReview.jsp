<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="review.css" rel="stylesheet" type="text/css" />
<link href="../header.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!-- 공통메뉴 -->
<%@include file = "../header.jsp" %>

<script src="rating.js"></script>

<div class="review-box">
<form action="uploadProcess.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateForm(this);">
	<input type="text" name="title" placeholder ="제목을 입력해주세요.">
	<span id = "titleError" style="color:red"></span>
	<hr style="color: #dfe5ed;">
	
	<input type="text" name="content" placeholder ="내용을 입력해주세요.">
	<span id = "contentError" style="color:red"></span>
	<div class="rating">
		<a>rating</a>
  		<span class="star" onclick="changeStarColor(1)">&#9734;</span>
  		<span class="star" onclick="changeStarColor(2)">&#9734;</span>
  		<span class="star" onclick="changeStarColor(3)">&#9734;</span>
  		<span class="star" onclick="changeStarColor(4)">&#9734;</span>
  		<span class="star" onclick="changeStarColor(5)">&#9734;</span>	
	</div>
	<span id = "ratingError" style="color:red"></span>
	<input type = "hidden" id="ratingValue" name="ratingValue">
	<input type="text" name="title_artwork" placeholder="작품 이름을 입력해주세요.">
	<span id = "artworkTitleError" style="color:red"></span>
	<a>사진올리기</a>
	<input type="file" name="imageFile" accept="image/*">
	<button type = submit> 업로드</button>
</form>
			<script type="text/javascript" src="validateForm.js"></script>

</div>
</body>
</html>