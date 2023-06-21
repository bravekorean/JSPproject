<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.xml.sax.InputSource" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="utils.callinfo" %>
<%@ page import="utils.callAPI" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="exhi.exhiDetailDTO" %>
<%@ page import="exhi.exhiDTO" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"  %>

<%
String userid;
String userphonenumber;
if ((String)session.getAttribute("UserId") == null && (String)session.getAttribute("Userphonenumber") == null) {
	userid = "null";
	userphonenumber = "null";
} else {
	
userid = (String)session.getAttribute("UserId");
userphonenumber = (String)session.getAttribute("UserPhonenumber");
}

String seq = request.getParameter("seq");
String thumb = request.getParameter("thumb");
session.setAttribute("thumb",thumb);
String serviceKey = "cKJJepR6t5fqno1sj6HBXC7eGXMU4lc5Fgh5895eaEBfkz7one0Zt9hHVxkdg983tk5IYVXs8wYF5%2FabbHvzow%3D%3D";

callinfo infoapi = new callinfo(serviceKey,seq);
exhiDTO dto = new exhiDTO(thumb);
String responseData = infoapi.getData();

// XML 파싱
DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
DocumentBuilder builder = factory.newDocumentBuilder();
Document document = builder.parse(new InputSource(new java.io.StringReader(responseData)));
//System.out.println("XML Response Data: " + responseData);

// 응답 파라미터 추출
Element responseElement = (Element) document.getElementsByTagName("response").item(0);
Element msgBodyElement = (Element) responseElement.getElementsByTagName("msgBody").item(0);

// 공연 목록 추출
NodeList perforInfo = document.getElementsByTagName("perforInfo");
// 공연 목록을 담을 리스트 생성
List<exhiDetailDTO> perforItems = new ArrayList<>();

// 공연 정보를 객체로 변환하여 리스트에 추가 
for (int i = 0; i < perforInfo.getLength(); i++) {
	Node perforItem = perforInfo.item(i);
	String title = ((Element) perforItem).getElementsByTagName("title").item(0).getTextContent();
	String place2 = ((Element) perforItem).getElementsByTagName("place").item(0).getTextContent();
	String startDate = ((Element) perforItem).getElementsByTagName("startDate").item(0).getTextContent();
	String endDate = ((Element) perforItem).getElementsByTagName("endDate").item(0).getTextContent();
	String realmName = ((Element) perforItem).getElementsByTagName("realmName").item(0).getTextContent();
	String area = ((Element) perforItem).getElementsByTagName("area").item(0).getTextContent();
	String subTitle = ((Element) perforItem).getElementsByTagName("subTitle").item(0).getTextContent();
	String price = ((Element) perforItem).getElementsByTagName("price").item(0).getTextContent();
	String contents1 = ((Element) perforItem).getElementsByTagName("contents1").item(0).getTextContent();
	String contents2 = ((Element) perforItem).getElementsByTagName("contents2").item(0).getTextContent();
	String url = ((Element) perforItem).getElementsByTagName("url").item(0).getTextContent();
	String phone = ((Element) perforItem).getElementsByTagName("phone").item(0).getTextContent();
	String gpsX = ((Element) perforItem).getElementsByTagName("gpsX").item(0).getTextContent();
	String gpsY = ((Element) perforItem).getElementsByTagName("gpsY").item(0).getTextContent();
	String imgurl = ((Element) perforItem).getElementsByTagName("imgUrl").item(0).getTextContent();
	String placeurl = ((Element) perforItem).getElementsByTagName("placeUrl").item(0).getTextContent();
	String placeAddr = ((Element) perforItem).getElementsByTagName("placeAddr").item(0).getTextContent();
	String placeseq = ((Element) perforItem).getElementsByTagName("placeSeq").item(0).getTextContent();

	perforItems.add(new exhiDetailDTO(seq, title, place2, startDate, endDate, realmName, area, subTitle, price,
	contents1, contents2, url, phone, gpsX, gpsY, imgurl, placeurl, placeAddr, placeseq));

}
%>
<!DOCTYPE html>
<html>
<head>
<link href="../header.css" rel="stylesheet" type="text/css" />
<link href="ticket.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<meta charset="UTF-8">

<title>예매하기</title>

<!-- 달력 -->
<script>
$.datepicker.setDefaults({
	  dateFormat: 'yy-mm-dd',
	  autoclose : true, 
	  todayHighlight :true,  // 오늘을 표시해줄지. default 가 false
	  endDate: '+90d', // 선택할 수 있는 최대 일자 
	  minDate: 0,
	  prevText: '이전 달',
	  nextText: '다음 달',
	  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	  showMonthAfterYear: true,
	  yearSuffix: '년'
	});
  $(function(){
	// datepicker 초기화
	  $("#datepicker").datepicker({
	    onSelect: function(dateText, inst) {
	      // 선택한 날짜를 hidden input에 설정
	      $("#cdate").val(dateText);
	    }
	  });
	});
</script>

</head>
<body>

<!-- 공통메뉴 -->
<%@include file="../header.jsp"%>
<section id="All-content">

	<!--  상세이미지 -->
	<div id="info-A">
		<img class="img-title1" src="<%=dto.getThumbnail()%>" alt="썸네일" />
	
	<!-- 정보 -->
	<div id="info">
		<%
		for (exhiDetailDTO perforItem : perforItems) {
		%>
			<h2><%=perforItem.getTitle()%></h2><br>
			 장소 :<%=perforItem.getPlace()%><br>
			 날짜 :<%=perforItem.getStartDate()%>~<%=perforItem.getEndDate()%><br>
			 장르 :<%=perforItem.getRealmName()%><br>
			 지역 :<%=perforItem.getArea()%><br> 
			 가격 :<%=perforItem.getPrice()%><br>
			 예약처 :<a href="<%=perforItem.getUrl()%>"><%=perforItem.getUrl()%></a><br>
			 고객문의 :<%=perforItem.getPhone()%>
		<%
		}
		%>
	</div>	
</div>
	<div id="paysubmit">
		<form action="ticketProcess.jsp" method="post" name="customer_info_form">
			<div id="datepicker"></div>
				<!--  관람일 -->
				<input type="hidden" id="cdate" name="customer_date">
				<br>
				<h2>회차</h2>
				<br>
				<!--  1회차 -->
				<input type="radio" id="ctime" name="customer_time" value="1"> 14:00
				<!--  2회차 -->
				<input type="radio" id="ctime" name="customer_time" value="2"> 17:00
				<br><br>
				
				<!--  연령대 구별 -->
				<h2>연령대</h2>
				<br>
				<input type="checkbox" id="cage" name="customer_age" value="1">성인
				<input type="checkbox" id="cage" name="customer_age" value="2">청소년
				<input type="checkbox" id="cage" name="customer_age" value="3">아동
				<input type="checkbox" id="cage" name="customer_age" value="4">노인 
				<br><br>
				
				<!-- 결제 방법 -->
				<h2>결제 유형</h2>
				<br>
				<input type = "radio" id = "pinfo" name = "payinfo" value = "1" checked = "checked" >카카오페이
				<!--<input type = "radio" id = "pinfo" name = "payinfo" value = "2">무통장입금 -->
				<br>
			<%for (exhiDetailDTO perforItem : perforItems) { %>
				<input type="hidden" name="customer_seq" value="<%= perforItem.getSeq() %>">
		 		<input type="hidden" name="customer_title" value = "<%= perforItem.getTitle() %>">
			<% } %>
		
				<input type = "hidden" id = "c_userid" name = "check_userid" value = <%= userid %>> <!-- 세션값으로 받아온 userid -->
				<input type = "hidden" id = "c_userphonenubmer" name = "check_userphonenumber" value = <%= userphonenumber %>> 
				<!--  세션값으로 받아온 userPhonenumber -->
				<br>
				<button type = "button" class = "paysbutton" onclick="checkForms()">결제하기</button> 
			</form>
<script>
		function checkForms() {

	  		var userid = '<%= userid %>';
	  		var userphonenumber = '<%= userphonenumber %>';
						
	  
	  					// userid 값이 null인 경우 
						// 데이터 타입과 내용까지 비교하기위해 ===를 썼음.
						
						if (userid === null) {
							alert("로그인 해주십시오.");
							// Login.jsp로 이동
							window.location.href = "../../LogInLogOut/Login.jsp";
						} else {
							// userid 값이 null이 아닌 경우
							// customer_info 폼의 필드들을 payinfo 폼에 추가
							//  for (var i = 0; i < customerInfoForm.elements.length; i++) {
							//  var element = customerInfoForm.elements[i];
							//var clone = element.cloneNode(true);
							//clone.name = "customer_" + element.name; // 이름을 변경하여 중복 방지
							//payInfoForm.appendChild(clone);
							// ticketprocess.jsp로 이동
							payInfoForm.submit();
						}
					}}
				</script>
			</div>
	</section>
	
<!-- 공통footer -->
<%@include file="../../footer/footer.jsp"%>
</body>
</html>