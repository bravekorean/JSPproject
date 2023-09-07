<%@page import="java.util.LinkedList"%>
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
<%@ page import="utils.callAPI" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="exhi.exhiDTO" %>

<%
String sortParam = request.getParameter("sort");
String cPageParam = request.getParameter("cPage");
if (sortParam != null && !sortParam.isEmpty()) {
    session.setAttribute("sort", sortParam);
}
if (cPageParam != null && !cPageParam.isEmpty()) {
	session.setAttribute("cPage", cPageParam);
}
    // API 호출 및 XML 파싱
    String serviceKey = "{service.key}";
	String sortkey = "1";
    String iPage = "1";
	if (session.getAttribute("sort") != null) {
	    sortkey = (String) session.getAttribute("sort");
	}
	if (session.getAttribute("cPage") != null) {
		iPage = (String) session.getAttribute("cPage");
	}
    		
    callAPI api = new callAPI(serviceKey, sortkey, iPage);
    String responseData = api.getData();
	

   
    // 정렬관련 매개변수 
    

    // XML 파싱
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance(); // 인스턴스 생성, XML 파서를 생성하기위한 팩토리패턴 제공
    DocumentBuilder builder = factory.newDocumentBuilder(); // 팩토리로부터 인스턴스를 생성, XML 파싱을 수행함
    Document document = builder.parse(new InputSource(new java.io.StringReader(responseData))); 
   
    // bulilder.parse를 생성해서 Stringreader로 문자열 데이터를 inputsource로 변환함. Dom객체를 생성함 
    //System.out.println("XML Response Data: " + responseData);

    // 응답 파라미터 추출
    Element responseElement = (Element) document.getElementsByTagName("response").item(0);
    Element msgBodyElement = (Element) responseElement.getElementsByTagName("msgBody").item(0);
    String totalCount = msgBodyElement.getElementsByTagName("totalCount").item(0).getTextContent();
    String from = msgBodyElement.getElementsByTagName("from").item(0).getTextContent();
    String to = msgBodyElement.getElementsByTagName("to").item(0).getTextContent();
    String cPage = msgBodyElement.getElementsByTagName("cPage").item(0).getTextContent();
    String rows = msgBodyElement.getElementsByTagName("rows").item(0).getTextContent();
    String place = msgBodyElement.getElementsByTagName("place").item(0).getTextContent();
    String gpsxfrom = msgBodyElement.getElementsByTagName("gpsxfrom").item(0).getTextContent();
    String gpsyfrom = msgBodyElement.getElementsByTagName("gpsyfrom").item(0).getTextContent();
    String gpsxto = msgBodyElement.getElementsByTagName("gpsxto").item(0).getTextContent();
    String gpsyto = msgBodyElement.getElementsByTagName("gpsyto").item(0).getTextContent();
    
    // 정렬 정보가 담긴 응답 파라미터 추출
    

    
    
// 페이징 처리
int totalcount1 = Integer.parseInt(totalCount);
int pagesize = Integer.parseInt(rows);
int blockPage = 10; // 한번에 보여줄 페이지 개수
int pageNum = Integer.parseInt(cPage);
int totalPage = (int) Math.ceil((double) totalcount1 / pagesize);

// 페이지 번호 계산
int startPage = ((pageNum - 1) / blockPage) * blockPage + 1;
int endPage = Math.min(startPage + blockPage - 1, totalPage);

// 현재 페이지 번호가 총 페이지 개수를 초과하지 않도록 조정
pageNum = Math.min(pageNum, totalPage);

String pagetemp = request.getParameter("pageNum");
if (pagetemp != null && !pagetemp.equals("")) {
    pageNum = Integer.parseInt(pagetemp);
}

    // 공연 목록 추출
    NodeList perforList = document.getElementsByTagName("perforList");
 // 공연 목록을 담을 리스트 생성
    List<exhiDTO> perforItems = new ArrayList<>();
    List<exhiDTO> perforStems = new ArrayList<>();
    // 공연 정보를 객체로 변환하여 리스트에 추가 
    for (int i = 0; i < perforList.getLength(); i++) {
        Node perforItem = perforList.item(i);
        String seq = ((Element) perforItem).getElementsByTagName("seq").item(0).getTextContent();
        String title = ((Element) perforItem).getElementsByTagName("title").item(0).getTextContent();
        String place2 = ((Element) perforItem).getElementsByTagName("place").item(0).getTextContent();
        String startDate = ((Element) perforItem).getElementsByTagName("startDate").item(0).getTextContent();
        String endDate = ((Element) perforItem).getElementsByTagName("endDate").item(0).getTextContent();
        String realmName = ((Element) perforItem).getElementsByTagName("realmName").item(0).getTextContent();
        String area = ((Element) perforItem).getElementsByTagName("area").item(0).getTextContent();
        String thumbnail = ((Element) perforItem).getElementsByTagName("thumbnail").item(0).getTextContent();
        String gpsX = ((Element) perforItem).getElementsByTagName("gpsX").item(0).getTextContent();
        String gpsY = ((Element) perforItem).getElementsByTagName("gpsY").item(0).getTextContent();
        perforItems.add(new exhiDTO(seq, title, place2, startDate, endDate, realmName, area, thumbnail, gpsX, gpsY));
        
        
        session.setAttribute("title"+i, title);
        session.setAttribute("place"+i, place);
        session.setAttribute("startDate"+i, startDate);
        session.setAttribute("endDate"+i,endDate);
        session.setAttribute("area"+i, area);
        session.setAttribute("realName"+i, realmName);
        session.setAttribute("thumbnail"+i, thumbnail);
        session.setAttribute("seq"+i, seq);
    }
    

        session.setAttribute("length", perforList.getLength());
    
%>
<!DOCTYPE html>
<html>
<head>
<link href="../header.css" rel="stylesheet" type="text/css" />
<link href="../exhibition/Extibition.css" rel="stylesheet" type="text/css" />
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta charset="UTF-8">
<title>전체</title>
</head>

<body>
<%@include file = "../header.jsp" %>

<section id = "wrap">
<!-- 지역별 메뉴 -->
<form method = "get">
<div class="area-d">
<p class="ma">지역 : </p>
<a href="all.jsp" class="ma">전체</a>
<a href="allArea.jsp?sido=서울" class="ma">서울</a>
<a href="allArea.jsp?sido=경기" class="ma">경기</a>
<a href="allArea.jsp?sido=충북" class="ma">충북</a>
<a href="allArea.jsp?sido=충남" class="ma">충남</a>
<a href="allArea.jsp?sido=전북" class="ma">전북</a>
<a href="allArea.jsp?sido=전남" class="ma">전남</a>
<a href="allArea.jsp?sido=경북" class="ma">경북</a>
<a href="allArea.jsp?sido=경남" class="ma">경남</a>
<a href="allArea.jsp?sido=인천" class="ma">인천</a>
<a href="allArea.jsp?sido=부산" class="ma">부산</a>
<a href="allArea.jsp??sido=울산" class="ma">울산</a>
<a href="allArea.jsp?sido=대구" class="ma">대구</a>
<a href="allArea.jsp?sido=강원" class="ma">강원</a>
<a href="allArea.jsp?sido=제주" class="ma">제주</a>
<div class = "sort-d">
<a href="all.jsp?sort=1" class ="la">등록일순</a>
<a href="all.jsp?sort=2" class ="la">공연명순</a>
</div>
</div>
</form>
<br>



<%for (exhiDTO perforItem : perforItems) { %>
<div class="card">
	<div  class="card-img">
  		<img src="<%= perforItem.getThumbnail() %>" class="card-img-top" alt="Thumbnail">
	</div>
    <div class="card-head">
		<h4 class="card-title"><%= perforItem.getTitle() %></h4>
    </div>
    <hr>
    <div class="card-main">
		<p class="card-text">지역 : <%= perforItem.getArea() %> <br>
		장소 : <%= perforItem.getPlace() %> <br> 
		날짜 : <%= perforItem.getStartDate() %>~<%= perforItem.getEndDate() %></p>
    </div>
    <form action = "../exhibition/exhibitionDetail.jsp" method = "post">
    <input type = "hidden" name = "seq" value = "<%=perforItem.getSeq()%>">
    <input type = "hidden" name = "thumb" value = "<%=perforItem.getThumbnail()%>">
    <div class="card-footer">
  		<button type="submit" onclick="location.href='exhibition/exhibitionDetail.jsp'">상세보기</button>
    </div>
    </form>
    </div>

<% } %>



</section>


<footer>

 <!-- 페이징 처리 -->
   <div class="pagination">
        <ul>

       <!-- 이전 페이지 링크 -->
        <% if (startPage > blockPage) { %>
            <li><a href="all.jsp?cPage=<%= startPage - blockPage %>&sort=<%=sortkey%>">&laquo;</a></li>
        <% } else { %>
            <li><a href="all.jsp?cPage=1&sort=<%=sortkey%>">&laquo;</a></li>
        <% } %>

        <!-- 페이지 번호 링크 -->
        <% for (int i = startPage; i <= endPage; i++) { %>
            <% if (i == pageNum) { %>
                <li class="active"><a href="#"><%= i %></a></li>
            <% } else { %>
                <li><a href="all.jsp?cPage=<%= i %>&sort=<%=sortkey%>"><%= i %></a></li>
            <% } %>
        <% } %>

        <!-- 다음 페이지 링크 -->
        <% if (endPage < totalPage) { %>
            <li><a href="all.jsp?cPage=<%= startPage + blockPage %>&sort=<%=sortkey%>">&raquo;</a></li>
        <% } else { %>
            <li><a href="all.jsp?cPage=<%= totalPage %>&sort=<%=sortkey%>">&raquo;</a></li>
        <% } %>
            
        </ul>
    </div>
<br>
<%@include file = "../../footer/footer.jsp" %>
</footer>
</body>
</html>
