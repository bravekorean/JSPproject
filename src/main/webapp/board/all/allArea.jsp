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
<%@ page import="utils.callgenre" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="exhi.exhiDTO" %>
<%@ page import="common.areasearch" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>


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
    String serviceKey = "cKJJepR6t5fqno1sj6HBXC7eGXMU4lc5Fgh5895eaEBfkz7one0Zt9hHVxkdg983tk5IYVXs8wYF5%2FabbHvzow%3D%3D";
    String realmCode = "";
	String sortkey = "1";
    String iPage = "1";
   	String selectsido = request.getParameter("sido");
   	if (selectsido == null) {
   		selectsido = "";
   	}
	if (session.getAttribute("sort") != null) {
	    sortkey = (String) session.getAttribute("sort");
	}
	if (session.getAttribute("cPage") != null) {
		iPage = (String) session.getAttribute("cPage");
	}
	callgenre api = new callgenre(realmCode,serviceKey,sortkey,iPage);
	areasearch si = new areasearch(selectsido,serviceKey,sortkey,iPage);
    String responseData = api.getData(realmCode,serviceKey);
    String responseData1 = si.selectArea(selectsido,serviceKey,realmCode);
    
   
 
    
    
  

    // XML 파싱
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document document = builder.parse(new InputSource(new java.io.StringReader(responseData)));
    Document document1 = builder.parse(new InputSource(new java.io.StringReader(responseData1)));
    //System.out.println("XML Response Data: " + responseData);

    // 응답 파라미터 추출
    Element responseElement = (Element) document.getElementsByTagName("response").item(0);
    //Element comMsgHeaderElement = (Element) document.getElementsByTagName("ComMsgHeader").item(0);
    Element msgBodyElement = (Element) responseElement.getElementsByTagName("msgBody").item(0);
    String totalCount = msgBodyElement.getElementsByTagName("totalCount").item(0).getTextContent();
    String realmCode1 = msgBodyElement.getElementsByTagName("realmCode").item(0).getTextContent();
    String sido = msgBodyElement.getElementsByTagName("sido").item(0).getTextContent();
    String gugun = msgBodyElement.getElementsByTagName("gugun").item(0).getTextContent();
    String from = msgBodyElement.getElementsByTagName("from").item(0).getTextContent();
    String to = msgBodyElement.getElementsByTagName("to").item(0).getTextContent();
    String cPage = msgBodyElement.getElementsByTagName("cPage").item(0).getTextContent();
    String rows = msgBodyElement.getElementsByTagName("rows").item(0).getTextContent();
    String place = msgBodyElement.getElementsByTagName("place").item(0).getTextContent();
    String gpsxfrom = msgBodyElement.getElementsByTagName("gpsxfrom").item(0).getTextContent();
    String gpsyfrom = msgBodyElement.getElementsByTagName("gpsyfrom").item(0).getTextContent();
    String gpsxto = msgBodyElement.getElementsByTagName("gpsxto").item(0).getTextContent();
    String gpsyto = msgBodyElement.getElementsByTagName("gpsyto").item(0).getTextContent();
    String keyword = msgBodyElement.getElementsByTagName("keyword").item(0).getTextContent();
    String sortStdr = msgBodyElement.getElementsByTagName("sortStdr").item(0).getTextContent();
    
    // 지역검색 응답 파라미터 추출
    Element responseElement1 = (Element) document1.getElementsByTagName("response").item(0);
    //Element comMsgHeaderElement = (Element) document.getElementsByTagName("ComMsgHeader").item(0);
    Element msgBodyElement1 = (Element) responseElement1.getElementsByTagName("msgBody").item(0);
    String totalCoun1 = msgBodyElement1.getElementsByTagName("totalCount").item(0).getTextContent();
    String realmCode2 = msgBodyElement1.getElementsByTagName("realmCode").item(0).getTextContent();
    String sido1 = msgBodyElement1.getElementsByTagName("sido").item(0).getTextContent();
    String gugun1 = msgBodyElement1.getElementsByTagName("gugun").item(0).getTextContent();
    String from1 = msgBodyElement1.getElementsByTagName("from").item(0).getTextContent();
    String to1 = msgBodyElement1.getElementsByTagName("to").item(0).getTextContent();
    String cPage1 = msgBodyElement1.getElementsByTagName("cPage").item(0).getTextContent();
    String rows1 = msgBodyElement1.getElementsByTagName("rows").item(0).getTextContent();
    String place1 = msgBodyElement1.getElementsByTagName("place").item(0).getTextContent();
    String gpsxfrom1 = msgBodyElement1.getElementsByTagName("gpsxfrom").item(0).getTextContent();
    String gpsyfrom1= msgBodyElement1.getElementsByTagName("gpsyfrom").item(0).getTextContent();
    String gpsxto1 = msgBodyElement1.getElementsByTagName("gpsxto").item(0).getTextContent();
    String gpsyto1= msgBodyElement1.getElementsByTagName("gpsyto").item(0).getTextContent();
    String keyword1 = msgBodyElement1.getElementsByTagName("keyword").item(0).getTextContent();
    String sortStdr1 = msgBodyElement1.getElementsByTagName("sortStdr").item(0).getTextContent();
    
    // 페이징 처리 
    int totalcount1 = Integer.parseInt(totalCoun1);
    int pagesize = Integer.parseInt(rows1);
    int blockPage = 10; // 한번에 보여줄 페이지 개수 
    int pageNum = Integer.parseInt(cPage1);
    int totalPage = (int)Math.ceil((double)totalcount1 / pagesize);

  //페이지 번호 계산
    int startPage = ((pageNum - 1) / blockPage) * blockPage + 1;
    int endPage = Math.min(startPage + blockPage - 1, totalPage);
  //현재 페이지 번호가 총 페이지 개수를 초과하지 않도록 조정
    pageNum = Math.min(pageNum, totalPage);

    String pagetemp = request.getParameter("pageNum");
    if (pagetemp != null && !pagetemp.equals("")) {
     pageNum = Integer.parseInt(cPage1);
    }
  // 응답 명세 perforList 형 List로 받아오기
    // 공연 목록 추출
    NodeList perforList = document.getElementsByTagName("perforList");
   // 지역값 설정한 공연 목록 추출
  	NodeList perforList1 = document1.getElementsByTagName("perforList");
 // 공연 목록을 담을 리스트 생성
    List<exhiDTO> perforItems = new ArrayList<>();
   // 지역값 설정 공연목록 담을 리스트 생성
    List<exhiDTO> perforItems1 = new ArrayList<>();
    // 공연 정보를 객체로 변환하여 리스트에 추가 

    
    // 지역값을 담은 공연정보 객체로 변환하여 리스트에 추가
       for (int i = 0; i < perforList1.getLength(); i++) {
        Node perforItem1 = perforList1.item(i);
        String seq = ((Element) perforItem1).getElementsByTagName("seq").item(0).getTextContent();
        String title = ((Element) perforItem1).getElementsByTagName("title").item(0).getTextContent();
        String place2 = ((Element) perforItem1).getElementsByTagName("place").item(0).getTextContent();
        String startDate = ((Element) perforItem1).getElementsByTagName("startDate").item(0).getTextContent();
        String endDate = ((Element) perforItem1).getElementsByTagName("endDate").item(0).getTextContent();
        String realmName = ((Element) perforItem1).getElementsByTagName("realmName").item(0).getTextContent();
        String area = ((Element) perforItem1).getElementsByTagName("area").item(0).getTextContent();
        String thumbnail = ((Element) perforItem1).getElementsByTagName("thumbnail").item(0).getTextContent();
        String gpsX = ((Element) perforItem1).getElementsByTagName("gpsX").item(0).getTextContent();
        String gpsY = ((Element) perforItem1).getElementsByTagName("gpsY").item(0).getTextContent();

        perforItems1.add(new exhiDTO(seq, title, place2, startDate, endDate, realmName, area, thumbnail, gpsX, gpsY));
        
        
    }
    
%>
<!DOCTYPE html>
<html>
<head>
<link href="../header.css" rel="stylesheet" type="text/css" />
<link href="../exhibition/Extibition.css" rel="stylesheet" type="text/css" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>전시회</title>
</head>

<body>

<%@include file = "../header.jsp" %>

<section  id="wrap">
<!-- 지역별 메뉴 -->
<form method = "get">
<div class="area-d">
<p class="ma">지역 : </p>
<a href="all.jsp" class="ma">전체</a>
<a href="allArea.jsp?sido=서울&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">서울</a>
<a href="allArea.jsp?sido=경기&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">경기</a>
<a href="allArea.jsp?sido=충북&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">충북</a>
<a href="allArea.jsp?sido=충남&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">충남</a>
<a href="allArea.jsp?sido=전북&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">전북</a>
<a href="allArea.jsp?sido=전남&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">전남</a>
<a href="allArea.jsp?sido=경북&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">경북</a>
<a href="allArea.jsp?sido=경남&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">경남</a>
<a href="allArea.jsp?sido=인천&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">인천</a>
<a href="allArea.jsp?sido=부산&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">부산</a>
<a href="allArea.jsp?sido=울산&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">울산</a>
<a href="allArea.jsp?sido=대구&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">대구</a>
<a href="allArea.jsp?sido=강원&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">강원</a>
<a href="allArea.jsp?sido=제주&cPage=1&sort=1&realmCode=<%=realmCode %>" class="ma">제주</a>
<div class = "sort-d">
<a href="allArea.jsp?sort=1&realmCode=<%= realmCode %>" class ="la">등록일순</a>
<a href="allArea.jsp?sort=2&realmCode=<%= realmCode %>" class ="la">공연명순</a>

</div>
</div>
</form>
<br>


<% 
for (exhiDTO perforItem1 : perforItems1) { %>
<div class="card">
	<div  class="card-img">
  		<img src="<%= perforItem1.getThumbnail() %>" class="card-img-top" alt="Thumbnail">
	</div>
    <div class="card-head">
		<h4 class="card-title"><%= perforItem1.getTitle() %></h4>
    </div>
    <hr>
    <div class="card-main">
		<p class="card-text">지역 : <%= perforItem1.getArea() %> <br>
		장소 : <%= perforItem1.getPlace() %> <br> 
		날짜 : <%= perforItem1.getStartDate() %>~<%= perforItem1.getEndDate() %></p>
    </div>
    <form action = "../exhibition/exhibitionDetail.jsp" method = "post">
    <input type = "hidden" name = "seq" value = "<%=perforItem1.getSeq()%>">
    <input type = "hidden" name = "thumb" value = "<%=perforItem1.getThumbnail()%>">
    <div class="card-footer">
  		<button type="submit" onclick="location.href='exhibitionDetail.jsp'">상세보기</button>
    </div>
    </form>
    </div>

<% }
	%>
 



<footer id = "footer">

 <!-- 페이징 처리 -->
  <div class="pagination">
        <ul>
       <!--  이전 페이지 링크 -->
            <% if (startPage > blockPage) { %>
                <li><a href="allArea.jsp?sido=<%= selectsido %>&cPage=<%= startPage - blockPage %>&sort=<%=sortkey%>&realmCode=<%=realmCode%>">&laquo;</a></li>
            <% } else { %>
            	<li><a href="allArea.jsp?sido=<%= selectsido %>&cPage=1&esort=<%=sortkey%>&realmCode=<%=realmCode%>">&laquo;</a></li>
			<% } %>
			
			 <!-- 페이지 번호 링크 -->
            <% for (int i = startPage; i <= endPage; i++) { %>
                <% if (i == pageNum) { %>
                    <li class="active"><a href="#"><%= i %></a></li>
                <% } else { %>
                    <li><a href="allArea.jsp?sido=<%= selectsido %>&cPage=<%= i %>&sort=<%=sortkey%>&realmCode=<%=realmCode%>"><%= i %></a></li>
                <% } %>
            <% } %>
				
				<!--  다음 페이지 링크 -->
            <% if (endPage < totalPage) { %>
                <li><a href="allArea.jsp?sido=<%= selectsido %>&cPage=<%= startPage + blockPage %>&sort=<%=sortkey%>&realmCode=<%=realmCode%>">&raquo;</a></li>
            <% } else { %>
            <li><a href="allArea.jsp?sido=<%= selectsido %>&cPage=<%= totalPage %>&sort=<%=sortkey%>&realmCode=<%=realmCode%>">&raquo;</a></li>
            <% } %>
        </ul>
    </div>
<br>

<%@include file = "../../footer/footer.jsp" %>
</footer>
</section>
</body>
</html>