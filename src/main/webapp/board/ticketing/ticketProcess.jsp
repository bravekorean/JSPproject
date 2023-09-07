<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date" %>
<%@page import ="java.sql.*" %>
<%@page import="ticket.ticketDTO"%>
<%@page import="ticket.ticketDAO"%>
<%@page import="ticket.cInfo" %>
<%@page import="utils.JSFunction"%>
<%@ page import="membership.MemberDTO" %>
<%@ page import="membership.MemberDAO" %>
<%@ page import="common.JDBCConnect" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% 
// DB 연결 
 Connection con;
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");


// 파라미터 받아오기 
String title = request.getParameter("customer_title");
String dateparam = request.getParameter("customer_date");
//out.println("dateparam: " + dateparam);
String seq = request.getParameter("customer_seq");
String timeparam = request.getParameter("customer_time"); // 배열의 첫번째 자리만 값만 들고옴.
String ageparam = request.getParameter("customer_age"); // 배열의 첫번째 자리만 들고옴 
String uid = request.getParameter("check_userid");
String upnb = request.getParameter("check_userphonenumber");
String payparam = request.getParameter("payinfo"); // 위에와 마찬가지

java.sql.Date date1;

if(dateparam != null) {
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date utilDate = dateFormat.parse(dateparam);
java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
date1 = sqlDate;
//out.println(date1);
} else {
	JSFunction.alertBack("오류가있습니다.",out);
	return;
}


int price;
int payinfo;
int time;
int age;
if ("1".equals(timeparam)) {
	time = 1; // 1회차
	
} else {
	time = 2; // 2회차
}
if ("1".equals(ageparam)) {
	age = 1; // 성인
}  else if ( "2".equals(ageparam)) {
	age = 2; // 청소년
} else if ( "3".equals(ageparam)) {
   age = 3;
} else {
	age = 4;
}
if ("1".equals(ageparam)) {
	price = 15000; // 성인일경우
} else if ("2".equals(ageparam)) {
	price = 10000; // 청소년
}  else {
	price = 6000; // 노약자 및 어린이
}

if ("1".equals(payparam)) {
	payinfo = 1;
} else {
	payinfo = 2;
}

// DAO

//ticketDAO dao = new ticketDAO(oracleDriver,oracleURL,oracleId,oraclePwd);

//boolean result  = dao.insertInfoDTO(uid,upnb,price,payinfo,time,age,seq,date1);

//dao.close();
//if(!result) {
	//JSFunction.alertBack("결제를 진행할 수 없습니다.", out);
//} else {
	

 
 
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script> <!-- 포트원 결제 api  -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script> <!--  jQuery 라이브러리 -->
<title>예매처리</title>
</head>
<body>
<script>
window.addEventListener('load',function() {
requestPay();
});
//const IMP = window.IMP; // 생략 가능

function requestPay() {
	
	const merchant_uid = 'TRD' + new Date().getTime() + '-' + Math.floor(Math.random() * 1000000);
	
	IMP.init("{test.code}"); // 테스트코드
	
    IMP.request_pay(
   {
      pg: "kakaopay",
      pay_method: "card", // 결제 수단
      merchant_uid: merchant_uid,   // 주문번호
      name:"<%= title %>",
      amount: <%= price %>,                         // 숫자 타입
      buyer_name: "<%= uid %>",						
      buyer_tel: "<%= upnb %>"
    }, function (rsp) { // callback
      //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
      if(rsp.success) {
    	  // 결제 성공시 
    	  // jQuery로 HTTP 요청 
    	  $.ajax ( {
    		  url:"/Trandirrupt_Project(v3.1.1)/cInfo", // 웹서블렛으로 매핑한  data를  cInfo.java에 전달함. 
    		  method:'POST',
    		  data : {
    			  imp_uid : rsp.imp_uid,
    			  merchant_uid : rsp.merchant_uid,
    	  		  paid_amount : rsp.paid_amount,
    	  		  pay_method : rsp.pay_method,
    	  		  buyer_name : rsp.buyer_name,
    	  		  buyer_tel : rsp.buyer_tel
    	  		  
    		  }
      }).done(function (data) { // 성공했을 경우
    	  <%
    	  ticketDAO dao = new ticketDAO(oracleDriver,oracleURL,oracleId,oraclePwd);
		  boolean result  = dao.insertInfoDTO(uid,upnb,price,payinfo,time,age,seq,date1);
		  dao.close();
		 if(!result) {
		 JSFunction.alertBack("결제를 진행할 수 없습니다.", out); } %>
		  alert("결제가 완료되었습니다.");
		  console.log('결제 응답정보가 서버에 저장 되었습니다.') 
    	  location.href = '../../mypage/mypage.jsp'; // 예매내역 페이지로 바꾸기 ~~ 
		  
	  })
      } else {
    	  const error_msg = rsp.error_msg; // 실패 메시지
          alert('결제 실패: ' + error_msg);
    	  location.href = '../../Main.jsp';
      }
      
    });
  }
</script>

</body>
</html>
