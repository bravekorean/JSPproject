<%@page import="java.io.InputStream"%>
<%@page import="exhi.exhiDTO"%>
<%@page import="review.reviewDTO"%>
<%@page import="review.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
String id = (String)session.getAttribute("UserId");
int num = Integer.parseInt(request.getParameter("num"));
String check = (String)session.getAttribute(id+num);
reviewDAO dao = new reviewDAO(application);
dao.updateVisitCount(num);
reviewDTO dto = dao.getReviewByNum(num);
String star = "";
for(int i = 0; i < dto.getRating();i ++){
	star += "&#9734; ";
}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../header.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function deletePost() {
    var confirmed = confirm("정말로 삭제하겠습니까?");
    if (confirmed) {
        var form = document.writeFrm;
        form.method = "post";
        form.action = "DeleteProcess.jsp?num=<%=num%>";
        form.submit();
    }
}
function updateLike() {
	  var checkValue = '<%=check%>';

	  if (checkValue == 'null') {
	    var form = document.writeFrm;
	    form.method = "post";
	    form.action = "UpdateLikeProcess.jsp?num=<%=num%>";
	    form.submit();
	  }

	  if (checkValue == "check") {
	    var form = document.writeFrm;
	    form.method = "post";
	    form.action = "UnLikeProcess.jsp?num=<%=num%>";
	    form.submit();
	  }
	}
</script>

<style>
.hidden {
  display: none;
}
</style>
<link href="../all/Extibition.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class = "hidden">
<jsp:include page="../all/all.jsp"/></div>


<%
request.setCharacterEncoding("UTF-8");
int length = (int)session.getAttribute("length");
String title[]= new String[length];
String place[]= new String[length];
String startDate[]= new String[length];
String endDate[]= new String[length];
String area[]= new String[length];
String realName[]= new String[length];
String thumbnail[]= new String[length];
for(int i = 0; i < length; i ++){
	title[i]=(String)session.getAttribute("title"+i);
	place[i]=(String)session.getAttribute("place"+i);
	startDate[i]=(String)session.getAttribute("startDate"+i);
	endDate[i]=(String)session.getAttribute("endDate"+i);
	area[i]=(String)session.getAttribute("area"+i);
	realName[i]=(String)session.getAttribute("realName"+i);
	thumbnail[i]=(String)session.getAttribute("thumbnail"+i);
}
%>


<%out.println(check); %>
<%@include file = "../header.jsp" %>
<% for (int i = 0; i < length; i ++ ) { 
	if(title[i].equals(dto.getTitle())){ %>
<div class = "image">
<img class = "img-title" src="<%= thumbnail[i] %>" alt = "썸네일" />
</div>
<div class = "info">
	<h2><%=title[i] %></h2>
	<br>
	장소 : <%=place[i] %>
	<br>
	날짜 : <%=startDate[i] %>~<%=endDate[i] %>	
	<br>
	장르 : <%=realName[i] %>
	<br>
	지역 : <%=area[i] %>
</div>
<% 
	}
}
 %>
<form name="writeFrm">
    		<input type="hidden" name="num" value="<%=num %>" />
            <a><%= dto.getTitleR() %></a><br/>
            <a>작성자 : <%= dto.getId()%></a><br/>
            
            <a>번호: <%= dto.getNum() %></a><br/>

            <a>조회수 : <%= dto.getVisitcount() %></a><br/>
            
        	<a>Rating : <%= star + dto.getRating() %></a><br/>
            <a>
             <%=dto.getContent().replace("\r\n", "<br/>") %></a><br/>
     
        	<button type = "button" onclick="updateLike();">&#x2665; <%=dto.getLike_num() %></button>
 			
 			
 			<%
 			if(dto.getData()!=null){
 			InputStream data = dto.getData();

 			String img_data = dao.getBase64Image(data);
 			
 			%>
 			
			<img src="data:image/jpeg;base64,<%=img_data %>" alt="Image"/>
			<%} %>
			
            <div>
                <%
                if (session.getAttribute("UserId") != null
                    && session.getAttribute("UserId").toString().equals(dto.getId())) {
                %>
                <button type="button"
                        onclick="location.href='Edit.jsp?num=<%=dto.getNum() %>';">
                    수정하기</button>
                <button type="button" onclick="deletePost();">삭제하기</button> 
                <%} %>
                <button type="button" onclick="location.href='review.jsp';">
                    전체 보기
                </button>
            </div>


</form>
</body>
</html>