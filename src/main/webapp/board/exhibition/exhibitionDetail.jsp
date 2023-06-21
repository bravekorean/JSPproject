<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    // API 호출 및 XML 파싱
    String serviceKey = "cKJJepR6t5fqno1sj6HBXC7eGXMU4lc5Fgh5895eaEBfkz7one0Zt9hHVxkdg983tk5IYVXs8wYF5%2FabbHvzow%3D%3D";
   	String seq = request.getParameter("seq");
    callinfo info = new callinfo(serviceKey,seq);
   	String thumb = request.getParameter("thumb");
    exhiDTO dto = new exhiDTO(thumb);
    String responseData = info.getData();

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
        
        

        perforItems.add(new exhiDetailDTO(seq, title, place2, startDate, endDate, realmName, area, subTitle,price,contents1,contents2,url,phone,gpsX
       ,gpsY,imgurl,placeurl,placeAddr,placeseq));
        
        
        
        
    }
    
%>

<!DOCTYPE html>
<html>
<head>
<link href="../header.css" rel="stylesheet" type="text/css" />
<link href="exhibitionDetail.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=32d50ac7ae928efed6cd0fda2a10ee03&libraries=services"></script>
<meta charset="UTF-8">
<title>상세 정보</title>
</head>
<body>

<%@include file = "../header.jsp" %>

<section>

<!--  상세이미지 -->
<div class = "image">
<img class = "img-title" src="<%= dto.getThumbnail() %>" alt = "썸네일" />
</div>

<div class = "info">

<%for (exhiDetailDTO perforItem : perforItems) { %>
	<h2><%=perforItem.getTitle() %></h2>
	<br>
	장소 : <%=perforItem.getPlace() %>
	<br>
	날짜 : <%=perforItem.getStartDate() %>~<%=perforItem.getEndDate() %>	
	<br>
	장르 : <%=perforItem.getRealmName() %>
	<br>
	지역 : <%=perforItem.getArea() %>
	<br>
	가격 : <%=perforItem.getPrice() %>
	<br>
	예약처 :<a href = "<%=perforItem.getUrl() %>"><%=perforItem.getUrl() %></a>
	<br>
	고객문의 : <%=perforItem.getPhone() %>
	</div>
	
<div class="rt">
<button type = "submit" onclick = "location.href='../ticketing/ticketform.jsp?seq=<%= seq %>&thumb=<%= thumb %>'">예매하기</button>
</div>
<div class = "back">
<button type = "submit" onclick = "history.back()">뒤로가기</button>

</div>
</section>

<!-- 유의사항 -->
<h3 class="warning">유의사항</h3>
<div class ="viewpage_text radius_box">
<p>·&nbsp;퇴장 후 재입장 불가</p>
<p>·&nbsp;전시장 내 음료 및 음식물 반입 금지</p>
<p>·&nbsp;미취학 아동(36개월 이상)은 반드시 보호자 동반 후 입장 가능</p>
<p>·&nbsp;큰소리 금지 및 대화 자제</p>
<p>·&nbsp;가방 사이즈는 148X210mm 내로 전시장 반입이 허용됩니다. 그 이상의 크기의 소지품은 물품보관함에 맡겨주시길 바랍니다.</p>
<p class="red">※ 유효기간 만료 후 환불 불가</p>
</div>

<!-- 지도api -->

<h3 class="place">장소안내</h3>
<div class="place_box place_text">

<p>·&nbsp; <%=perforItem.getPlaceAddr() %></p>
<div id ="map" style="width:500px;height:400px;">


<!-- 지도 -->
<script>

var container = document.getElementById('map'); // 지도를 표시할 div
var options = {
	center: new kakao.maps.LatLng(<%= perforItem.getGpsY()%>, <%= perforItem.getGpsX()%>), // 지도의 중심 위도,경도
	level: 3 
}; // 지도 확대 레벨

var map = new kakao.maps.Map(container, options);
// 마커카 표시될 위치
var markerPosition  = new kakao.maps.LatLng(<%= perforItem.getGpsY()%>, <%= perforItem.getGpsX()%>); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

//아래 코드는 지도 위의 마커를 제거하는 코드입니다
//marker.setMap(null);  
</script>
</div>
</div>
<br>
<% } %>

<!-- 공통footer -->
<%@include file = "../../footer/footer.jsp" %>

</body>
</html>