<%@page import="ticket.cinfoDTO"%>
<%@page import="ticket.ticketDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="ticket.ticketDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 ticketDAO dao = new ticketDAO(application);
//ticketDTO dto = new ticketDTO();
Map<String,Object> param = new HashMap<String,Object>();
String userid = (String) session.getAttribute("UserId");
String thumb = (String) session.getAttribute("thumb");
int totalcount = dao.ticketNumcount(param);
int totalcount1 = dao.cinfoNumcount(param);
List<ticketDTO> ticketinfolist = dao.selectTicketinfo(param,userid);
List<cinfoDTO> payinfolist = dao.selectCinfo(param,userid);
dao.close();
String merchant_uid = "";
int amount = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../../LogIn_LogOut/Login.css" rel="stylesheet" type="text/css" />
<link href="../../mypage/mypage.css" rel="stylesheet" type="text/css" />
<link href="ticketinfo.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
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
	      $("#up_date").val(dateText);
	    }
	  });
	});
  
$("#delete_datepicker").datepicker ( {
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
$(function() {
$("#delete_datepicker").datepicker({
	onSelect: function(dateText, inst) {
		$("#de_date").val(dateText);
	}
});	
});
</script>
<title>예매/결제내역</title>
</head>
<body link="#ff0000" alink = "#00ff00" vlink="#0000ff">

<div id = "main">
<div class="logo"> 
	<a href="../../Main.jsp" target="_blank" title="메인화면"><img src="../../image/로고.png"
class="image"></a><br>
</div>
<hr>
<div class="backbutton"> 
  <br>
  <form action="updateticketinfoProcess.jsp" method="post" class="updateform">
    <details class="updateinfoform">
      <summary>예매변경</summary>
      <p class ="notice">변경할 날짜를 클릭해주시고, 변경할 시간을 선택해 주세요. </p>
      <div id="datepicker"></div>
      <div id="radioContainer">
        <label for="ctime1" class="radio-label">
          <input type="radio" id="ctime1" name="up_time" value="1">
          <span>14:00</span>
        </label><!--  1회차 -->
        <label for="ctime2" class="radio-label">
          <input type="radio" id="ctime2" name="up_time" value="2">
          <span>17:00</span>
        </label>
        <p class ="notice">예매코드를 입력해주세요. </p>
        예매코드 : <input type = "text" id = up_code name = up_code>
        <br>
        <br>
	      <button type = "submit" class = "updatebutton"> 변경하기 </button>
      </div>
      <input type="hidden" id="up_date" name="up_date">
    </details>
  </form>
  
  <br>
  <form action = "deleteticketinfoProcess.jsp" method ="post" class = "deleteform">
  <details class = "deleteinfoform">
   <summary>예매취소</summary>
   <p class = "notice">예매코드를 입력해주시고, 환불을 위해서 결제정보의 결제코드를 입력해주세요. </p> <!--  시퀀스짱!!!!!! -->
  		
  		 예매코드 : <input type = "text" id = de_impuid name = de_code> 
        <br>
        결제코드 <input type = "text" id = de_paycode name = de_paycode>
        <br>
        <br>
	    <button type = "submit" class = "deleteutton"> 취소하기 </button>
  </details>
  </form>
  
  <br>
▶<a href="../../mypage/mypage.jsp" class="backbutton">돌아가기</a>
</div>
<div class = "ticketinfo"> <!--  예매내역 -->
<h1>예매내역 </h1>
  <table class="rwd-table">
    <tbody>
      <tr>
      	<th>예매코드</th>
        <th>작품 번호</th>
        <th>예매자 아이디</th>
        <th>예매자 휴대폰번호</th>
        <th>예매일자</th>
        <th>입장시간</th>
        <th>예매정보</th>
      </tr>
   <%if (ticketinfolist.isEmpty()) { %>
   <tr>
   		<td data-th="Supplier Code">
   		  예매 내역이 없습니다.
   		</td>
   	</tr>
  <%} else { 
	  int virtualNum = 0;
	  int time;
	  String age;
	  for(ticketDTO dto : ticketinfolist) {
		  virtualNum = totalcount--;
		
		  // 정수로 받아왔기때문에 숫자에 맞게 유형을 정해줘야함.
		  if(dto.getTime() == 1) {
			  time = 14;
		  } else {
			  time = 17;
		  }
		  
		  if(dto.getAge() == 1) {
			  age = "성인";
		  } else if (dto.getAge() == 2) {
			  age = "청소년";
		  } else if (dto.getAge() == 3) {
			  age = "아동";
		  } else {
			  age = "노인";
		  }
		  
%>
      <tr> <!--  작품 번호 -->
      	<td data-th="Supplier Code">
      	<%= dto.getNum() %>
      	</td>
        <td data-th="Supplier Code">
         <a href = "../exhibition/exhibitionDetail.jsp?seq=<%=dto.getProductinfo()%>&thumb=<%=thumb%>"><%=dto.getProductinfo()%> </a>
        </td>
        <!--  예매자 아이디 -->
        <td data-th="Supplier Name">
          <%=dto.getUserid() %>
        </td>
        <!--  예매자 휴대폰번호 -->
        <td data-th="Invoice Number">
         <%=dto.getPhonenumber() %>
        </td>
        <!--  예약 날짜 -->
        <td data-th="Invoice Date">
           <%=dto.getRegidate()%> 
        </td>
        <!--  회차 -->
        <td data-th="Due Date">
          <%= time %> : 00
        </td>
        <!-- 가격  -->
        <td data-th="Net Amount">
          <%= age %>/<%=dto.getPrice() %>
        </td>
      </tr>
      
      <% }}  %>
</table>
</div>
<p class = "notice">작품번호를 클릭하시면 상세페이지로 이동합니다. </p>
<p class = "notice">예매변경은 예매일자, 입장시간 변경만 가능합니다. </p>
<p class = "notice">예약취소시 환불까지 2~3일(영업일기준)정도 소요됩니다.</p>
<br>
<br>

<div class = "payinfo"> <!-- 결제정보 --> 
<h1>결제정보 </h1>
  <table class="rwd-table">
    <tbody>
      <tr>
        <th>결제 코드 </th>
        <th>결제자 아이디</th>
        <th>결제자 휴대폰번호</th>
        <th>결제한 가격</th>
        <th>결제 유형</th>
      </tr>
      <%if (payinfolist.isEmpty()) { %>
      <tr>
   		<td data-th="Supplier Code">
   		  예매 내역이 없습니다.
   		</td>
   	</tr>
<% } else {  
	int virtualnum = 0;
	
for (cinfoDTO dto : payinfolist) { 
	merchant_uid = dto.getMerchant_uid();
	amount = dto.getAmount();
	virtualnum = totalcount1--;%> 
      <tr>
        <td data-th="Supplier Code">
          <%= dto.getImp_uid() %>
        </td>
        <td data-th="Supplier Name">
          <%= dto.getBuyer_name() %>
        </td>
        <td data-th="Invoice Number">
          <%= dto.getBuyer_tel() %>
        </td>
        <td data-th="Invoice Date">
          <%= dto.getAmount() %>
        </td>
        <td data-th="Due Date">
          <%= dto.getPay_method() %>
        </td>
      </tr>
<% }} %>
</table>
</div>
<br>
<br>
<footer>
<%@include file="../../footer/footer.jsp"%>
</footer>
</div>

</body>
</html>